<!--
/* ***** BEGIN LICENSE BLOCK *****
* Version: MPL 1.1/GPL 2.0/LGPL 2.1
*
* The contents of this file are subject to the Mozilla Public License Version
* 1.1 (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
* http://www.mozilla.org/MPL/
*
* Software distributed under the License is distributed on an "AS IS" basis,
* WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
* for the specific language governing rights and limitations under the
* License.
*
* The Original Code is part of Oviyam, an web viewer for DICOM(TM) images
* hosted at http://skshospital.net/pacs/webviewer/oviyam_0.6-src.zip 
*
* The Initial Developer of the Original Code is
* Raster Images
* Portions created by the Initial Developer are Copyright (C) 2007
* the Initial Developer. All Rights Reserved.
*
* Contributor(s):
* Asgar Hussain B
* Babu Hussain A
* Bharathi B
* Manikandan P
* Prakash J
* Prakasam V
* Suresh V
*
* Alternatively, the contents of this file may be used under the terms of
* either the GNU General Public License Version 2 or later (the "GPL"), or
* the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
* in which case the provisions of the GPL or the LGPL are applicable instead
* of those above. If you wish to allow use of your version of this file only
* under the terms of either the GPL or the LGPL, and not to allow others to
* use your version of this file under the terms of the MPL, indicate your
* decision by deleting the provisions above and replace them with the notice
* and other provisions required by the GPL or the LGPL. If you do not delete
* the provisions above, a recipient may use your version of this file under
* the terms of any one of the MPL, the GPL or the LGPL.
*
* ***** END LICENSE BLOCK ***** */ 
-->
<?xml version="1.0"?>
<web-app version="2.4" xmlns="http://java.sun.com/xml/ns/j2ee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd">
<%@page import="java.sql.*" %>
<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>    
<%@page isELIgnored="false"%>
<%@taglib prefix="pat" uri="PatientInfo" %>
<%@taglib prefix="study" uri="StudyInfo" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jstl/sql"  %>
<%@taglib prefix="sql2" uri="http://java.sun.com/jstl/sql_rt" %>

<% 	//Redireciona se a sessao for invalida
if ((session.getAttribute("sessao")=="F")||(null == session.getAttribute("sessao"))){response.sendRedirect("login.jsp");} %>

<%	//Verifica se requisição veio do resultado online
if (session.getAttribute("online").equals("T")){
	pageContext.setAttribute("patientId",(String)session.getAttribute("patientId")) ;
	pageContext.setAttribute("modality",(String)session.getAttribute("modality")) ;
	pageContext.setAttribute("from",(String)session.getAttribute("data")) ;
	pageContext.setAttribute("to",(String)session.getAttribute("data")) ;
	pageContext.setAttribute("searchDate",(String)session.getAttribute("data")) ;
	pageContext.setAttribute("group1","between") ;
	pageContext.setAttribute("online",(String)session.getAttribute("online")) ;	
	//String patientId = (String)session.getAttribute("patientId");
	//String modality  = (String)session.getAttribute("modality");	
	//String from      = (String)session.getAttribute("data");
	//String to        = (String)session.getAttribute("data");			
	//String searchDate= (String)session.getAttribute("data");			
	//String group1	 ="between";					   
	//String online	 = (String)session.getAttribute("online");					   
}
else if (session.getAttribute("online").equals("F")){
	pageContext.setAttribute("patientId",request.getParameter("patientId")) ;
	pageContext.setAttribute("modality",request.getParameter("modality")) ;
	pageContext.setAttribute("from",request.getParameter("from")) ;
	pageContext.setAttribute("to",request.getParameter("to")) ;
	pageContext.setAttribute("searchDate",request.getParameter("searchDate")) ;
	pageContext.setAttribute("group1",request.getParameter("group1")) ;
	pageContext.setAttribute("online",(String)session.getAttribute("online")) ;	
	//String patientId = request.getParameter("patientId") ;
	//String modality  = request.getParameter("modality") ;	
	//String from      = request.getParameter("from") ;		
	//String to        = request.getParameter("to") ;			
	//String searchDate= request.getParameter("searchDate") ;				
	//String group1	 = request.getParameter("group1") ;				
	//String online	 = (String)session.getAttribute("online");					   	
}
%>


<sql:setDataSource var="mdb" driver="com.mysql.jdbc.Driver"
       url="jdbc:mysql://localhost:3306/pacsdb"
       user="root"
       password="root"
       />
	
<div id="tableContainer" class="TableContainer">
<table id="queryResult"  class="queryResult">

<thead class="fixedHeader">

	<tr>
		<td class="point" >NO</td>
					
					<td  title="Filtrar">Nome</td>
		<td  title="Filtrar"><div align="center">Patient ID</div></td>				
		<td  title="Filtrar"><div align="center">Sexo</div></td>
		<td  title="Filtrar"><div align="center">Data de Nascimento</div></td>
					<!--  <td>Study date</td>
					<td>Modality</td>-->
		<td  title="Filtrar"><div align="center">Medico</div></td>					
	</tr>
</thead>

