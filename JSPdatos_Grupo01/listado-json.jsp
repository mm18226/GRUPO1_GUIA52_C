     <%@page contentType="application/json"  import="java.sql.*,net.ucanaccess.jdbc.*"%>
     
<%    
        response.setStatus(200);
        response.setHeader("Content-Type","application/json; charset=UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        response.setHeader("Content-Disposition","attachment;filename=libros.json");
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
      int i=1;
      out.print("{\"Libros\":[");
      while (rs.next())
      {

         out.print("{\"Num.\":");
         out.println( i+"," );
         String varisbn = rs.getString("isbn");
         out.println("\"ISBN\": "+varisbn+",");
        String titulo =rs.getString("titulo"); 
         out.println("\"Titulo\": "+"\""+titulo+"\",");
         String autor =rs.getString("autor");
          out.println("\"Autor\": "+"\""+autor+"\",");
         String editorial =rs.getString("Editorial");
          out.println("\"Editorial\": "+"\""+editorial+"\",");   
         String publicado =rs.getString("publicado");
         out.println("\"Publicado\": "+publicado);

         out.println("},");          
         i++;
      }

      out.println("]}");

      // cierre de la conexion
      conexion.close();
   }

%>
 