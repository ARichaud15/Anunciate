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
        <title>Informacion general - Anunciate!</title>
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
        <script type="text/javascript" src= "js/setMap_aux.js"> </script>
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
                                <li><a href="Negocios.jsp">Mis negocios</a></li>
                                <li class="active">Datos del negocio</li>
                            </ol>
                        </div>
                        <%
                            
                            if(request.getAttribute("error") != null )
                            {
                                out.println("<p>"+request.getAttribute("error")+"</p>");
                            }
                            
                            int ID_negocios = Integer.parseInt(request.getParameter("negocio"));
                            sesion.setAttribute("sessionID_negocios", ID_negocios);
                            
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
                            
                            query = "SELECT negocios.*, giro_negocios.Giro FROM negocios INNER JOIN giro_negocios ON negocios.Giro_negocios = giro_negocios.ID_giro WHERE ID_negocios = " + ID_negocios + "";
                            synchronized(statment)
                            {   
                                resultSet = statment.executeQuery(query);
                            }
                            
                            if(resultSet.next())
                            {
                                
                        %>
                        
                        <div class="forms-main">
                            <h2 class="inner-tittle">Datos del negocio</h2>
                            <div class="graph-form">
                                <div class="validation-form">
                                        
                                        <div class="vali-form">
                                            
                                            <% out.println("<input type='text' name='ID_negocios' style='display:none' readonly='readonly' value=" +resultSet.getString("ID_negocios")+">"); %>
                                            <button type="button" value="Valoraciones" class="btn btn-primary" data-toggle="modal" data-target="#Modal_valoraciones">Comentarios y valoraciones</button>
                                            
                                                
                                                
                                            
                                            <div class="col-md-12 form-group1 group-mail">
                                                <label class="control-label">Nombre del negocio*</label>
                                                <% 
                                                    out.println("<input type='text' name='Nombre_Neg' readonly='readonly' value='" +resultSet.getString("Nombre_negocios")+"'>");
                                                %>
                                            </div>
                                            
                                            <div class="col-md-12 form-group1 group-mail">
                                                <label class="control-label">Giro del negocio*</label>
                                                <% out.println("<input type='text' name='Giro_Neg' readonly='readonly' value='" +resultSet.getString("Giro")+"'>");%>
                                            </div>
                                            
                                            <div class="col-md-12 form-group1 group-mail">
                                                <script>
                                                    var coords = "<%= resultSet.getString("Coordenadas_negocios") %>";
                                                </script>
                                                <div id="map"></div>
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Codigo postal*</label>
                                                <% out.println("<input type='number' id='Codigo_postal' name='Codigo_postal' readonly='readonly' value='" +resultSet.getString("CP_negocios")+"'>");%>
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Calle*</label>
                                                <input type="text" id="Calle" name="Calle" required="" readonly="readonly">
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Numero exterior*</label>
                                                <% out.println("<input type='text'id='Numero_exterior' name='Numero_exterior' readonly='readonly' required='' value='" +resultSet.getString("NumExt_negocios")+"'>");%>
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Numero interior</label>
                                                <% out.println("<input type='text' id='Numero_interior' name='Numero_interior' readonly='readonly' value='" +resultSet.getString("NumInt_negocios")+"'>");%>
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Colonia*</label>
                                                <input type="text" id="Colonia" name="Colonia" required="" readonly="readonly">
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Municipio*</label>
                                                <input type="text" id="Municipio" name="Municipio" required="" readonly="readonly">
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Ciudad*</label>
                                                <input type="text" id="Ciudad" name="Ciudad" required="" readonly="readonly">
                                            </div>
                                            
                                             <div class="col-md-4 form-group1">
                                                <label class="control-label">Estado*</label>
                                                <input type="text" id="Estado" name="Estado" required="" readonly="readonly">
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <label class="control-label">Telefono del negocio*</label>
                                                <% out.println("<input type='number' name='Telefono' readonly='readonly' required='' value='" +resultSet.getString("Telefono_negocios")+"'>");%>
                                            </div>
                                            
                                            <div class="clearfix"> </div>
                                            <br>
                                            <h4>Horario</h4>
                                            <div class="col-md-4 form-group1">
                                                <h4>Lunes a viernes</h4>
                                                <label class="control-label">Desde</label>
                                                <% out.println("<input type='time' name='Desde_L' readonly='readonly' value='" +resultSet.getString("HrLunesDs_negocios")+"'>");%>
                                                
                                                <label class="control-label">Hasta</label>
                                                <% out.println("<input type='time' name='Hasta_L' readonly='readonly' value='" +resultSet.getString("HrLunesHs_negocios")+"'>");%>
                                            </div>
                                            
                                             <div class="col-md-4 form-group1">
                                                <h4>Sabado</h4>
                                                <label class="control-label">Desde</label>
                                                <% out.println("<input type='time' name='Desde_S' readonly='readonly' value='" +resultSet.getString("HrSabadoDs_negocios")+"'>");%>
                                                
                                                <label class="control-label">Hasta</label>
                                                <% out.println("<input type='time' name='Hasta_S' readonly='readonly' value='" +resultSet.getString("HrSabadoHs_negocios")+"'>");%>
                                            </div>
                                            
                                            <div class="col-md-4 form-group1">
                                                <h4>Domingo</h4>
                                                <label class="control-label">Desde</label>
                                                <label class="control-label">Desde</label>
                                                <% out.println("<input type='time' name='Desde_D' readonly='readonly' value='" +resultSet.getString("HrDomingoDs_negocios")+"'>");%>
                                                
                                                <label class="control-label">Hasta</label>
                                                <% out.println("<input type='time' name='Hasta_D' readonly='readonly' value='" +resultSet.getString("HrDomingoHs_negocios")+"'>");}%>
                                            </div>
                                            
                                            <div class="clearfix"> </div>
                                            <br>
                                            <h4>Productos</h4>
                                            <div class="col-md-12 form-group1">
                                                <div class="table-responsive">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">Producto</th>
                                                                <th scope="col">Descripcion</th>
                                                                <th scope="col">Precio</th>
                                                            </tr>
                                                        </thead>
                                                        
                                                        <tbody>
                                                            <%
                                                                int band = 0;
                                                                    
                                                                query = "SELECT * FROM productos WHERE ID_negocios = " + ID_negocios + "";
                                                                synchronized(statment)
                                                                {   
                                                                    resultSet = statment.executeQuery(query);
                                                                }

                                                                while(resultSet.next())
                                                                {
                                                                    out.println("<tr>");
                                                                        out.println("<td>" +resultSet.getString("Nombre_productos")+"</td>");
                                                                        out.println("<td>" +resultSet.getString("Descripcion_productos")+"</td>");
                                                                        out.println("<td>" +resultSet.getString("Precio_productos")+"</td>");
                                                                    out.println("</tr>");
                                                                    band++;
                                                                }
                                                                    
                                                                if(band == 0)
                                                                {
                                                                    out.println("<tr>");
                                                                        out.println("<td colspan='3'><center><h4>No hay productos registrados</h4></center></td>");
                                                                    out.println("</tr>");
                                                                }
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <button type="button" value="Agregar" class="btn btn-primary" data-toggle="modal" data-target="#Modal_productos">Agregar producto</button>

                                                                    <a href="Detalles_productos.jsp">
                                                                        <button type="submit" value="Modificar" class="btn btn-primary">Modificar productos</button>
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            
                                            <div class="clearfix"> </div>
                                            <br>
                                            <h4>Promociones</h4>
                                            <div class="col-md-12 form-group1">
                                               <div class="table-responsive">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">Promocion</th>
                                                                <th scope="col">Vigencia</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                int band1 = 0;
                                                                    
                                                                query = "SELECT * FROM promociones WHERE ID_negocios = " + ID_negocios + "";
                                                                synchronized(statment)
                                                                {   
                                                                    resultSet = statment.executeQuery(query);
                                                                }
                                                                while(resultSet.next())
                                                                {
                                                                    out.println("<tr>");
                                                                        out.println("<td>" +resultSet.getString("promocion")+"</td>");
                                                                        out.println("<td>" +resultSet.getString("VigenciaIni_promociones")+" - "+resultSet.getString("VigenciaFin_promociones")+" </td>");
                                                                    out.println("</tr>");
                                                                    band1++;
                                                                }
                                                                if(band1 == 0)
                                                                {
                                                                    out.println("<tr>");
                                                                        out.println("<td colspan='2'><center><h4>No hay promociones vigentes</h4></center></td>");
                                                                    out.println("</tr>");
                                                                }
                                                            %>
                                                           <tr>
                                                                <td>
                                                                    <button type="button" value="Agregar" class="btn btn-primary" data-toggle="modal" data-target="#Modal_promociones">Agregar promocion</button>

                                                                    <a href="Detalles_promociones.jsp">
                                                                        <button type="submit" value="Modificar" class="btn btn-primary">Modificar promociones</button>
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="clearfix"> </div>
                                        </div>
                                    
                                        <div class="modal fade" id="Modal_productos" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h2 class="modal-title">Agregar productos</h2>
                                                    </div>
                                                    
                                                    <form action="Agregar_productos" method="post">
                                                        <div class="modal-body">
                                                            <div class="col-md-4 form-group1">
                                                                <h4>Nombre</h4>
                                                                <input type="text" name="Nombre_productos" required="">
                                                            </div>
                                                            <div class="col-md-4 form-group1">
                                                                <h4>Precio</h4>
                                                                <input type="text" name="Precio_productos" required="" onkeyup="validaFloat(this.value)">
                                                            </div>
                                                            <div class="col-md-4 form-group1">
                                                                <h4>Descripcion</h4>
                                                                <textarea type="text" name="Descripcion_productos" required=""></textarea>
                                                            </div>
                                                        </div>

                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                                                            <button type="submit" value="Agregar" class="btn btn-primary">Agregar producto</button>
                                                        </div>
                                                    </form>
                                                 </div><!-- /.modal-content -->
                                            </div><!-- /.modal-dialog -->
                                        </div>
                                                                
                                        <div class="modal fade" id="Modal_promociones" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h2 class="modal-title">Agregar promociones</h2>
                                                    </div>
                                                    
                                                    <form action="Agregar_promociones" method="post">
                                                        <div class="modal-body">
                                                            <div class="col-md-4 form-group1">
                                                                <h4>Promocion</h4>
                                                                <input type="text" name="Promocion" required="">
                                                            </div>
                                                            <div class="col-md-4 form-group1">
                                                                <h4>Fecha de inicio</h4>
                                                                <input type="date" name="Vigencia_ini" required="">
                                                            </div>
                                                            <div class="col-md-4 form-group1">
                                                                <h4>Fecha de finalizacion</h4>
                                                                <input type="date" name="Vigencia_fin" required="">
                                                            </div>
                                                        </div>

                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                                                            <button type="submit" value="Agregar" class="btn btn-primary">Agregar promocion</button>
                                                        </div>
                                                    </form>
                                                 </div><!-- /.modal-content -->
                                            </div><!-- /.modal-dialog -->
                                        </div>
                                                           
                                        <div class="modal fade" id="Modal_valoraciones" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h2 class="modal-title">Comentarios y valoraciones</h2>
                                                    </div>
                                                    
                                                    <div class="modal-body">
                                                        
                                                        <div class="vali-form">
                                                            <div class="clearfix"> </div>
                                                            <h4> Valoraciones</h4>
                                                            <div class="col-lg-4 dev-col">
                                                                <div class="dev-widget-transparent">
                                                                    <div class="table-responsive">
                                                                        <table class="table">
                                                                            <tbody>
                                                                                <%
                                                                                    query = "SELECT * FROM valoraciones WHERE ID_negocios = " + sesion.getAttribute("sessionID_negocios") + "";
                                                                                    synchronized(statment)
                                                                                    {   
                                                                                        resultSet = statment.executeQuery(query);
                                                                                    }

                                                                                    if(resultSet.next())
                                                                                    {
                                                                                        out.println("<tr>");
                                                                                            out.println("<td><i class='fa fa-thumbs-o-down'></i><span>"+resultSet.getString("pulgares_abajo")+"</span></td>");
                                                                                            out.println("<td><i class='fa fa-thumbs-o-up'></i><span>"+resultSet.getString("pulgares_arriba")+"</span></td>");
                                                                                        out.println("</tr>");
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        out.println("<tr>");
                                                                                            out.println("<td><i class='fa fa-thumbs-o-down'></i><span>0</span></td>");
                                                                                            out.println("<td><i class='fa fa-thumbs-o-up'></i><span>0</span></td>");
                                                                                        out.println("</tr>");
                                                                                    }
                                                                                %>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                            
                                                            <div class="clearfix"> </div>
                                                            <br>
                                                            <h4>Comentarios</h4>
                                            
                                                            <div class="table-responsive">
                                                                <table class="table">
                                                                    <thead>
                                                                        <tr>
                                                                            <th scope="col">Comentario</th>
                                                                            <th scope="col">Fecha</th>
                                                                            <th scope="col">Persona</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <%
                                                                            boolean band3 = false;

                                                                            query = "SELECT * FROM comentarios WHERE ID_negocios = " + sesion.getAttribute("sessionID_negocios") + "";
                                                                            synchronized(statment)
                                                                            {   
                                                                                resultSet = statment.executeQuery(query);
                                                                            }

                                                                            while(resultSet.next())
                                                                            {
                                                                                out.println("<tr>");
                                                                                    out.println("<td>" +resultSet.getString("comentario")+"</td>");
                                                                                    out.println("<td>" +resultSet.getString("fecha")+"</td>");
                                                                                    out.println("<td>" +resultSet.getString("persona")+"</td>");
                                                                                out.println("</tr>");
                                                                                band3 = true;
                                                                            }

                                                                            if(band3 == false)
                                                                            {
                                                                                out.println("<tr>");
                                                                                    out.println("<td colspan='3'><center><h4>No hay comentarios registrados</h4></center></td>");
                                                                                out.println("</tr>");
                                                                            }
                                                                        %>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="clearfix"> </div>
                                                    </div>
                                                    
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                                                    </div>
                                                </div>
                                            </div><!-- /.modal-content -->
                                        </div><!-- /.modal-dialog -->
                                </div>
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
            
            <script>
                function validaFloat(numero)
                {
                  if (!/^([0-9])*[.]?[0-9]*$/.test(numero))
                   alert("El valor " + numero + " no es un número");
                }
            </script>
        <script src="js/jquery.nicescroll.js"></script>
        <script src="js/scripts.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>