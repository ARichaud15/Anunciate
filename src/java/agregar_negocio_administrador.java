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

public class agregar_negocio_administrador extends HttpServlet 
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
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        InsertarNegocio(request, response);
    }
    
    private void InsertarNegocio(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        ServletContext contexto = request.getServletContext();
        HttpSession sesion = request.getSession();
        ResultSet resultSet = null;
        String query = null;
        
        int ID_usuarios = Integer.parseInt(request.getParameter("cliente"));
        int ID_giro = Integer.parseInt(request.getParameter("Giro_Neg"));
        String Nombre = request.getParameter("Nombre_Neg");
        String Telefono= request.getParameter("Telefono");
        String Coordenadas = request.getParameter("Coordenadas");
        
        int CP = Integer.parseInt(request.getParameter("Codigo_postal"));
        String NumExt = request.getParameter("Numero_exterior");
        String NumInt = request.getParameter("Numero_interior");
        
        String HrLunesDs =  request.getParameter("Desde_L");
        String HrLunesHs =  request.getParameter("Hasta_L");
        String HrSabadoDs =  request.getParameter("Desde_S");
        String HrSabadoHs =  request.getParameter("Hasta_S");
        String HrDomingoDs =  request.getParameter("Desde_D");
        String HrDomingoHs =  request.getParameter("Hasta_D");
        
        try 
        {
            query = "INSERT INTO negocios (ID_negocios, ID_usuarios, Nombre_negocios, Giro_negocios, Telefono_negocios, CP_negocios, NumExt_negocios, NumInt_negocios, HrLunesDs_negocios, HrLunesHs_negocios, HrSabadoDs_negocios, HrSabadoHs_negocios, HrDomingoDs_negocios, HrDomingoHs_negocios, Coordenadas_negocios) VALUES "
                    + "("+ "null" + "," + ID_usuarios + ",'" + Nombre + "'," + ID_giro + ",'" + Telefono + "'," + CP + ",'" + NumExt + "','" + NumInt + "','" + HrLunesDs + "','" + HrLunesHs + "','" + HrSabadoDs + "','" + HrSabadoHs + "','" + HrDomingoDs + "','" + HrDomingoHs + "','" + Coordenadas + "')";
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
                    Logger.getLogger(insertar_negocios.class.getName()).log(Level.SEVERE,
                        "No se pudo cerrar el Resulset", ex);
                }
            }
        }
        
        request.setAttribute("error", "Tu negocio se a registrado exitosamente");
        RequestDispatcher paginaAltas = contexto.getRequestDispatcher("/Administrador.jsp");
        paginaAltas.forward(request, response);
    }
    
    private void gestionarErrorEnConsultaSQL(SQLException ex, HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
    {
        ServletContext contexto  = request.getServletContext();
        Logger.getLogger(insertar_negocios.class.getName()).log(Level.SEVERE, "No se pudo ejecutar la consulta contra la base de datos", ex);
        
        request.setAttribute("error", "A ocurrido un error al registrar tu negocio");
        RequestDispatcher paginaError = contexto.getRequestDispatcher("/Administrador.jsp");
        paginaError.forward(request, response);
    }
}