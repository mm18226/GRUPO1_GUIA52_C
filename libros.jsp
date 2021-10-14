<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
<%! int cont=0; %>
 <html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="data/pagPrincipal.css" rel="stylesheet" type="text/css">
 <title>Actualizar, Eliminar, Crear registros.</title>
 </head>
 <body>
<div class="container">
<H1>MANTENIMIENTO DE LIBROS</H1>
<form action="matto.jsp" method="post" name="Actualizar">
 <table>
 <tr>
 <td>ISBN: <input type="text" name="isbn" value="" size="40"/>
</td>
  </tr>
 <tr>
 <td>Titulo: <input type="text" name="titulo" value="" size="50"/></td>

 </tr>
 <tr><td> Seleccione una accion: <input type="radio" name="Action" value="Actualizar" /> Actualizar
 <input type="radio" name="Action" value="Eliminar" /> Eliminar
 <input type="radio" name="Action" value="Crear" checked /> Crear
  </td>
 <td><input type="SUBMIT" value="ACEPTAR" />
</td>
 </tr>
 </form>
 </tr>
 </table>
 </form>
<br><br>
 
<%!
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
%>
<%
Connection conexion = getConnection();
   if (!conexion.isClosed()){
out.write("OK");
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
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td> <a href=\"libros.jsp\">Titulo</a></td> <td>Autor</td> <td>Accion</td></tr>");
      int i=1;
      while (rs.next())
      {
         out.println("<tr>");
         out.println("<td>"+ i +"</td>");
         String varisbn = rs.getString("isbn");
         out.println("<td>"+varisbn+"</td>");
         String url = "matto.jsp?Action=Eliminar&isbn="+varisbn;
         %><td><%=rs.getString("titulo") %><%
         %><td><%=rs.getString("autor") %><%
         %><td><a type="link" name="action" href="<%=url %>" value="Eliminar">Eliminar</a></td><%
         out.println("</tr>");
         i++;
      }
      out.println("</table>");

      // cierre de la conexion
      conexion.close();
}

%>
</div>
 </body>