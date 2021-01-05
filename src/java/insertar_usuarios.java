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

public class insertar_usuarios extends HttpServlet 
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
            Logger.getLogger(insertar_usuarios.class.getName()).log(Level.SEVERE,
                "No se pudo cargar el driver de la base de datos", ex);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(insertar_usuarios.class.getName()).log(Level.SEVERE,
                "No se pudo obtener la conexión a la base de datos", ex);
        } 
        catch (InstantiationException ex) 
        {
            Logger.getLogger(insertar_usuarios.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (IllegalAccessException ex) 
        {
            Logger.getLogger(insertar_usuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        ServletContext contexto = request.getServletContext();
        
        if(VerificarCorreo(request, response))
        {
            request.setAttribute("error", "El correo ya se encuentra registrado");
            RequestDispatcher PaginaError = contexto.getRequestDispatcher("/Registro_usuarios.jsp");
            PaginaError.forward(request, response);
        }
        else
        {
            InsertarUsuario(request, response);
        }
    }
    
    private boolean VerificarCorreo(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        ServletContext contexto = request.getServletContext();
        ResultSet resultSet = null;
        String query = null;
        int cont = 0;
        
        String Correo = request.getParameter("Correo");
        
        query = "SELECT * FROM usuarios WHERE Correo_usuarios = '" + Correo + "' ";
        
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
                    Logger.getLogger(insertar_usuarios.class.getName()).log(Level.SEVERE,
                        "No se pudo cerrar el Resulset", ex);
                }
            }
        }
        return false;
    }
    
    private void InsertarUsuario(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        ServletContext contexto = request.getServletContext();
        ResultSet resultSet = null;
        String query = null;
        
        String Nombre = request.getParameter("Nombre");
        String Rol = "Gerente";
        String Ap_P = request.getParameter("Ap_P");
        String Ap_M = request.getParameter("Ap_M");
        String Telefono = request.getParameter("Telefono");
        String Correo = request.getParameter("Correo");
        String Password = request.getParameter("Password");
        
        try 
        {
            query = "INSERT INTO usuarios (ID_usuarios, Rol_usuarios, Nombre_usuarios , ApellidoPa_usuarios, ApellidoMa_usuarios, Telefono_usuarios, Correo_usuarios, Contrasena_usuarios) VALUES ("+ "null" + ",'" + Rol + "','" + Nombre + "','" + Ap_P + "','" + Ap_M + "','" + Telefono + "','" + Correo + "','" + Password +"')";
            synchronized(statment)
            {
                statment.executeUpdate(query);
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
                    Logger.getLogger(insertar_usuarios.class.getName()).log(Level.SEVERE,
                        "No se pudo cerrar el Resulset", ex);
                }
            }
        }
        
        request.setAttribute("error", "Su cuenta se a registrado exitosamente");
        RequestDispatcher paginaAltas = contexto.getRequestDispatcher("/login.jsp");
        paginaAltas.forward(request, response);
    }
    
    private void gestionarErrorEnConsultaSQL(SQLException ex, HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
    {
        ServletContext contexto  = request.getServletContext();
        Logger.getLogger(insertar_usuarios.class.getName()).log(Level.SEVERE, "No se pudo ejecutar la consulta contra la base de datos", ex);
        
        request.setAttribute("error", "A ocurrido un error, consulte con el administrador");
        RequestDispatcher paginaError = contexto.getRequestDispatcher("/login.jsp");
        paginaError.forward(request, response);
    }
}
