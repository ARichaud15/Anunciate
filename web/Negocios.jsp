<%@page import="java.util.logging.Logger" import="java.sql.*" import="java.util.logging.Level"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%   
    ServletContext contexto = request.getServletContext();
    HttpSession sesion = request.getSession();
    if(sesion.getAttribute("sessionID_usuarios") == null)
    {
        request.setAttribute("error", "No se a iniciado sesion");
        RequestDispatcher dashboard = contexto.getRequestDispatcher("/login.jsp");
        dashboard.forward(request, response);
    }
%>

<!DOCTYPE HTML>
<html>
    <head>
        <title>Mis negocios - Anunciate!</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="" />
        
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <link href="css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="css/style.css" rel='stylesheet' type='text/css' />
        <link href="css/font-awesome.css" rel="stylesheet"> 
        <link href='//fonts.googleapis.com/css?family=Roboto:700,500,300,100italic,100,400' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="css/icon-font.min.css" type='text/css' />
        
        <script src="js/jquery-1.10.2.min.js"></script>
    </head> 
    
    <body>
        <div class="page-container">
            <!--/content-inner-->
            <div class="left-content">
                <div class="inner-content">
                    <!-- header-starts -->
                    <div class="header-section">
                        <!--menu-right-->
                        <div class="top_menu">
                            <!--/profile_details-->
                            <div class="profile_details_left">
                                <ul class="nofitications-dropdown">
                                    <li class="dropdown note">
                                        <a><span class="badge blue1"></span></a>
                                    </li>		   							   		
                                    <div class="clearfix"></div>	
				</ul>
                            </div>
                            <div class="clearfix"></div>	
                            <!--//profile_details-->
			</div>
			<!--//menu-right-->
			<div class="clearfix"></div>
                    </div>
                    <!-- //header-ends -->
                    <div class="outter-wp">
                        <div class="sub-heard-part">
                            <ol class="breadcrumb m-b-0">
                                <li><a href="Negocios.jsp">Mis negocios</a></li>
                            </ol>
                        </div>
                        <%
                            if(request.getAttribute("error") != null )
                            {
                                out.println("<p>"+request.getAttribute("error")+"</p>");
                            }
                        %>
                        
                        <!--/charts-->
                        <div class="charts">
                            <div class="chrt-inner">
                                <!--/bottom-grids-->		 
                                <div class="bottom-grids">
                                    <div class="dev-table">
                                        <%
                                            Statement statment = null;
                                            Connection conexion = null;

                                            String Driver = "com.mysql.jdbc.Driver";
                                            String URL = "jdbc:mysql://localhost:3306/prueba";
                                            String user = "root";
                                            String password = "";

                                            Class.forName(Driver).newInstance();
                                            conexion = DriverManager.getConnection(URL, user, password);
                                            statment = conexion.createStatement();    
                                            
                                            
                                            ResultSet resultSet = null;
                                            ResultSet resultSetAux = null;
                                            String query = null;
                                            int band = 0;
                                            
                                            query = "SELECT giro_negocios.Giro, negocios.Nombre_negocios,negocios.ID_negocios FROM negocios INNER JOIN giro_negocios ON negocios.Giro_negocios = giro_negocios.ID_giro WHERE negocios.ID_usuarios ="+ sesion.getAttribute("sessionID_usuarios") + "";
                                                synchronized(statment)
                                                {
                                                    resultSet = statment.executeQuery(query);
                                                }
                                                
                                                while(resultSet.next())
                                                {
                                                    out.println("<div class='col-md-4 dev-col'>");
                                                        out.println("<div class='dev-widget dev-widget-transparent'>");
                                                            out.println("<h2 class='inner one'>"+ resultSet.getString("Nombre_negocios") +"</h2>");
                                                            out.println("<p>"+ resultSet.getString("Giro") +"</p>");
                                                            
                                                            out.println("<a href='Datos_negocios.jsp?negocio="+resultSet.getString("ID_negocios")+"' class='dev-drop'>Mas detalles<span class='fa fa-angle-right pull-right'></span></a>");
                                                        out.println("</div>");
                                                    out.println("</div>");
                                                    band++;
                                                }
                                                
                                                if(band == 0)
                                                {
                                                    out.println("<div class='col-md-4 dev-col'>");
                                                        out.println("<div class='dev-widget dev-widget-transparent'>");
                                                            out.println("<h2 class='inner one'>No hay negocios registrados</h2>");
                                                            
                                                            out.println("<a href='Registro_negocios.jsp' class='dev-drop'>Registrar un negocio<span class='fa fa-angle-right pull-right'></span></a>");
                                                        out.println("</div>");
                                                    out.println("</div>");
                                                }
                                          
                                            
                                        %>
					<div class="clearfix"></div>		
                                    </div>
                                </div>
                                <!--//bottom-grids-->
                            </div>
                            <!--/charts-inner-->
                        </div>
                        <!--//outer-wp-->
                    </div>
                    
                    <footer>
                        <p>© 2018 Anunciate!. Derechos Reservados</p>
                    </footer>
                    
                </div>
            </div>
            
            <!--/sidebar-menu-->
            <div class="sidebar-menu">
                <header class="logo">
                    <a href="#" class="sidebar-icon"> <span class="fa fa-bars"></span> </a> 
                </header>
			
                <div style="border-top:1px solid rgba(69, 74, 84, 0.7)"></div>
		<!--/down-->
                    <div class="down">	
			<a></a>
                        <a><span class=" name-caret">
                            <% 
                                out.println(sesion.getAttribute("sessionNombre_usuarios"));
                                out.println(sesion.getAttribute("sessionApellidoPa_usuarios"));
                            %>
                        </span></a>
                            <p><% out.println(sesion.getAttribute("sessionRol_usuarios"));; %></p>
                        <ul>
                            <li><a class="tooltips" href="Actualizar_usuario.jsp"><span>Perfil</span><i class="lnr lnr-user"></i></a></li>
                            <li><a class="tooltips" href="cerrar_sesion"><span>Cerrar sesion</span><i class="lnr lnr-power-switch"></i></a></li>
                        </ul>
                    </div>
                    <!--//down-->

                    <div class="menu">
                        <ul id="menu" >
                            <li>
                                <a href="Negocios.jsp">
                                    <i class="fa fa-tachometer"></i> 
                                    <span> Mis negocios </span> 
                                </a>
                            </li>
                            
                            <li id="menu-academico" >
                                <a href="Registro_negocios.jsp">
                                    <i class="fa fa-thumb-tack"></i> 
                                    <span> Registrar un negocio </span> 
                                 </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="clearfix"></div>		
            </div>
            
            <script>
                var toggle = true;
                $(".sidebar-icon").click(function() 
                {                
                    if (toggle)
                    {
                        $(".page-container").addClass("sidebar-collapsed").removeClass("sidebar-collapsed-back");
                        $("#menu span").css({"position":"absolute"});
                    }
                    else
                    {
                        $(".page-container").removeClass("sidebar-collapsed").addClass("sidebar-collapsed-back");
                        setTimeout(function() 
                        {
                            $("#menu span").css({"position":"relative"});
                        }, 400);
                    }
                    toggle = !toggle;
                });
            </script>
        <script src="js/jquery.nicescroll.js"></script>
        <script src="js/scripts.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>