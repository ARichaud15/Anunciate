<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html lang="es">
   <head>
        <title>Recuperar contraseña - Anunciate!</title>
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
                    <h3 class="inner-tittle t-inner">Recupera tu contraseña</h3>
                     <%
                        if(request.getAttribute("error") != null )
                        {
                            out.println("<p>"+request.getAttribute("error")+"</p>");
                        }
                    %>
                    
                    <form action="Enviar_correo" method="post">
                        <input type="email" name="Correo" required="" placeholder="Correo" />
                        <div class="submit">
                            <input type="submit" value="Enviar" >
                        </div>
                        <div class="clearfix"></div>
                        <div class="new">
                            <p class="sign"><a href="login.jsp">Regresar</a></p>
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
        <!--/404-->
        
        <!--js -->
        <script src="js/jquery.nicescroll.js"></script>
        <script src="js/scripts.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
