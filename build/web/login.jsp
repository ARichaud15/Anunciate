<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%   
    ServletContext contexto = request.getServletContext();
    HttpSession sesion = request.getSession();
    if(sesion.getAttribute("sessionID_usuarios") != null)
    {
        RequestDispatcher dashboard = contexto.getRequestDispatcher("/Negocios.jsp");
        dashboard.forward(request, response);
    }
%>
<!DOCTYPE HTML>
<html lang="es">
   <head>
        <title>Iniciar sesion - Anunciate!</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="" />
    
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <script src="js/jquery-1.10.2.min.js"></script>
        <link href="css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="css/style.css" rel='stylesheet' type='text/css' />
        <link href="css/font-awesome.css" rel="stylesheet"> 
        <link href='//fonts.googleapis.com/css?family=Roboto:700,500,300,100italic,100,400' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="css/icon-font.min.css" type='text/css' />
    </head> 

    <body>
        <!--/login-->
        <div class="error_page">
            <!--/login-top-->
            <div class="error-top">
                <h2 class="inner-tittle page">Anunciate!</h2>
                <div class="login">
                    <h3 class="inner-tittle t-inner">Ingresa a tu cuenta</h3>
                     <%
                        if(request.getAttribute("error") != null )
                        {
                            out.println("<p>"+request.getAttribute("error")+"</p>");
                        }
                    %>
                    <div class="buttons login">
                        <ul>
                            <li><a href="#" class="hvr-sweep-to-right">Facebook</a></li>
                            <li class="lost"><a href="#" class="hvr-sweep-to-left">Twitter</a> </li>
                            <div class="clearfix"></div>
                        </ul>
                    </div>
                    
                    <form action="iniciar_sesion" method="post">
                        <input type="email" name="Correo" required="" placeholder="Correo" />
                        <input type="password" name="Password" required="" placeholder="Contraseña" />
                        <div class="submit">
                            <input type="submit" value="Iniciar sesion" >
                        </div>

                        <div class="clearfix"></div>
																		
                        <div class="new">
                            <p class="sign"><a href="Registro_usuarios.jsp">Crear una cuenta</a></p>
                            <p class="sign"><a href=Recuperar_Pass.jsp>¿Olvidaste tu contraseña?</a></p>
                            <div class="clearfix"></div>
                        </div>
                    </form>
                </div>
            </div>
            <!--//login-top-->
        </div>
        <!--//login-->
        <!--footer section start-->
        <div class="footer">
            <div class="error-btn"></div>
        </div>
        <!--footer section end-->
       
       <!--js -->
        <script src="js/jquery.nicescroll.js"></script>
        <script src="js/scripts.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>