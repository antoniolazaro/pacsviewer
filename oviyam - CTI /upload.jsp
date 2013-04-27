<%@ page import="java.io.*" %>
<%@page import="java.text.*" %>   
<%@page import="java.util.Date" %>   
<%@page import="java.sql.*" %>
<%@page import="java.lang.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%
	//Variaveis de sessão
	String arquivo_nome = (String)session.getAttribute("arquivo_nome");	
	
	//to get the content type information from JSP Request Header
	String contentType = request.getContentType();
	//here we are checking the content type is not equal to Null and as well as the passed data from mulitpart/form-data is greater than or equal to 0
	if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
 		DataInputStream in = new DataInputStream(request.getInputStream());
		//we are taking the length of Content type data
		int formDataLength = request.getContentLength();
		byte dataBytes[] = new byte[formDataLength];
		int byteRead = 0;
		int totalBytesRead = 0;
		//this loop converting the uploaded file into byte code
		while (totalBytesRead < formDataLength) {
			byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
			totalBytesRead += byteRead;
			}

		String file = new String(dataBytes);
		//for saving the file name
		String saveFile = file.substring(file.indexOf("filename=\"") + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));
		int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex + 1,contentType.length());
		int pos;
		//extracting the index of file 
		pos = file.indexOf("filename=\"");
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

		//String today = new SimpleDateFormat("yyyyMMdd").format(new Date());	
		//saveFile = today;
		// creating a new file with the same name and writing the content in new file
		//FileOutputStream fileOut = new FileOutputStream("c:/pacs/sound/"+arquivo_nome+".wav");
		FileOutputStream fileOut = new FileOutputStream((String)session.getAttribute("dir")+arquivo_nome+".wav");
		fileOut.write(dataBytes, startPos, (endPos - startPos));
		fileOut.flush();
		fileOut.close();
		}

		
		//Processar status do arquivo para processado
		//String patientid = (String)session.getAttribute("patientidfile");
		//String nome = (String)session.getAttribute("nomefile");
		//String modality = (String)session.getAttribute("modalityfile");
		//String date = (String)session.getAttribute("datefile");
		//String exame = (String)session.getAttribute("examefile");
		String opcao = (String)session.getAttribute("opcaofile");
		//String laudotexto2 = (String)session.getAttribute("laudotexto2file");
		//String laudocad = (String)session.getAttribute("laudocadfile");			
		//String liberarlaudo = (String)session.getAttribute("liberarlaudofile");
		String usuarioid = (String)session.getAttribute("usuarioid");
		
		//out.println(patientid+"-");
		//out.println(nome+"-");
		//out.println(modality+"-");
		//out.println(date+"-");
		//out.println(exame+"-");
		//out.println(opcao+"-");
		//out.println(laudotexto2+"-");
		//out.println(laudocad+"-");
		//out.println(liberarlaudo+"-");
		//out.println(usuarioid+"-");

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
				sql.setString(1,(String)session.getAttribute("patientidfile"));
				sql.setString(2,(String)session.getAttribute("nomefile"));
				sql.setString(3,(String)session.getAttribute("examefile"));
				sql.setString(4,(String)session.getAttribute("modalityfile"));
				sql.setString(5,(String)session.getAttribute("datefile"));
				sql.setString(6,(String)session.getAttribute("laudotexto2file"));		
				sql.setString(7,(String)session.getAttribute("liberarlaudofile"));				
				sql.setString(8,usuarioid);
				sql.executeUpdate();
			}else if (opcao.equals("update")){
				PreparedStatement sql=coneccao.prepareStatement("UPDATE laudo SET laudo = ?, liberado = ? WHERE laudoid = ?");
				sql.setString(1,(String)session.getAttribute("laudotexto2file"));		
				sql.setString(2,(String)session.getAttribute("liberarlaudofile"));		
				sql.setString(3,(String)session.getAttribute("laudocadfile"));
				sql.executeUpdate();
			}

			coneccao.close();
	  }catch (SQLException e) {
				out.println("erro sql:"+e.getMessage());
			}
		
		%>
		<!-- /td></tr></table--><style type="text/css">
		<!--body {	background-color: #000000;}.style1 {color: #FFFFFF}-->
        </style> 
		  <span class="style2 style1">Arquivo recebido com sucesso!!</span></p>
			<p align="center">&nbsp;</p>
			<p align="center">  <span class="style3"><a href="javascript:self.close();window.opener.reload();"><img src="images/laudo_fechar.gif"/>Fechar</a>

		<%//Redirecionar
		  //response.sendRedirect("laudo.jsp?patientid=&nome="+nome+"&modality="+modality+"&date="+date+"&exame="+exame+"&opcao="+opcao+"&laudoid="+laudoid+"&laudoload="+laudoload+"&laudocad="+laudocad+"&liberarlaudo="+liberarlaudo+"&usuarioid="+usuarioid+"");
		%>
