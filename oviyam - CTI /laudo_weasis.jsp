<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@page import="com.oreilly.servlet.multipart.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Laudos - Weasis Viewer</title>
<style type="text/css">
<!--
.style1 {color: #CCCCCC}
.style2 {color: #999999}
body {
	background-color: #000000;
}
-->
</style>
</head>
<body> <% //onblur="self.focus();" deixa popup sempre no topo%>
<p>
<span class="style1">
<% 	//Redireciona se a sessao for invalida
 if ((session.getAttribute("sessao")=="F")||(null == session.getAttribute("sessao"))){response.sendRedirect("login.jsp");} %>

<% 
	String patientid = request.getParameter("patientid");
	String nome = request.getParameter("nome");
	String modality = request.getParameter("modality");
	String date = request.getParameter("date");
	String exame = request.getParameter("exame");
	String opcao = request.getParameter("opcao");
	String laudoid = request.getParameter("laudo");	
	String laudoload = request.getParameter("laudoload");		
	String laudocad = request.getParameter("laudocad");			
	String studyId = request.getParameter("studyId");				
	String liberarlaudo = request.getParameter("liberarlaudo");	
	String usuarioid = (String)session.getAttribute("usuarioid");
	String weasis_link = (String)session.getAttribute("weasis_link");
	
%>
Codigo : <%=patientid %> - <%=nome %><br>
Exame : <%= exame %> - Data : <%=date %><br>
<br>
	
<%    //Carregar dados para iniciar viewer weasis
	try {	//carrega driver de conexão
			Class.forName("org.gjt.mm.mysql.Driver").newInstance(); 
		}
	catch (Exception e) 
		{
		out.println("Driver não carregado!");
		}

	try {	//conecta ao db, com usuario e senha							//ip server //nome db //user //senha
		Connection coneccao = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");
		PreparedStatement sql=coneccao.prepareStatement("select s.study_iuid,s.study_desc from patient p inner join study s on (s.patient_fk=p.pk) where s.mods_in_study=? and p.pat_id=? and s.study_iuid=? and s.study_datetime>=? and s.study_datetime<=?");
		sql.setString(1,modality);
		sql.setString(2,patientid);
		sql.setString(3,studyId);				
		sql.setString(4,date+"000000");
		sql.setString(5,date+"235959");		
		ResultSet resultado=sql.executeQuery();

		//Direciona para o sistema weasis
		 if (resultado.next()){
				response.sendRedirect(weasis_link+"weasis-pacs-connector/viewer.jnlp?studyUID="+resultado.getString("s.study_iuid"));
				}

		//resultado.last();//posiciona na ultima linha
		//int linhas=resultado.getRow(); //set o numero da ultima linha
		
		//Direciona para o sistema weasis, se o exame tiver 
		//uma série é direcionado automaticamente para o weasis senão
		//cria links para o usuário clicar
		//if (linhas==1){
		//	response.sendRedirect(weasis_link+"weasis-pacs-connector/viewer.jnlp?studyUID="+resultado.getString("s.study_iuid"));
		//} else {
		//	resultado.beforeFirst(); //posiciona para 1 registro		
			//	while (resultado.next()){
				//		out.println("<a href='"+weasis_link+"weasis-pacs-connector/viewer.jnlp?studyUID="+resultado.getString("s.study_iuid")+"'>"+resultado.getString("s.study_desc")+"</a><br>");
			//	}
		//}

		 //if (resultado.next()){
		//	response.sendRedirect(weasis_link+"weasis-pacs-connector/viewer.jnlp?studyUID="+resultado.getString("s.study_iuid"));
		//	}
		//while (resultado.next()){
			//response.sendRedirect(weasis_link+"weasis-pacs-connector/viewer.jnlp?studyUID="+resultado.getString("s.study_iuid"));
		//}

		resultado.close();
		coneccao.close();
  }catch (SQLException e) {
			out.println("erro sql:"+e.getMessage());
		}
       %>

</body>
</html>
