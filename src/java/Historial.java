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

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Historial extends HttpServlet 
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
            Logger.getLogger(insertar_negocios.class.getName()).log(Level.SEVERE,
                "No se pudo cargar el driver de la base de datos", ex);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(insertar_negocios.class.getName()).log(Level.SEVERE,
                "No se pudo obtener la conexión a la base de datos", ex);
        } 
        catch (InstantiationException ex) 
        {
            Logger.getLogger(insertar_negocios.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (IllegalAccessException ex) 
        {
            Logger.getLogger(insertar_negocios.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    protected void processRequest (HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        InsertarNegocio(request, response);
    }
    
    private void InsertarNegocio(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        ServletContext contexto = request.getServletContext();
        HttpSession sesion = request.getSession();
        ResultSet resultSet = null;
        String query = null;
        
        
                                Date date = new Date();
                                            DateFormat hourFormat = new SimpleDateFormat("HH:mm:ss");
                                            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        
        try 
        {
            query = "INSERT INTO historial (ID_historial, ID_usuarios, inicio_sesion, final_sesion, fecha) VALUES "
            + "("+ "null" + "," + sesion.getAttribute("sessionID_usuarios") + ",'" + hourFormat.format(date) + "','" + "null" + "','" + dateFormat.format(date) + "')";
            synchronized(statment)
            {
               resultSet = statment.executeQuery(query);
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
                    Logger.getLogger(insertar_negocios.class.getName()).log(Level.SEVERE,
                        "No se pudo cerrar el Resulset", ex);
                }
            }
        }
        
        
        response.sendRedirect("Negocios.jsp");
    }
    
    private void gestionarErrorEnConsultaSQL(SQLException ex, HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
    {
        ServletContext contexto  = request.getServletContext();
        Logger.getLogger(insertar_negocios.class.getName()).log(Level.SEVERE, "No se pudo ejecutar la consulta contra la base de datos", ex);
        
        request.setAttribute("error", "A ocurrido un error al registrar tu negocio");
        RequestDispatcher paginaError = contexto.getRequestDispatcher("/Registro_negocios.jsp");
        paginaError.forward(request, response);
    }
   
 }