<!--contents of download.jsp-->
<%@ page import="java.util.*,java.io.*"%>
<!--Assumes that file name is in the request objects query Parameter -->
<%	
	//Variaveis de sessão
	String arquivo_nome = (String)session.getAttribute("arquivo_nome");	
	//read the file name.
	//File f = new File ("c:/pacs/sound/"+arquivo_nome+".wav");// + request.getParameter("file") );
	File f = new File ((String)session.getAttribute("dir")+arquivo_nome+".wav");
	//set the content type(can be excel/word/powerpoint etc..)
	response.setContentType ("application/pdf");
	//set the header and also the Name by which user will be prompted to save
	response.setHeader("Content-Disposition", "attachment; filename="+arquivo_nome+".wav");
	//get the file name
	String name = f.getName().substring(f.getName().lastIndexOf("/") + 1,f.getName().length());
	//OPen an input stream to the file and post the file contents thru the 
	//servlet output stream to the client m/c
	
		InputStream in = new FileInputStream(f);
		ServletOutputStream outs = response.getOutputStream();
	
		int bit = 256;
		int i = 0;
		try {
			while ((bit) >= 0) {
				bit = in.read();
				outs.write(bit);
			}
			//System.out.println("" +bit);
		} catch (IOException ioe) {
			ioe.printStackTrace(System.out);
		}
		//System.out.println( "\n" + i + " bytes sent.");
		//System.out.println( "\n" + f.length() + " bytes sent.");
		outs.flush();
		outs.close();
		in.close();
%>


