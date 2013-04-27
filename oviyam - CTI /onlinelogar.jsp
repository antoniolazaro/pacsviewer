<%@page import="java.sql.*" %>
<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h2>usuario <%=request.getParameter("j_username") %><br> senha <%=request.getParameter("j_password")%> </h2>
<%


	try {	//carrega driver de conexão
	Class.forName("org.gjt.mm.mysql.Driver").newInstance(); 
	}
	catch (Exception e) 
	{
	out.println("Driver não carregado!");
	}
	try {	//conecta ao db, com usuario e senha							//ip server //nome db //user //senha
	Connection coneccao = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");
	String usuario = (request.getParameter("j_username"));
	String senha = (request.getParameter("j_password"));
	PreparedStatement sql=coneccao.prepareStatement("select usuarioid from laudousuario where nome='"+usuario+"' and senha='"+senha+"' and ativo='T' and temp='T'");
	ResultSet resultado=sql.executeQuery();
	if (resultado.next()){ //Verifica se o usuário existe
							//session.invalidate(); //Limpa sessão	
							session.setAttribute("online","T");
							session.setAttribute("sessao","T");

							//Variaveis para acessar somente um exame 
							String patientId = (request.getParameter("patientId"));		
							String modality = (request.getParameter("modality"));		
							String data = (request.getParameter("data"));		
							session.setAttribute("modality",modality);
							session.setAttribute("patientId",patientId);
							session.setAttribute("data",data);
							
							Connection coneccao7 = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");			
							PreparedStatement sql7=coneccao7.prepareStatement("select valor from laudoconfig where configid='weasis_link'");
							ResultSet resultado7=sql7.executeQuery();
							if (resultado7.next()){session.setAttribute("weasis_link",resultado7.getString("valor"));}
							
							//out.println(data+"<br>");
							//data=data.replaceAll("/","");
							//out.println(request.getParameter("online")+"<br>");
							//out.println(patientId+"<br>");
							//out.println(modality+"<br>");
							//out.println(data+"<br>");	

							//Redireciona para pagina do exame
							response.sendRedirect("oviyam?modality="+modality+"&patientId="+patientId+"&data="+data+""); 
	}else{
			response.sendRedirect("login.jsp");
			};
	
	resultado.close();
	coneccao.close();
	}catch (SQLException e) {
		out.println("erro sql:"+e.getMessage());
	}
	
%>	
</body>
</html>