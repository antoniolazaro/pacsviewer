<%@ page import="java.io.*" %>
<%@page import="java.text.*" %>   
<%@page import="java.util.Date" %>   
<%@page import="java.sql.*" %>
<%@page import="java.lang.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%
	//Variaveis de sessão
	String arquivo_nome = (String)session.getAttribute("arquivo_nome");	
	//String patientid = request.getParameter("patientid");
	//String nome = request.getParameter("nome");
	//String modality = request.getParameter("modality");
	//String date = request.getParameter("date");
	//String exame = request.getParameter("exame");
	//String opcao = request.getParameter("opcao");
	//String laudoid = request.getParameter("laudo");	
	//String laudoload = request.getParameter("laudoload");		
	//String laudocad = request.getParameter("laudocad");			
	//String liberarlaudo = request.getParameter("liberarlaudo");	
	//String usuarioid = (String)session.getAttribute("usuarioid");
	
	//Excluir arquivo
	//String filename = "c:/pacs/sound/"+arquivo_nome+".wav";
	String filename = (String)session.getAttribute("dir")+arquivo_nome+".wav";
	File f = new File(filename);
	f.setWritable(true);
	f.delete();
	//out.println(patientid);
	//Redirecionar
	//response.sendRedirect("laudo.jsp?patientid="+patientid+"&nome="+nome+"&modality="+modality+"&date="+date+"&exame="+exame+"&opcao="+opcao+"&laudoid="+laudoid+"&laudoload="+laudoload+"&laudocad="+laudocad+"&liberarlaudo="+liberarlaudo+"&usuarioid="+usuarioid+"");
%><style type="text/css">
<!--
body {
	background-color: #000000;
}
.style1 {color: #FFFFFF}
-->
</style>
	<span class="style2 style1">Arquivo excluído com sucesso!!</span>
	</p>
	<p align="center" class="style1">&nbsp;</p>
	<p align="center">  <span class="style3"><a href="javascript:self.close();window.opener.reload();"><img src="images/laudo_fechar.gif"/>Fechar</a>