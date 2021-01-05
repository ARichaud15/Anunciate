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

public class Agregar_promociones extends HttpServlet 
{private Statement statment = null;
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
            Logger.getLogger(Agregar_promociones.class.getName()).log(Level.SEVERE,
                "No se pudo cargar el driver de la base de datos", ex);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(Agregar_promociones.class.getName()).log(Level.SEVERE,
                "No se pudo obtener la conexión a la base de datos", ex);
        } 
        catch (InstantiationException ex) 
        {
            Logger.getLogger(Agregar_promociones.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (IllegalAccessException ex) 
        {
            Logger.getLogger(Agregar_promociones.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        ServletContext contexto = request.getServletContext();
        HttpSession sesion = request.getSession();
        
        ResultSet resultSet = null;
        String query = null;
        
        int ID_negocios = (int) sesion.getAttribute("sessionID_negocios");
        String Promocion = request.getParameter("Promocion");
        String Vigencia_ini = request.getParameter("Vigencia_ini");
        String Vigencia_fin = request.getParameter("Vigencia_fin");
        
        try 
        {
            query = "INSERT INTO promociones (ID_promociones, ID_negocios, promocion, VigenciaIni_promociones, VigenciaFin_promociones) VALUES "
                    + "("+ "null" + "," + ID_negocios + ",'" + Promocion + "','" + Vigencia_ini + "','" + Vigencia_fin + "')";
            synchronized(statment)
            {
                statment.executeUpdate(query);
            }
        } 
        catch (SQLException ex) 
        {
            gestionarErrorEnConsultaSQL(ex, request, response, ID_negocios);
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
                    Logger.getLogger(Agregar_promociones.class.getName()).log(Level.SEVERE,
                        "No se pudo cerrar el Resulset", ex);
                }
            }
        }
        
        request.setAttribute("error", "La promocion se agrego correctamente ");
        RequestDispatcher success = contexto.getRequestDispatcher("/Datos_negocios.jsp?negocio="+ID_negocios+"");
        success.forward(request, response);
    }
    
    private void gestionarErrorEnConsultaSQL(SQLException ex, HttpServletRequest request,HttpServletResponse response, int ID_negocios) throws IOException, ServletException 
    {
        ServletContext contexto  = request.getServletContext();
        Logger.getLogger(Agregar_promociones.class.getName()).log(Level.SEVERE, "No se pudo ejecutar la consulta contra la base de datos", ex);
        
        request.setAttribute("error", "A ocurrido un error al agregar la promocion");
        RequestDispatcher Error = contexto.getRequestDispatcher("/Datos_negocios.jsp?negocio="+ID_negocios+"");
        Error.forward(request, response);
    }
}
