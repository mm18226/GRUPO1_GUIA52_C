<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,net.ucanaccess.jdbc.*" %>
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
 <td>ISBN: <input type="text" name="isbn" id="isbnAvalue" value="" size="40"/>
</td>
  </tr>
 <tr>
 <td>Título: <input type="text" name="titulo" id="tituloA" value="" size="50"/></td>
 </tr>
<tr>
 <td>Autor: <input type="text" name="autor" id="autorA" value="" size="50"/></td>
 </tr>

 <!--Lista para item 7-->

<tr>
   <td>
    Seleccione La Editorial
      <select name="editorial" id="editorialA">   
      <option value="Planeta">Planeta</option> 
      <option value="Ediciones Akal">Ediciones Akal</option>
      <option value="Read & Co. Classics">Read & Co. Classics</option>
      <option value="La galera SAU">La galera SAU</option>
       <option value="Santillana">Santillana</option> 
       <option value="Algani">Algani</option>   
       <option value="Arcibel">Arcibel</option> 
       <option value="Avenauta">Avenauta</option> 
       <option value=" Males Herbes">Males Herbes</option>
       <option value="Debolsillo">Debolsillo</option>
       <option value="Calambur">Calambur</option>] 
       <option value="Renacimiento">Renacimiento</option>]
   </select>
   </td>
</tr>
<!--Fin de la lista-->

<!--Textbox para año de publicacion-->
<tr>
 <td>Año de publicación: <input type="text" name="publicado" id="publicacionA" value="" autocomplete="off" onkeypress="return (event.charCode >= 48 && event.charCode <= 57)" min="1"  /></td>
 </tr>
<!--Fin para año de publicacion-->

 <tr><td> Seleccione una accion: 
 <input type="radio" name="Action" id="radio_actualizar" value="Actualizar" checked=false/> Actualizar
 <input type="radio" name="Action" id="radio_eliminar" value="Eliminar" checked=false/> Eliminar
 <input type="radio" name="Action" id="radio_crear" value="Crear" checked=true /> Crear
  </td>
 <td><input  class="boton" type="SUBMIT" value="ACEPTAR" />
</td>
 </tr>
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
Buscar título: <input id="tituloB" type="text" name="bTitulo" value="" placeholder="ingrese un titulo" onKeyUp="HabilitarBoton()">
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
<input  id="botonB" class="botonB" type="submit" name="buscar" value="BUSCAR"  disabled="true"/>
</td>
</tr>
<!--Enlace descarga csv-->
<tr>
<td>
<a href="listado-csv.jsp" download="libros.csv">Descargar Listado CSV</a>
<a href="listado-txt.jsp" download="libros.txt">Descargar Listado TXT</a>
<a href="listado-xml.jsp" download="libros.xml">Descargar Listado XML</a>
<br>
<a href="listado-json.jsp" download="libros.json">Descargar Listado JSON</a>
<a href="listado-html.jsp" download="libros.html">Descargar Listado HTML</a>
</td>
</tr>
</table>
</form>


