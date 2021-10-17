<%@page contentType="application-/vnd.ms-excel" import="java.sql.*,net.ucanaccess.jdbc.*"%>
     
<%    
        response.setStatus(200);
        response.setHeader("Content-Type","text/csv; charset=UTF-8");
        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition","attachment;filename=libros.csv");
%>
<%! int cont=0; %>
<%!
//Conexion inicio
public Connection getConnection() throws SQLException {
String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
String filePath= getServletContext().getRealPath("\\data\\datos.mdb");
String userName="",password="";
String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection conn = null;
try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 conn = DriverManager.getConnection(fullConnectionString,userName,password);

}
 catch (Exception e) {
System.out.println("Error: " + e);
 }
    return conn;
}
//Fin conexion
%>
<%
//traer datos
Connection conexion = getConnection();
   if (!conexion.isClosed()){
      out.write("");
         cont++;
         String x;
          if(cont%2 == 0){
            x = "asc";
 }else {
    x = "desc";
 }
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery("select * from libros order by Titulo "+x );

      // Ponemos los resultados en un table de html
      out.print("Num,Titulo,Autor,Editorial,Publicado,");
      int i=1;
      while (rs.next())
      {        
         String varisbn = rs.getString("isbn");        
         
//String url = "matto.jsp?Action=Eliminar&isbn="+varisbn;
          out.print(varisbn+",");
         String titulo =rs.getString("titulo"); 
         out.print(titulo+",");
         String autor =rs.getString("autor");
          out.print(autor+",");
         String editorial =rs.getString("Editorial");
          out.print(editorial+",");     
         String publicado =rs.getString("publicado");
         out.print(publicado+",");           
         i++;
      }
    
      // cierre de la conexion
      conexion.close();
   }
%>