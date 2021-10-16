<%@page contentType="application/xml"  import="java.sql.*,net.ucanaccess.jdbc.*"%><%    
        response.setStatus(200);
        response.setHeader("Content-Type","application/xml; charset=UTF-8");
        response.setContentType("application/xml; charset=UTF-8");
        response.setHeader("Content-Disposition","attachment;filename=libros.xml");
%><%! int cont=0; %><?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE documento [
		<!ELEMENT documento (head, body)>
		
			<!ELEMENT head (title)>
      <!ELEMENT title (#PCDATA)>
      
			
		<!ELEMENT body (H1,table)>
		 <!ELEMENT H1 (#PCDATA)>
		 <!ELEMENT br (#PCDATA)>
		 
		<!ELEMENT table (tr*)>
		<!ATTLIST table border CDATA  #REQUIRED>
				<!ELEMENT tr (td*)>
				<!ELEMENT td (#PCDATA)>
					]>
  <documento>
 <head>
 <title>Actualizar, Eliminar, Crear registros.</title>
 
  </head>
 <body>
<H1>MANTENIMIENTO DE LIBROS</H1>>



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
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td> Titulo</td> <td>Autor</td> <td>Editorial</td><td>Publicado</td> </tr>");
      int i=1;
      while (rs.next())
      {
         out.println("<tr>");
         out.println("<td>"+ i +"</td>");
         String varisbn = rs.getString("isbn");
         out.println("<td>"+varisbn+"</td>");
         String url = "matto.jsp?Action=Eliminar&isbn="+varisbn;
         %><td><%=rs.getString("titulo") %></td><%
         %><td><%=rs.getString("autor") %></td><%
         %><td><%=rs.getString("Editorial") %></td><%        
         %><td><%=rs.getString("publicado")%></td><%  
         out.println("</tr>");
         i++;
      }
      out.println("</table>");

      // cierre de la conexion
      conexion.close();
   }

%>
 </body>
 </documento>
 