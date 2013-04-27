<%@page import="java.sql.*" %>
<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@page import="com.oreilly.servlet.multipart.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Cadastro de Laudos</title>
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
	String liberarlaudo = request.getParameter("liberarlaudo");	
	String usuarioid = (String)session.getAttribute("usuarioid");
	
	//Dados para processar o laudo quando o arquivo wav e anexado
	session.setAttribute("patientidfile",patientid);
	session.setAttribute("nomefile",nome);	
	session.setAttribute("modalityfile",modality);	
	session.setAttribute("datefile",date);		
	session.setAttribute("examefile",exame);			
	session.setAttribute("opcaofile",opcao);				
	session.setAttribute("laudoidfile",laudoid);					
	session.setAttribute("laudocadfile",laudocad);							
	session.setAttribute("liberarlaudofile","F");								
	
	//Gerar nome do arquivo para o upload ou download
	String arquivo_nome_applet = date+""+patientid+""+modality;
%>
Codigo : <%=patientid %> - <%=nome %><br>
Exame : <%= exame %> - Data : <%=date %><br>
<br>
	<center><applet archive=apps.jar code=apps.GravadorFromCapturePlayback.class width="300" height="170" >
		<param name="ftp_host" value="<%=(String)session.getAttribute("ftp_host")%>">
		<param name="filename" value="<%=arquivo_nome_applet+".wav"%>">
		<param name="ftp_password" value="<%=(String)session.getAttribute("ftp_password")%>">
		<param name="ftp_user" value="<%=(String)session.getAttribute("ftp_user")%>">
		<param name="ftp_dir" value="<%=(String)session.getAttribute("ftp_dir")%>">
	</center></applet><br>
	
<form id="form1" name="form1" method="post" action="laudo.jsp">
  <label><span class="style2">Selecione o laudo</span> :
  <select name="laudo" id="laudo" class="textBox">
	<%    //Listar laudos padrões
	try {	//carrega driver de conexão
			Class.forName("org.gjt.mm.mysql.Driver").newInstance(); 
		}
	catch (Exception e) 
		{
		out.println("Driver não carregado!");
		}

	try {	//conecta ao db, com usuario e senha							//ip server //nome db //user //senha
		Connection coneccao = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");
		PreparedStatement sql=coneccao.prepareStatement("select laudopadraoid,laudodesc from laudopadrao where laudopadraoid in (select laudopadraoid from laudopadraousuario where usuarioid=?) order by laudodesc");
		sql.setString(1,usuarioid);
		ResultSet resultado=sql.executeQuery();

		while (resultado.next()){
		%>
			<option value=<%=resultado.getString("laudopadraoid")%>> <%=resultado.getString("laudodesc")%></option>
		<%
		}
		resultado.close();
		coneccao.close();
  }catch (SQLException e) {
			out.println("erro sql:"+e.getMessage());
		}
         %>
  </select>
  </label>
  <input type="submit" name="Submit" value="Selecionar" style="cursor:pointer;" />         
	<input type="hidden" name="laudoload" value="T"/>	
	<input type="hidden" name="patientid" value="<%=patientid %>"/>	
	<input type="hidden" name="nome" value="<%=nome %>"/>	
	<input type="hidden" name="modality" value="<%=modality %>"/>	
	<input type="hidden" name="date" value="<%=date %>"/>	
	<input type="hidden" name="exame" value="<%=exame %>"/>	
	<input type="hidden" name="laudoload" value="<%=laudoload %>"/>		
	<input type="hidden" name="laudocad" value="<%=laudocad %>"/>			
	<input type="hidden" name="liberarlaudo" value="<%=liberarlaudo %>"/>				
	<input type="hidden" name="opcao" value="<%=opcao %>"/>