<tbody class="scrollContent" id="queryBody">
	<pat:Patient patientId="${patientId}" patientName="${param.patientName}" birthDate="${param.birthDate}" searchDate="${searchDate}" modality="${modality}" 
	
		from="${from}" to="${to}" searchDays="${group1}" accessionNumber="${param.accessionNumber}">
	
		<tr style="vertical-align:top;">
			<td class="serNo" >${serNo }</td>		
			<td> 
			<table id="innerTable">
			<c:choose>
				<c:when test="${sex =='F' || sex=='f' }">		
					<tr title="Female"> <td class="serNo" colspan="4" ><img style="background:transparent;" src="images/pic1.gif" alt=""/>&nbsp;&nbsp;${patientName}</td></tr>
				</c:when>
				<c:when test="${sex =='M' || sex=='m' }">	
					<tr title="Male"> <td class="serNo" colspan="4" ><img style="background:transparent;" src="images/patient-temp1.gif" alt=""/>&nbsp;&nbsp;${patientName}</td></tr>
				</c:when>
				<c:otherwise>	
					<tr title="Unknown"> <td class="serNo" colspan="4" >${patientName}</td></tr>
				</c:otherwise>	
			</c:choose>
	<study:Study patientId="${patientId}" modality="${param.modality}">	
						<tr>						
							<td id="plusTD" class = "studyInfo" onclick=" addRow(${no},'seriesDetails.jsp?patient=${patientId }&study=${studyId}&studyDescription=${studyDescription}&sex=${sex }&birthDate=${birthDate }&studyDates=${studyDates }&physicianName=${physicianName}');"><center><img alt="" title="click to expand/shrink this study" id="expand${no}" src="images/TopPlus1.gif" class="expand"/> </center></td>
							<td id="studyDescTD" class = "studyInfo" colspan="3" onclick= 'hidePatient(); hidesereis=1;hideSeries(); document.getElementById("imagePane").innerHTML=""; ajaxpage("seriesPane", "SeriesInfo.jsp?patient=${patientId }&study=${studyId}&studyDescription=${studyDescription }&sex=${sex }&birthDate=${birthDate }&studyDates=${studyDates }&physicianName=${physicianName}"); resetLoop(); setPatientInfoVisible("${patientName}"); return false'>
								${studyDescription}							</td>

							<td id="modalityTD">
							 
							 <c:if test="${online=='F'}">
							 <sql2:query var="results" dataSource="${mdb}" >select laudoid,digitado,liberado,count(*) as total from laudo where nome='${patientName}' and modality='${modalityInStudy}' and date='${studyDates}' and exame='${studyDescription}' and patientid='${patientId}'							 </sql2:query>
							 <c:forEach var="listalaudos" items="${results.rows}">
							 <c:choose>
                        		<c:when test="${listalaudos.total>0}">
                        				<a href="#" onclick="window.open('laudo.jsp?patientid=${patientId}&modality=${modalityInStudy}&date=${studyDates}&exame=${studyDescription}&nome=${patientName}&opcao=update&laudoload=F&laudocad=${listalaudos.laudoid}','Janela','toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=640,height=500'); 
			return false;" class="v8" ><img src="images/com_laudo.gif" alt="Com laudo" border="0" /></a>
										<c:choose>
										<c:when test="${listalaudos.digitado=='T'}"><img src="images/laudodigitado.gif" alt="Digitado" border="0" ></img></c:when>
										</c:choose>
										<c:choose>
										<c:when test="${listalaudos.liberado=='T'}"><img src="images/laudoliberado.gif" alt="Liberado" border="0" ></img></c:when>
										<c:when test="${listalaudos.liberado=='F'}"><img src="images/laudonaoliberado.gif" alt="A liberar" border="0" ></img></c:when>
										</c:choose>
										${modalityInStudy}                       			</c:when>
                        		<c:otherwise>
                        				<a href="#" onclick="window.open('laudo.jsp?patientid=${patientId}&modality=${modalityInStudy}&date=${studyDates}&exame=${studyDescription}&nome=${patientName}&opcao=insert&laudoload=F','Janela','toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=640,height=500'); 
			return false;" class="v8" ><img src="images/sem_laudo.gif" alt="Sem laudo" border="0" /></a>${modalityInStudy}								</c:otherwise>                        		
						       </c:choose>
					 		 </c:forEach>							
							</c:if>
							 
							 <c:if test="${online=='T'}">
							 ${modalityInStudy}
							 </c:if>							
							
							<!-- c:if test="${online=='F'}"-->
							<a href="#" onclick="window.open('laudo_weasis.jsp?patientid=${patientId}&modality=${modalityInStudy}&date=${studyDates}&exame=${studyDescription}&nome=${patientName}&opcao=insert&studyId=${studyId}&laudoload=F','Janela','toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=250,height=300'); 
			return false;" class="v8" ><img src="images/weasis_viewer_button.png" alt="Weasis" border="0" /></a>					 		 
							 <!--/c:if-->					
							 			
					 		 </td>

							<td id="studyDateTD">
								${studyDates}							</td>
						</tr>
						<tr>
							<td ></td>
							<td colspan="3" align="left">
							<div style="position:relative;width:100%;" id="seriesHolder${no}" class="seriesHolder">							</div>							</td>
						</tr> 
			  </study:Study>
		  </table>			</td>
		  <td><div align="center">${patientId}</div></td>
		  <td><div align="center">${sex}</div></td>
		  <td><div align="center">${birthDate}</div></td>			
		  <td><div align="center">${phy_name}</div></td>
		</tr>
	</pat:Patient>
</tbody>
</table>
</div>
