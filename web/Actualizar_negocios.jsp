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
        <title>Actualizar datos del negocio - Anunciate!</title>
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
        <script type="text/javascript" src= "js/setAddress.js"> </script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCs3hSG5XSDKcjYUx3EMxExbnvLKfxomTo&libraries=geometry&callback=initMap"
         async defer></script>
       
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
                                <li><a href="Administrador.jsp">Administrador</a></li>
                                <li class="active">Datos del negocio</li>
                                <li class="active">Actualizar datos del negocio</li>
                            </ol>
                        </div>
                        <%
                            if(request.getAttribute("error") != null )
                            {
                                out.println("<p>"+request.getAttribute("error")+"</p>");
                            }
                            
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
                            String query = null;
                            
                            query = "SELECT * FROM negocios WHERE ID_negocios = " + sesion.getAttribute("sessionID_negocios") + "";
                            synchronized(statment)
                            {   
                                resultSet = statment.executeQuery(query);
                            }
                            
                            if(resultSet.next())
                            {
                                
                        %>
                        
                        <div class="forms-main">
                            <h2 class="inner-tittle">Actualizar datos del negocio</h2>
                            <div class="graph-form">
                                <div class="validation-form">
                                    <form action="Actualizar_negocios" method="post">
                                        <div class="vali-form">
                                            <div class="col-md-12 form-group1 group-mail">
                                                <label class="control-label">Nombre del negocio*</label>
                                                <% 
                                                    out.println("<input type='text' name='ID_negocios' style='display:none' readonly='readonly' value=" +resultSet.getString("ID_negocios")+">");
                                                    out.println("<input type='text' name='Nombre_Neg' placeholder='Nombre del negocio...' required='' value='" +resultSet.getString("Nombre_negocios")+"'>");
                                                }
                                                %>
                                            </div>
                                            
                                            <div class="clearfix"> </div>
                                                <div class="form-group">
                                                    <label for="selector2" class="col-sm-2 control-label">Giro del negocio*</label>
                                                        <%
                                                           query = "SELECT * FROM giro_negocios";
                                                           synchronized(statment)
                                                           {
                                                               resultSet = statment.executeQuery(query);
                                                           }
                                                       %>
                                                        <div class="col-sm-8">
                                                            <select id="Giro_Neg" name="Giro_Neg" required="" class="form-control1">
                                                                <%
                                                                    while(resultSet.next())
                                                                    {
                                                                        out.println("<option value ='"+resultSet.getString("ID_giro")+"'>"+resultSet.getString("Giro")+"</option>");
                                                                    }
                                                                %>
                                                            </select>
                                                        </div>
                                                </div>
                                            <div class="clearfix"> </div>
                                            <%
                                                query = "SELECT * FROM negocios WHERE ID_negocios = " + sesion.getAttribute("sessionID_negocios") + "";
                                                synchronized(statment)
                                                {   
                                                    resultSet = statment.executeQuery(query);
                                                }

                                                if(resultSet.next())
                                                {
                                            %>
                                            <div class="col-md-12 form-group1 group-mail">
                                                <script>
                                                    var coords = "<%= resultSet.getString("Coordenadas_negocios") %>";
                                                    
                                                </script>
                                                <div id="map"></div>
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Codigo postal*</label>
                                                <% out.println("<input type='number' id='Codigo_postal' name='Codigo_postal' placeholder='Codigo postal' required='' value='" +resultSet.getString("CP_negocios")+"'>");%>
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Calle*</label>
                                                <input type="text" id="Calle" name="Calle" placeholder="Obligatorio" required="" readonly="readonly">
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Numero exterior*</label>
                                                <% out.println("<input type='text'id='Numero_exterior' name='Numero_exterior' placeholder='Numero_exterior' required='' value='" +resultSet.getString("NumExt_negocios")+"'>");%>
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Numero interior</label>
                                                <% out.println("<input type='text' id='Numero_interior' name='Numero_interior' placeholder='Numero_interior' value='" +resultSet.getString("NumInt_negocios")+"'>");%>
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Colonia*</label>
                                                <input type="text" id="Colonia" name="Colonia" placeholder="Colonia" required="" readonly="readonly">
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Municipio*</label>
                                                <input type="text" id="Municipio" name="Municipio" placeholder="Municipio" required="" readonly="readonly">
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Ciudad*</label>
                                                <input type="text" id="Ciudad" name="Ciudad" placeholder="Ciudad" required="" readonly="readonly">
                                            </div>
                                            
                                             <div class="col-md-4 form-group1">
                                                <label class="control-label">Estado*</label>
                                                <input type="text" id="Estado" name="Estado" placeholder="Estado" required="" readonly="readonly">
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Telefono del negocio*</label>
                                                <% out.println("<input type='number' name='Telefono' placeholder='Telefono...' required='' maxlength='10' value='" +resultSet.getString("Telefono_negocios")+"'>");%>
                                                
                                                <input type="text" id="Coordenadas" name="Coordenadas"  style="display:none" readonly="readonly">
                                            </div>
                                            
                                            <div class="clearfix"> </div>
                                            <br>
                                            <h4>Horario</h4>
                                            <div class="col-md-4 form-group1">
                                                <h4>Lunes a viernes</h4>
                                                <label class="control-label">Desde</label>
                                                <% out.println("<input type='time' name='Desde_L' value='" +resultSet.getString("HrLunesDs_negocios")+"'>");%>
                                                
                                                <label class="control-label">Hasta</label>
                                                <% out.println("<input type='time' name='Hasta_L' value='" +resultSet.getString("HrLunesHs_negocios")+"'>");%>
                                            </div>
                                            
                                             <div class="col-md-4 form-group1">
                                                <h4>Sabado</h4>
                                                <label class="control-label">Desde</label>
                                                <% out.println("<input type='time' name='Desde_S' value='" +resultSet.getString("HrSabadoDs_negocios")+"'>");%>
                                                
                                                <label class="control-label">Hasta</label>
                                                <% out.println("<input type='time' name='Hasta_S' value='" +resultSet.getString("HrSabadoHs_negocios")+"'>");%>
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <h4>Domingo</h4>
                                                <label class="control-label">Desde</label>
                                                <label class="control-label">Desde</label>
                                                <% out.println("<input type='time' name='Desde_D' value='" +resultSet.getString("HrDomingoDs_negocios")+"'>");%>
                                                
                                                <label class="control-label">Hasta</label>
                                                <% out.println("<input type='time' name='Hasta_D' value='" +resultSet.getString("HrDomingoHs_negocios")+"'>");}%>
                                            </div>
                                            
                                             <div class="col-md-12 form-group button-2">
                                                 <center><button type="submit" value="Actulizar" class="btn btn-primary">Actualizar</button></center>
                                            </div>
                                            <div class="clearfix"> </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
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
                        <p><% out.println(sesion.getAttribute("sessionRol_usuarios")); %></p>
                        <ul>
                            <li><a class="tooltips" href="Actualizar_usuario.jsp"><span>Perfil</span><i class="lnr lnr-user"></i></a></li>
                            <li><a class="tooltips" href="cerrar_sesion"><span>Cerrar sesion</span><i class="lnr lnr-power-switch"></i></a></li>
                        </ul>
                    </div>
                    <!--//down-->

                    <div class="menu">
                        <ul id="menu" >
                            <li>
                                <a href="Administrador.jsp">
                                    <i class="fa fa-tachometer"></i> 
                                    <span> Panel de administracion </span> 
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