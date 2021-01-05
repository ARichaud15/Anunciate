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

public class Actualizar_negocios extends HttpServlet 
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
            Logger.getLogger(Actualizar_negocios.class.getName()).log(Level.SEVERE,
                "No se pudo cargar el driver de la base de datos", ex);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(Actualizar_negocios.class.getName()).log(Level.SEVERE,
                "No se pudo obtener la conexión a la base de datos", ex);
        } 
        catch (InstantiationException ex) 
        {
            Logger.getLogger(Actualizar_negocios.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (IllegalAccessException ex) 
        {
            Logger.getLogger(Actualizar_negocios.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        ActualizarNegocio(request, response);
    }
    
    private void ActualizarNegocio(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        ServletContext contexto = request.getServletContext();
        HttpSession sesion = request.getSession();
        ResultSet resultSet = null;
        String query = null;
        
        int ID_negocios = Integer.parseInt(request.getParameter("ID_negocios"));
        String Nombre = request.getParameter("Nombre_Neg");
        String Giro = request.getParameter("Giro_Neg");
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
            query = "UPDATE negocios SET "
                    + "Nombre_negocios = '" + Nombre + "', "
                    + "Giro_negocios = '" + Giro + "', "
                    + "Telefono_negocios = '" + Telefono + "', "
                    + "CP_negocios = "+ CP + ", "
                    + "NumExt_negocios = '" + NumExt + "', "
                    + "NumInt_negocios = '" + NumInt + "', "
                    + "HrLunesDs_negocios = '" + HrLunesDs + "', "
                    + "HrLunesHs_negocios = '" + HrLunesHs + "', "
                    + "HrSabadoDs_negocios = '" + HrSabadoDs + "', "
                    + "HrSabadoHs_negocios = '" + HrSabadoHs + "', "
                    + "HrDomingoDs_negocios = '" + HrDomingoDs + "', "
                    + "HrDomingoHs_negocios = '" + HrDomingoHs + "', "
                    + "Coordenadas_negocios = '" + Coordenadas +"' "
                    + "WHERE ID_negocios = " + ID_negocios +" ";
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
                    Logger.getLogger(Actualizar_negocios.class.getName()).log(Level.SEVERE,
                        "No se pudo cerrar el Resulset", ex);
                }
            }
        }
        
        request.setAttribute("error", "Los datos del negocio se han actualizado correctamente");
        RequestDispatcher paginaAltas = contexto.getRequestDispatcher("/Administrador.jsp");
        paginaAltas.forward(request, response);
    }
    
    private void gestionarErrorEnConsultaSQL(SQLException ex, HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
    {
        ServletContext contexto  = request.getServletContext();
        Logger.getLogger(Actualizar_negocios.class.getName()).log(Level.SEVERE, "No se pudo ejecutar la consulta contra la base de datos", ex);
        
        request.setAttribute("error", "A ocurrido un error al actualizar los datos del negocio");
        RequestDispatcher paginaError = contexto.getRequestDispatcher("/Administrador.jsp");
        paginaError.forward(request, response);
    }
}