</form>	
<form id="form2" name="form2" method="post" action="laudo_db.jsp">
	<% 
 	//Carrega laudo se existir ou carrega o laudo em branco
 	if 	((opcao.equals("update"))&&(laudoload.equals("F"))) {
	try {
		Connection coneccao3 = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");
		PreparedStatement sql3=coneccao3.prepareStatement("select laudoid,laudo from laudo where laudoid='"+request.getParameter("laudocad")+"'");
		ResultSet resultado3=sql3.executeQuery();
		if (resultado3.next()){
								out.println("<textarea name='laudotexto2' cols='72' rows='20'>"+resultado3.getString("laudo")+"</textarea>");
								session.setAttribute("laudotexto2file",resultado3.getString("laudo"));							
							  }
		laudoid=resultado3.getString("laudoid");
	    resultado3.close();
		coneccao3.close();
		}catch (SQLException e3) {
		out.println("erro sql:"+e3.getMessage());
		}
	}else if ((opcao.equals("insert"))&&(laudoload.equals("F"))){
																out.println("<textarea name='laudotexto2' cols='72' rows='20'>Digite o laudo ou carregue o laudo padrao</textarea>");
																session.setAttribute("laudotexto2file","Digite o laudo ou carregue o laudo padrao");																							
																}
	if 	(laudoload.equals("T")) {
	try {	//carregar laudo padrao
		Connection coneccao2 = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");
		PreparedStatement sql2=coneccao2.prepareStatement("select laudo,laudodesc from laudopadrao where laudopadraoid="+request.getParameter("laudo"));
		ResultSet resultado2=sql2.executeQuery();
		while (resultado2.next()){
			out.println("<textarea name='laudotexto2' cols='72' rows='20'>"+resultado2.getString("laudo")+"</textarea>");
			session.setAttribute("laudotexto2file",resultado2.getString("laudo"));							
			}
	    resultado2.close();
		coneccao2.close();
  		}catch (SQLException e2) {
			out.println("erro sql:"+e2.getMessage());
		}
  		}
	%>
  <label><span class="style1"><br>
  Liberar laudo </span>
  <select name="liberarlaudo">
  	<option value="F">Não</option>  
  	<option value="T">Sim</option>
  </select>
  </label>
  <input type="submit" name="Submit" value="Salvar" style="cursor:pointer;" />
	    <input type="hidden" name="patientid" value="<%=patientid %>"/>	
	    <input type="hidden" name="nome" value="<%=request.getParameter("nome")%>"/>	
	    <input type="hidden" name="laudocad" value="<%=laudocad %>"/>	
	    <input type="hidden" name="modality" value="<%=modality %>"/>	
		<input type="hidden" name="laudoload" value="<%=laudoload %>"/>		
		<input type="hidden" name="laudocad" value="<%=laudocad %>"/>			
	    <input type="hidden" name="date" value="<%=date %>"/>	
	    <input type="hidden" name="exame" value="<%=exame %>"/>	
	    <input type="hidden" name="opcao" value="<%=opcao %>"/>
</form>

<%
	//Gerar nome do arquivo para o upload ou download
	String arquivo_nome = date+""+patientid+""+modality;
	session.setAttribute("arquivo_nome",arquivo_nome);
	
	//if ( new java.io.File("c:/pacs/sound/"+arquivo_nome+".wav").exists()){	
	if ( new java.io.File((String)session.getAttribute("dir")+arquivo_nome+".wav").exists()){	
		out.println("<a href=upload_excluir.jsp?patientid="+patientid+"&nome="+nome+"&modality="+modality+"&date="+date+"&exame="+exame+"&opcao="+opcao+"&laudoid="+laudoid+"&laudoload="+laudoload+"&laudocad="+laudocad+"&liberarlaudo="+liberarlaudo+"&usuarioid="+usuarioid+"><img src=images/button_excluir.jpg><a/>");
		out.println("<a href=download.jsp><img src=images/button_download.jpg width=20></a>");		
 	}else {	//Cria variaveis de seesão para processar o arquivo
 
 %>
	
	<FORM id="form_upload" ENCTYPE="multipart/form-data" ACTION="upload.jsp" METHOD=POST>
	  <center><table border="2" >
                    <tr><center><td colspan="2"><p align="center"><span class="style1"><B>Enviar arquivo de voz</B></span>
                      </td></center></tr>
                    <tr><td><span class="style1"><b>Selecione o Arquivo:</b></span></td>
                    <td><INPUT NAME="F1" TYPE="file" accept="audio/x-wav,audio/wav" /></td></tr>
					<tr><td colspan="2"><p align="right"><INPUT type="submit" name="Submit" VALUE="Enviar" /></p></td></tr>
             </table>
     </center>
	</FORM>
<%}%>

</body>
</html>
