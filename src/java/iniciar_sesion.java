import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;

import java.util.logging.Level;
import java.util.logging.Logger;

import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class iniciar_sesion extends HttpServlet 
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
            Logger.getLogger(iniciar_sesion.class.getName()).log(Level.SEVERE,
                "No se pudo cargar el driver de la base de datos", ex);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(iniciar_sesion.class.getName()).log(Level.SEVERE,
                "No se pudo obtener la conexión a la base de datos", ex);
        } 
        catch (InstantiationException ex) 
        {
            Logger.getLogger(iniciar_sesion.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (IllegalAccessException ex) 
        {
            Logger.getLogger(iniciar_sesion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        ServletContext contexto = request.getServletContext();
        HttpSession sesion = request.getSession();
        
        String Correo = request.getParameter("Correo");
        String Password = request.getParameter("Password");
        
        if(VerificarCorreo(request, response, Correo, Password))
        {
            
            CrearSesion(request, response, Correo);
            String aux = (String) sesion.getAttribute("sessionRol_usuarios");
            
            if("Gerente".equals(aux))
            {
                response.sendRedirect("Negocios.jsp");
                
            }
            else
            {
                response.sendRedirect("Administrador.jsp");
                
            }
            
        }
        else
        {
            request.setAttribute("error", "Correo y/o contraseña incorrectos");
            sesion.invalidate();
            
            RequestDispatcher PaginaError = contexto.getRequestDispatcher("/login.jsp");
            PaginaError.forward(request, response);
        }
    }
    
    private boolean VerificarCorreo(HttpServletRequest request, HttpServletResponse response, String Correo, String Password)throws ServletException, IOException 
    {
        ResultSet resultSet = null;
        String query = null;
        
        query = "SELECT * FROM usuarios WHERE Correo_usuarios = '" + Correo + "' AND Contrasena_usuarios ='"+Password+"'";
        
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
        return false;
    }
    
    public void CrearSesion (HttpServletRequest request, HttpServletResponse response, String Correo)throws ServletException, IOException
    {
        HttpSession sesion = request.getSession();
        
        ResultSet resultSet = null;
        String query = null;
        
        query = "SELECT * FROM usuarios WHERE Correo_usuarios = '" + Correo + "'";
        
        try 
        {
            synchronized(statment)
            {
                resultSet = statment.executeQuery(query);
            }
            
            if(resultSet.next())
            {
                sesion.setAttribute("sessionID_usuarios", resultSet.getInt("ID_usuarios"));
                sesion.setAttribute("sessionRol_usuarios", resultSet.getString("Rol_usuarios"));
                sesion.setAttribute("sessionNombre_usuarios", resultSet.getString("Nombre_usuarios"));
                sesion.setAttribute("sessionApellidoPa_usuarios", resultSet.getString("ApellidoPa_usuarios"));
                sesion.setAttribute("sessionApellidoMa_usuarios", resultSet.getString("ApellidoMa_usuarios"));
                sesion.setAttribute("sessionTelefono_usuarios", resultSet.getString("Telefono_usuarios"));
                sesion.setAttribute("sessionCorreo_usuarios", resultSet.getString("Correo_usuarios"));
            }
            else
            {
                sesion.invalidate();
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