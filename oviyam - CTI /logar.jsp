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
		PreparedStatement sql=coneccao.prepareStatement("select usuarioid from laudousuario where nome='"+usuario+"' and senha='"+senha+"' and ativo='T' and temp='F'");
		ResultSet resultado=sql.executeQuery();
		//resultado.next();	//para posicionar na primeira linha
		if (resultado.next()){ //Verifica se o usuário existe
			//session.invalidate(); //Limpa sessão
			session.setAttribute("usuarioid",resultado.getString("usuarioid"));
			session.setAttribute("online","F");//Grava sessao de login
			session.setAttribute("sessao","T");//Grava sessao de login
				
				//Dados para armazenamento de arquivos de voz
				Connection coneccao2 = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");			
				PreparedStatement sql2=coneccao2.prepareStatement("select valor from laudoconfig where configid='ftp_host'");
				ResultSet resultado2=sql2.executeQuery();
				if (resultado2.next()){session.setAttribute("ftp_host",resultado2.getString("valor"));}
				
				Connection coneccao3 = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");			
				PreparedStatement sql3=coneccao3.prepareStatement("select valor from laudoconfig where configid='ftp_user'");
				ResultSet resultado3=sql3.executeQuery();
				if (resultado3.next()){session.setAttribute("ftp_user",resultado3.getString("valor"));}
				
				Connection coneccao4 = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");			
				PreparedStatement sql4=coneccao4.prepareStatement("select valor from laudoconfig where configid='ftp_password'");
				ResultSet resultado4=sql4.executeQuery();
				if (resultado4.next()){session.setAttribute("ftp_password",resultado4.getString("valor"));}

				Connection coneccao5 = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");			
				PreparedStatement sql5=coneccao5.prepareStatement("select valor from laudoconfig where configid='dir'");
				ResultSet resultado5=sql5.executeQuery();
				if (resultado5.next()){session.setAttribute("dir",resultado5.getString("valor"));}
				
				Connection coneccao6 = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");			
				PreparedStatement sql6=coneccao6.prepareStatement("select valor from laudoconfig where configid='ftp_dir'");
				ResultSet resultado6=sql6.executeQuery();
				if (resultado6.next()){session.setAttribute("ftp_dir",resultado6.getString("valor"));}
				
				Connection coneccao7 = DriverManager.getConnection("jdbc:mysql://localhost/pacsdb","root","root");			
				PreparedStatement sql7=coneccao7.prepareStatement("select valor from laudoconfig where configid='weasis_link'");
				ResultSet resultado7=sql7.executeQuery();
				if (resultado7.next()){session.setAttribute("weasis_link",resultado7.getString("valor"));}

				//out.println((String)session.getAttribute("ftp_host"));
				//out.println((String)session.getAttribute("ftp_user"));
				//out.println((String)session.getAttribute("ftp_password"));
				//out.println((String)session.getAttribute("dir"));
				response.sendRedirect("oviyam"); //Redireciona para pagina inicial			
			} 
		else{
			//out.println("fora");
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