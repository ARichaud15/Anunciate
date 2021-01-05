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

public class Eliminar_promociones extends HttpServlet 
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
            Logger.getLogger(Eliminar_promociones.class.getName()).log(Level.SEVERE,
                "No se pudo cargar el driver de la base de datos", ex);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(Eliminar_promociones.class.getName()).log(Level.SEVERE,
                "No se pudo obtener la conexión a la base de datos", ex);
        } 
        catch (InstantiationException ex) 
        {
            Logger.getLogger(Eliminar_promociones.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (IllegalAccessException ex) 
        {
            Logger.getLogger(Eliminar_promociones.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        ServletContext contexto = request.getServletContext();
        HttpSession sesion = request.getSession();
        
        ResultSet resultSet = null;
        String query = null;
        
        int ID_promociones = Integer.parseInt(request.getParameter("ID_promociones"));
        
        try 
        {
            query = "DELETE FROM promociones WHERE ID_promociones = " + ID_promociones + "";
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
                    Logger.getLogger(Eliminar_promociones.class.getName()).log(Level.SEVERE,
                        "No se pudo cerrar el Resulset", ex);
                }
            }
        }
        
        request.setAttribute("error", "La promocion se a eliminado correctamente ");
        RequestDispatcher success = contexto.getRequestDispatcher("/Detalles_promociones.jsp");
        success.forward(request, response);
    }
    
    private void gestionarErrorEnConsultaSQL(SQLException ex, HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
    {
        ServletContext contexto  = request.getServletContext();
        Logger.getLogger(Eliminar_promociones.class.getName()).log(Level.SEVERE, "No se pudo ejecutar la consulta contra la base de datos", ex);
        
        request.setAttribute("error", "A ocurrido un error al eliminar la promocion");
        RequestDispatcher Error = contexto.getRequestDispatcher("/Detalles_promociones.jsp");
        Error.forward(request, response);
    }
}

    