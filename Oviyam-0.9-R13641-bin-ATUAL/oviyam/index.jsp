<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String cookieName = "agree";
	Cookie cookies[] = request.getCookies();
	Cookie myCookie = null;
	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals(cookieName)) {
		myCookie = cookies[i];
		break;
			}
		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Gnect Viewer</title>
<style>
	#hiddenPane{
		
		position: absolute;
		top:0px;
		left:0px;
		height: 100%;
		width: 100%;
		text-align: center;
		visibility:hidden;
		z-index:10000;
		background:#000000;
		opacity:.85;
	}
	#dialogDiv {
		position: relative;
		width:500px;
		border:1px solid #FFFFFF;
		margin: 20% auto;
		margin-top: 20%;
		/*  top: -50px;*/
		height: 200px;
		text-align: center;
		color:#FFFFFF;
		background:#232323;		
	}
</style>	

<script>
	function showDialog(){
		document.getElementById('hiddenPane').style.visibility="visible";
		document.getElementById('welcomePane').style.visibility="hidden";
	}
	
	function hideDialog(){
		document.getElementById('hiddenPane').style.visibility="hidden";	
	}
</script>
</head>

<%
			if (myCookie != null) {
		%> 
		
		<jsp:forward page="oviyam" />
		
		<%
			} else {
		%>


<body bgcolor="#000000" onload="showDialog();" >

<div id="hiddenPane">
	<div id="dialogDiv">
		<center>
			<table>
				<tr>
					<td colspan="2">
						<p align="justify" style="position:relative;color:#FFFFFF;">
					 	  <b>Nota importante.</b><br>
							Gnect Viewer é um software de visualização de imagens licenciado pela Gnect. Estou de acordo com a política de uso do software acordada com o fornecedor GNECT.
						</p>
					</td>
				</tr>							
				<tr>
					<td colspan="2" align="right">
						<form action="oviyam" method="GET">
							<input type="checkbox" value="agree" name="agree">Não exiba essa mensagem novamente. <br>
							<input type="submit" value="Concordo">
							<input type="button" value="Não concordo." onclick="hideDialog();">
						</form>									
						
					</td>					
				</tr>
			</table>			
		</center>
	</div>
</div>	
</body>
<%
			}
		%>
</html>