package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write('\r');
      out.write('\n');
   
    ServletContext contexto = request.getServletContext();
    HttpSession sesion = request.getSession();
    if(sesion.getAttribute("sessionID_usuarios") != null)
    {
        RequestDispatcher dashboard = contexto.getRequestDispatcher("/Negocios.jsp");
        dashboard.forward(request, response);
    }

      out.write("\r\n");
      out.write("<!DOCTYPE HTML>\r\n");
      out.write("<html lang=\"es\">\r\n");
      out.write("   <head>\r\n");
      out.write("        <title>Iniciar sesion - Anunciate!</title>\r\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n");
      out.write("        <meta name=\"keywords\" content=\"\" />\r\n");
      out.write("    \r\n");
      out.write("        <script type=\"application/x-javascript\"> addEventListener(\"load\", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>\r\n");
      out.write("        <script src=\"js/jquery-1.10.2.min.js\"></script>\r\n");
      out.write("        <link href=\"css/bootstrap.min.css\" rel='stylesheet' type='text/css' />\r\n");
      out.write("        <link href=\"css/style.css\" rel='stylesheet' type='text/css' />\r\n");
      out.write("        <link href=\"css/font-awesome.css\" rel=\"stylesheet\"> \r\n");
      out.write("        <link href='//fonts.googleapis.com/css?family=Roboto:700,500,300,100italic,100,400' rel='stylesheet' type='text/css'>\r\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/icon-font.min.css\" type='text/css' />\r\n");
      out.write("    </head> \r\n");
      out.write("\r\n");
      out.write("    <body>\r\n");
      out.write("        <!--/login-->\r\n");
      out.write("        <div class=\"error_page\">\r\n");
      out.write("            <!--/login-top-->\r\n");
      out.write("            <div class=\"error-top\">\r\n");
      out.write("                <h2 class=\"inner-tittle page\">Anunciate!</h2>\r\n");
      out.write("                <div class=\"login\">\r\n");
      out.write("                    <h3 class=\"inner-tittle t-inner\">Ingresa a tu cuenta</h3>\r\n");
      out.write("                     ");

                        if(request.getAttribute("error") != null )
                        {
                            out.println("<p>"+request.getAttribute("error")+"</p>");
                        }
                    
      out.write("\r\n");
      out.write("                    <div class=\"buttons login\">\r\n");
      out.write("                        <ul>\r\n");
      out.write("                            <li><a href=\"#\" class=\"hvr-sweep-to-right\">Facebook</a></li>\r\n");
      out.write("                            <li class=\"lost\"><a href=\"#\" class=\"hvr-sweep-to-left\">Twitter</a> </li>\r\n");
      out.write("                            <div class=\"clearfix\"></div>\r\n");
      out.write("                        </ul>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    \r\n");
      out.write("                    <form action=\"iniciar_sesion\" method=\"post\">\r\n");
      out.write("                        <input type=\"email\" name=\"Correo\" required=\"\" placeholder=\"Correo\" />\r\n");
      out.write("                        <input type=\"password\" name=\"Password\" required=\"\" placeholder=\"Contraseña\" />\r\n");
      out.write("                        <div class=\"submit\">\r\n");
      out.write("                            <input type=\"submit\" value=\"Iniciar sesion\" >\r\n");
      out.write("                        </div>\r\n");
      out.write("\r\n");
      out.write("                        <div class=\"clearfix\"></div>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("                        <div class=\"new\">\r\n");
      out.write("                            <p class=\"sign\"><a href=\"Registro_usuarios.jsp\">Crear una cuenta</a></p>\r\n");
      out.write("                            <p class=\"sign\"><a href=Recuperar_Pass.jsp>¿Olvidaste tu contraseña?</a></p>\r\n");
      out.write("                            <div class=\"clearfix\"></div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </form>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <!--//login-top-->\r\n");
      out.write("        </div>\r\n");
      out.write("        <!--//login-->\r\n");
      out.write("        <!--footer section start-->\r\n");
      out.write("        <div class=\"footer\">\r\n");
      out.write("            <div class=\"error-btn\"></div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <!--footer section end-->\r\n");
      out.write("       \r\n");
      out.write("       <!--js -->\r\n");
      out.write("        <script src=\"js/jquery.nicescroll.js\"></script>\r\n");
      out.write("        <script src=\"js/scripts.js\"></script>\r\n");
      out.write("        <script src=\"js/bootstrap.min.js\"></script>\r\n");
      out.write("    </body>\r\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
