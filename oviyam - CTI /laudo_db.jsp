<%@page import="java.sql.*" %>
<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Salvar Laudo</title>
<style type="text/css">
<!--
body {
	background-color: #000000;
}
.style2 {color: #FFFFFF}
.style3 {color: #FF0000}
-->
</style>
</head>
<body>

<p align="center">
  <%	String patientid = request.getParameter("patientid");
	String nome = request.getParameter("nome");
	String modality = request.getParameter("modality");
	String date = request.getParameter("date");
	String exame = request.getParameter("exame");
	String opcao = request.getParameter("opcao");
	String laudotexto2 = request.getParameter("laudotexto2");
	String laudocad = request.getParameter("laudocad");			
	String liberarlaudo = request.getParameter("liberarlaudo");	
	String usuarioid = (String)session.getAttribute("usuarioid");


	try {	//carrega driver de conexão
			Class.forName("org.gjt.mm.mysql.Driver").newInstance(); 
		}
	catch (Exception e) 
		{
		out.println("Driver não carregado!");
		}

	try {	//conecta ao db, com usuario e senha							//ip server //nome db //user //senha
		Connection coneccao = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");
		if 	(opcao.equals("insert")) {
			PreparedStatement sql=coneccao.prepareStatement("insert into laudo (patientid,nome,exame,modality,date,datacad,laudo,liberado,usuarioid,digitado) values (?,?,?,?,?,now(),?,?,?,'F')");
			sql.setString(1,request.getParameter("patientid"));
			sql.setString(2,request.getParameter("nome"));
			sql.setString(3,request.getParameter("exame"));
			sql.setString(4,request.getParameter("modality"));
			sql.setString(5,request.getParameter("date"));
			sql.setString(6,request.getParameter("laudotexto2"));		
			sql.setString(7,request.getParameter("liberarlaudo"));				
			sql.setString(8,usuarioid);
			sql.executeUpdate();
		}else if (opcao.equals("update")){
			PreparedStatement sql=coneccao.prepareStatement("UPDATE laudo SET laudo = ?, liberado = ? WHERE laudoid = ?");
			sql.setString(1,request.getParameter("laudotexto2"));		
			sql.setString(2,request.getParameter("liberarlaudo"));		
			sql.setString(3,request.getParameter("laudocad"));
			sql.executeUpdate();
		}

		coneccao.close();
  }catch (SQLException e) {
			out.println("erro sql:"+e.getMessage());
		}
	%>
  
  <span class="style2">Laudo atualizado com sucesso!!</span></p>
	<p align="center">&nbsp;</p>
	<p align="center">  <span class="style3"><a href="javascript:self.close();window.opener.reload();"><img src="images/laudo_fechar.gif"/>Fechar</a>

	<% //add command with that oviyam7.jsp refresh after close javascript:window.opener.location.reload(true);self.close();window.opener.reload();%>

</span></p>
</body>
</html>