<!--Fin formulario Buscar-->
<%!
public Connection getConnection() throws SQLException {
String driver = "sun.jdbc.odbc.JdbcOdbcDriver";

String userName="libros", password="books";
String fullConnectionString = "jdbc:odbc:registro";

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
<!--Inicio java Buscar-->
<%
String tituloB=request.getParameter("bTitulo");
String autorB=request.getParameter("bAutor");
String isbnB=request.getParameter("bIsbn");
if(isbnB != null || tituloB !=null || autorB != null)
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
      ResultSet rs = st.executeQuery("select * from libros where isbn LIKE "+"'"+isbnB+ "%' and titulo LIKE "+"'"+tituloB+"%' and autor LIKE "+"'"+autorB+"%'");

      // Ponemos los resultados en un table de html
      out.println("<table border=\"1\" id=\"tablaLibros\"><tr><td>Num.</td><td>ISBN</td><td> <a href=\"libros.jsp\">Titulo</a></td> <td>Autor</td> <td>Editorial</td><td>Publicado</td> <td>Accion</td></tr>");
      int i=1;
      while (rs.next())
      {
         out.println("<tr>");
         out.println("<td>"+ i +"</td>");               
         String varisbn = rs.getString("isbn");
         String vartitulo = rs.getString("titulo");
         String varautor =rs.getString("autor");
         String vareditorial=rs.getString("editorial");
         String varpublicado=rs.getString("publicado");
         out.println("<td>"+varisbn+"</td>");
         String urlEliminar = "matto.jsp?Action=Eliminar&isbn="+varisbn;
         String urlActualizar="javascript:actualizarAqui("+varisbn+","+"'"+vartitulo+"'"+","+"'"+varautor+"'"+","+"'"+vareditorial+"'"+","+"'"+varpublicado+"'"+")";
         
         %>          
         <%
         %><td><%out.print(vartitulo);%></td><%         
         %><td><%out.print(varautor); %></td><%
         %><td><%out.print(vareditorial); %></td><%   
         %><td><%out.print(varpublicado);%></td><%  
         %>
         <td><a type="link" name="Action" href="<%=urlEliminar%>" value="Eliminar">Eliminar</a>
         <a type="link" name="Action" href="<%=urlActualizar%>" value="Actualizar">Actualizar</a></td>
          <script type="text/javascript">
                function actualizarAqui(a,b,c,d,e) { 
               document.getElementById('radio_crear').checked="false";                         
               document.getElementById('radio_actualizar').checked="true";
                document.getElementById('isbnAvalue').value=a;
                document.getElementById('tituloA').value=b;
                document.getElementById('autorA').value=c; 
                document.getElementById('editorialA').value=d; 
                document.getElementById('publicacionA').value=e;            
                                          }
         </script> 
         <%
         out.println("</tr>");
         i++;
      }
      out.println("</table>");


      

      // cierre de la conexion
      conexionB.close();


   }
}
//Mostrar todo
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
      out.println("<table border=\"1\" id=\"tablaLibros\"><tr><td>Num.</td><td>ISBN</td><td> <a href=\"libros.jsp\">Titulo</a></td> <td>Autor</td> <td>Editorial</td><td>Publicado</td> <td>Accion</td></tr>");
      int i=1;
      while (rs.next())
      {
         out.println("<tr>");
         out.println("<td>"+ i +"</td>");
         String varisbn = rs.getString("isbn");
         String vartitulo = rs.getString("titulo");
         String varautor =rs.getString("autor");
         String vareditorial=rs.getString("editorial");
         String varpublicado=rs.getString("publicado");
        
         out.println("<td>"+varisbn+"</td>");
         String urlEliminar = "matto.jsp?Action=Eliminar&isbn="+varisbn;
         String urlActualizar="javascript:actualizarAqui("+varisbn+","+"'"+vartitulo+"'"+","+"'"+varautor+"'"+","+"'"+vareditorial+"'"+","+"'"+varpublicado+"'"+")";
         %>
          
         <%
         %><td><%out.print(vartitulo);%></td><%         
         %><td><%out.print(varautor); %></td><%
         %><td><%out.print(vareditorial); %></td><%   
         %><td><%out.print(varpublicado);%></td><%   
        
         %>
         <td><a type="link" name="Action" href="<%=urlEliminar%>" value="Eliminar">Eliminar</a>
         <a type="link" name="Action" href="<%=urlActualizar%>" value="Actualizar">Actualizar</a></td>
         
         <script type="text/javascript">
                function actualizarAqui(a,b,c,d,e) { 
               document.getElementById('radio_crear').checked="false";                         
               document.getElementById('radio_actualizar').checked="true";
                document.getElementById('isbnAvalue').value=a;
                document.getElementById('tituloA').value=b;
                document.getElementById('autorA').value=c; 
                document.getElementById('editorialA').value=d; 
                document.getElementById('publicacionA').value=e;                          
                                          }
         </script> 
         
         <%         
         out.println("</tr>");
         i++;
      }
      out.println("</table>");

       
      // cierre de la conexion
      conexion.close();
   }
}
         %>
<!-- Punto 4 actualizar en misma pagina -->
</div>
 </body>
 </html>