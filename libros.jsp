<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
<%! int cont=0; %>
 <html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="data/pagPrincipal.css" rel="stylesheet" type="text/css">
 <title>Actualizar, Eliminar, Crear registros.</title>
 <!--Habilitar boton de busqueda-->
 <script type="text/javascript">
function HabilitarBoton() {
   var titulo=document.getElementById("tituloB");
   var autor=document.getElementById("autorB");
   var isbn=document.getElementById("isbnB");
   var boton=document.getElementById("botonB");

   if(titulo.value !="" || autor.value != "" || isbn.value != ""  ){
      boton.disabled=false;
   }
   else{
      boton.disabled=true;
   }
}
 </script>
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
<tr>
 <td>Autor: <input type="text" name="autor" value="" size="50"/></td>
 </tr>

 <!--Lista para lista 7-->

<tr>
   <td>
    Seleccione La Editorial
      <select name="editorial">   
      <option value="Planeta">Planeta</option> 
       <option value="Santillana">Santillana</option> 
       <option value="Algani">Algani</option>   
       <option value="Arcibel">Arcibel</option> 
       <option value="Avenauta">Avenauta</option> 
       <option value="Calambur">Calambur</option>] 
       <option value="Renacimiento">Renacimiento</option>]
   </select>
   </td>
</tr>
<!--Fin de la lista-->

<!--Textbox para año de publicacion-->
<tr>
 <td>Año de publicación: <input type="text" name="publicado" value="" autocomplete="off" onkeypress="return (event.charCode >= 48 && event.charCode <= 57)" min="1"  /></td>
 </tr>
<!--Fin para año de publicacion-->

 <tr><td> Seleccione una accion: <input type="radio" name="Action" value="Actualizar" /> Actualizar
 <input type="radio" name="Action" value="Eliminar" /> Eliminar
 <input type="radio" name="Action" value="Crear" checked /> Crear
  </td>
 <td><input  class="boton" type="SUBMIT" value="ACEPTAR" />
</td>
 </tr>
 </form>
 </tr>
 </table>
 </form>
<br><br>
<!--Buscar formulario-->

<form name="formbusca" action="libros.jsp" method="post">
<table>
<tr>
<td>
Buscar por ISBN: <input id="isbnB" type="text" name="bIsbn" value="" placeholder="ingrese el ISBN" onKeyUp="HabilitarBoton()"> 
</td>
</tr>
<tr>
<td>
Buscar titulo: <input id="tituloB" type="text" name="bTitulo" value="" placeholder="ingrese un titulo" onKeyUp="HabilitarBoton()">
</td>
</tr>
<br> 
<tr>
<td>
Buscar autor: <input id="autorB" type="text" name="bAutor" value="" placeholder="ingrese un autor" onKeyUp="HabilitarBoton()"> 
</td>
</tr>
<tr>
<td>
<input  id="botonB" class="botonB" type="submit" name="buscar" value="BUSCAR"  disabled="   true"/>
</td>
</tr>
</table>
</form>




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

%>

<%
String tituloB=request.getParameter("bTitulo");
String autorB=request.getParameter("bAutor");
String isbnB=request.getParameter("bIsbn");
if(isbnB != null)
{

Connection conexionB = getConnection();
   if (!conexionB.isClosed()){
out.write("OK");
 cont++;
 String x;
 if(cont%2 == 0){
    x = "asc";
 }else {
    x = "desc";
 }
      Statement st = conexionB.createStatement();
      ResultSet rs = st.executeQuery("select * from libros where isbn LIKE "+"'%"+isbnB+ "%'");

      // Ponemos los resultados en un table de html
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td> <a href=\"libros.jsp\">Titulo</a></td> <td>Autor</td> <td>Editorial</td><td>Publicado</td> <td>Accion</td></tr>");
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
         %><td><%=rs.getString("Editorial") %><%        
         %><td><%=rs.getString("publicado")%><%   
         %><td><a type="link" name="action" href="<%=url %>" value="Eliminar">Eliminar</a></td><%
         out.println("</tr>");
         i++;
      }
      out.println("</table>");

      // cierre de la conexion
      conexionB.close();


   }
}

else{
out.write("No hay libros con esos datos solicitados");

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
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td> <a href=\"libros.jsp\">Titulo</a></td> <td>Autor</td> <td>Editorial</td><td>Publicado</td> <td>Accion</td></tr>");
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
         %><td><%=rs.getString("Editorial") %><%        
         %><td><%=rs.getString("publicado")%><%   
         %><td><a type="link" name="action" href="<%=url %>" value="Eliminar">Eliminar</a></td><%
         out.println("</tr>");
         i++;
      }
      out.println("</table>");

      // cierre de la conexion
      conexion.close();
   }
}

%>
</div>
 </body>