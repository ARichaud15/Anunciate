import java.io.IOException;
import java.io.PrintWriter;

import java.util.logging.Level;
import java.util.logging.Logger;

import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Actualizar_usuario extends HttpServlet 
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
            Logger.getLogger(Actualizar_usuario.class.getName()).log(Level.SEVERE,
                "No se pudo cargar el driver de la base de datos", ex);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(Actualizar_usuario.class.getName()).log(Level.SEVERE,
                "No se pudo obtener la conexión a la base de datos", ex);
        } 
        catch (InstantiationException ex) 
        {
            Logger.getLogger(Actualizar_usuario.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (IllegalAccessException ex) 
        {
            Logger.getLogger(Actualizar_usuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        ServletContext contexto = request.getServletContext();
        HttpSession sesion = request.getSession();
        
        ResultSet resultSet = null;
        String query = null;
        
        String Nombre = request.getParameter("Nombre");
        String Ap_P = request.getParameter("Ap_P");
        String Ap_M = request.getParameter("Ap_M");
        String Telefono = request.getParameter("Telefono");
        String Correo = request.getParameter("Correo");
        String Password = request.getParameter("Password");
        
        try 
        {
            query = "UPDATE usuarios SET "
                    + "Nombre_usuarios = '" + Nombre + "',"
                    + "ApellidoPa_usuarios = '" + Ap_P + "',"
                    + "ApellidoMa_usuarios = '" + Ap_M + "', "
                    + "Telefono_usuarios = '" + Telefono + "', "
                    + "Correo_usuarios = '" + Correo + "', "
                    + "Contrasena_usuarios = '" + Password + "' "
                    + "WHERE ID_usuarios = " +sesion.getAttribute("sessionID_usuarios")+ "";
            synchronized(statment)
            {
                statment.executeUpdate(query);
            }
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
                    Logger.getLogger(Actualizar_usuario.class.getName()).log(Level.SEVERE,
                        "No se pudo cerrar el Resulset", ex);
                }
            }
        }
        
        sesion.invalidate();
        request.setAttribute("error", "Tus datos han sido actualizados correctamente ");
        RequestDispatcher success = contexto.getRequestDispatcher("/login.jsp");
        success.forward(request, response);
    }
    
    private void gestionarErrorEnConsultaSQL(SQLException ex, HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
    {
        ServletContext contexto  = request.getServletContext();
        Logger.getLogger(Actualizar_usuario.class.getName()).log(Level.SEVERE, "No se pudo ejecutar la consulta contra la base de datos", ex);
        
        request.setAttribute("error", "A ocurrido un error al actualizar tus datos");
        RequestDispatcher Error = contexto.getRequestDispatcher("/Actualizar_usuario.jsp");
        Error.forward(request, response);
    }
}