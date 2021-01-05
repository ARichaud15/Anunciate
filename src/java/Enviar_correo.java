import java.io.IOException;
import java.io.PrintWriter;

import java.util.logging.Level;
import java.util.logging.Logger;

import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Enviar_correo extends HttpServlet 
{
    private Statement statment = null;
    private Connection conexion = null;
    
    // Definimos el driver y la url
    String Driver = "com.mysql.jdbc.Driver";
    String URL = "jdbc:mysql://localhost:3306/prueba";
    String user = "root";
    String password = "";

    @Override
    public void init(ServletConfig config) 
    {
        try 
        {
            Class.forName(Driver).newInstance();
            conexion = DriverManager.getConnection(URL, user, password);
            statment = conexion.createStatement();
        } 
        catch (ClassNotFoundException ex) 
        {
            Logger.getLogger(Enviar_correo.class.getName()).log(Level.SEVERE,
                "No se pudo cargar el driver de la base de datos", ex);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(Enviar_correo.class.getName()).log(Level.SEVERE,
                "No se pudo obtener la conexión a la base de datos", ex);
        } 
        catch (InstantiationException ex) 
        {
            Logger.getLogger(Enviar_correo.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (IllegalAccessException ex) 
        {
            Logger.getLogger(Enviar_correo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        ServletContext contexto = request.getServletContext();
        String Correo = request.getParameter("Correo");
        
        if(VerificarCorreo(request, response, Correo))
        {
            try 
            {
                EnviarCorreo(request, response, Correo);
            } 
            catch (AddressException ex) 
            {
                Logger.getLogger(Enviar_correo.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("error", "Hemos enviado tu contraseña a tu correo");
            RequestDispatcher PaginaError = contexto.getRequestDispatcher("/login.jsp");
            PaginaError.forward(request, response);
        }
        else
        {
            request.setAttribute("error", "No tenemos su correo registrado");
            RequestDispatcher PaginaError = contexto.getRequestDispatcher("/Recuperar_Pass.jsp");
            PaginaError.forward(request, response);
        }
    }
    
    private boolean VerificarCorreo(HttpServletRequest request, HttpServletResponse response, String Correo)throws ServletException, IOException 
    {
        ResultSet resultSet = null;
        String query = null;
        
        query = "SELECT * FROM usuarios WHERE Correo_usuarios = '" + Correo + "'";
        
        try 
        {
            synchronized(statment)
            {
                resultSet = statment.executeQuery(query);
            }
            return resultSet.next();
        }
        catch (SQLException ex) 
        {
            gestionarErrorEnConsultaSQL(ex, request, response);
        }
        finally 
        {
            if (resultSet != null) 
            {
                try 
                {
                    resultSet.close();
                } 
                catch (SQLException ex) 
                {
                    Logger.getLogger(iniciar_sesion.class.getName()).log(Level.SEVERE,
                        "No se pudo cerrar el Resulset", ex);
                }
            }
        }
        return false;
    }
    
    public void EnviarCorreo (HttpServletRequest request, HttpServletResponse response, String Correo)throws ServletException, IOException, AddressException
    {
        Calendar calendario = new GregorianCalendar();
        
        ResultSet resultSet = null;
        String query = null;
        int hora, minutos;
        String dia, mes, año;
        
        hora =calendario.get(Calendar.HOUR_OF_DAY);
        minutos = calendario.get(Calendar.MINUTE);
        dia = Integer.toString(calendario.get(Calendar.DATE));
        mes = Integer.toString(calendario.get(Calendar.MONTH));
        año = Integer.toString(calendario.get(Calendar.YEAR));
        
        String host = "smtp.gmail.com";
        String asunto = "";
        String correo_pr = "anunciate.webservice@gmail.com";
        String clave = "3738336136";
        
        Properties prop = System.getProperties();
        prop.put("mail.smtp.starttls.enable","true");
        prop.put("mail.smtp.host", host);
        prop.put("mail.smtp.user", correo_pr);
        prop.put("mail.smtp.password", clave);
        prop.put("mail.smtp.port",587);
        prop.put("mail.smtp.auth","true");
        
        query = "SELECT * FROM usuarios WHERE Correo_usuarios = '" + Correo + "'";
        
        try 
        {
            synchronized(statment)
            {
                resultSet = statment.executeQuery(query);
            }
            
            if(resultSet.next())
            {
                String Contraseña = resultSet.getString("Contrasena_usuarios");
                String Nombre = resultSet.getString("Nombre_usuarios") + resultSet.getString("ApellidoPa_usuarios");
                
                String mensaje = "¿Has olvidado tu contraseña?\n"
                        + "Anunciate! ha recibido una solicitud para\n"
                        + "recuperar la contraseña de tu cuenta "+Correo+"\n"
                        + "el dia "+dia+"/"+mes+"/"+año+" a las "+hora+":"+minutos+"\n\n"
                        + "Esta es tu contraseña: "+Contraseña+" ";
                
                try
                {
                    Session sesion = Session.getDefaultInstance(prop,null);
                    MimeMessage message = new MimeMessage(sesion);

                    message.setFrom(new InternetAddress(Correo));
                    message.setRecipient(Message.RecipientType.TO, new InternetAddress(Correo));
                    message.setSubject("Recuperacion de contraseña");
                    message.setText(mensaje);

                    Transport transport = sesion.getTransport("smtp");
                    transport.connect(host,correo_pr,clave);
                    transport.sendMessage(message, message.getAllRecipients());
                    transport.close();
                }
                catch(Exception e)
                {
                    e.printStackTrace();
                }
            }
        }
        catch (SQLException ex) 
        {
            gestionarErrorEnConsultaSQL(ex,  request, response);
        }
        finally 
        {
            if (resultSet != null) 
            {
                try 
                {
                    resultSet.close();
                } 
                catch (SQLException ex) 
                {
                    Logger.getLogger(iniciar_sesion.class.getName()).log(Level.SEVERE,
                        "No se pudo cerrar el Resulset", ex);
                }
            }
        }
    }
    
    private void gestionarErrorEnConsultaSQL(SQLException ex, HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
    {
        ServletContext contexto  = request.getServletContext();
        Logger.getLogger(iniciar_sesion.class.getName()).log(Level.SEVERE, "No se pudo ejecutar la consulta contra la base de datos", ex);
        
        request.setAttribute("error", "A ocurrido un error, consulte con el administrador");
        RequestDispatcher paginaError = contexto.getRequestDispatcher("/login.jsp");
        paginaError.forward(request, response);
    }
}
