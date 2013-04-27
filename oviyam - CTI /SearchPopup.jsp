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
* Babu Hussain A
* Bharathi B
* Manikandan P
* Meer Asgar Hussain B
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
<%@page import="java.sql.*" %>
<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@page contentType="text/html"%>

<% 	//Redireciona se a sessao for invalida
if ((session.getAttribute("sessao")=="F")||(null == session.getAttribute("sessao"))){response.sendRedirect("login.jsp");} 
%>

<style>
	#modalityTable { width:85%; }
        #modalityTable td {vertical-align: bottom; }
</style>

<table class="searchTable" id="searchTable" width="100%" style="color:#FFFFFF;">
	<tr>
		<td>
			<table class="searchTable">
				<tr>
					<td>
						<% if (session.getAttribute("online").equals("F")){	%>
						<input type="radio" name="group1" value="today" onclick="$('from').value='';$('to').value='';">Hoje
						<% } %>
					</td>
				</tr>
				<tr>
					<td>
						<% if (session.getAttribute("online").equals("F")){	%>
						<input  type="radio" name="group1" value="yesterday" onclick="$('from').value='';$('to').value='';">Ontem
						<% } %>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<% if (session.getAttribute("online").equals("T")){	out.println("<input type='radio' name='group1' value='between' checked='checked' >Entre");}
						else if (session.getAttribute("online").equals("F")){out.println("<input type='radio' name='group1' value='between' >Entre");}%>
					</td>
				</tr>
				<tr>
					<td>
						<table>
							<tr>
								<td>
								<% if (session.getAttribute("online").equals("T")){
										out.println("<input readonly='readonly' name='from' id='from' value='"+session.getAttribute("data")+"' size='10'> ");
										} 
									else if (session.getAttribute("online").equals("F")) {
										%>	
											<input name="from" id="from" value="" size="10">
											<input value="from" onclick="displayDatePicker('from', this);document.getElementsByName('group1')[5].checked=true;" type="button">
										<% } %>
								</td>
							</tr>
							<tr>
								<td>
								<% if (session.getAttribute("online").equals("T")){
										out.println("<input readonly='readonly' id='to' name='to' value="+session.getAttribute("data")+" size='10'>");
										}
									else if (session.getAttribute("online").equals("F")){
										%>
											<input id="to" name="to" value="" size="10">
											<input value="to" onclick="displayDatePicker('to', this);document.getElementsByName('group1')[5].checked=true;" type="button">								
									<% } %>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
			</table>
		</td>
		<td>
			<table class="searchTable">
			<% if (session.getAttribute("online").equals("T")){
				out.println("<tr>");
				out.println("<td>Codigo ID.</td><td><input readonly='readonly' type='text' name='patientId' id='patientId' value="+session.getAttribute("patientId")+"></td>");
				out.println("</tr>");
				out.println("<tr>");
				out.println("<td>Nome </td><td><input readonly='readonly' type='text' name='patientName' id='patientName' value=''></td>");
				out.println("</tr>");
				out.println("<tr>");
				out.println("<td>No. de acesso</td><td><input readonly='readonly' type='text' name='accNo' id='accNo' value=''></td>");
				out.println("</tr>");
				out.println("<tr>");
				out.println("<td>Data de Aniversario</td><td><input readonly='readonly' name='birthDate' id='birthDate' value=''>");
				out.println("</td>");
				out.println("</tr>");
			}
			else if (session.getAttribute("online").equals("F")) {%>
				<tr>
					<td>Codigo ID.</td><td><input type="text" name="patientId" id="patientId" value=""></td>
				</tr>
				<tr>
					<td>Nome </td><td><input type="text" name="patientName" id="patientName" value=""></td>
				</tr>
				<tr>
					<td>No. de acesso</td><td><input type="text" name="accNo" id="accNo" value=""></td>
				</tr>
				
				<tr>
					<td>Data de Aniversario</td><td><input name="birthDate" id="birthDate" value="">
					<input value="select" onclick="displayDatePicker('birthDate', this);" type="button"></td>
				</tr>
				<%}%>
			</table>
		</td>
		<td >
		
		<table class="searchTable" id="modalityTable">
			<% if (session.getAttribute("online").equals("T")){
				out.println("<tr>");
				out.println("<td> <input type='radio' name='modality' value="+session.getAttribute("modality")+" checked='checked'></td><td>"+session.getAttribute("modality")+"</td>");
				out.println("</tr>");				
			} 
			else if (session.getAttribute("online").equals("F")) {%>			
			<tr>
				<td> <input  type="radio" name="modality" value="ALL" checked="checked"></td><td>Todas</td>
				<td> <input  type="radio" name="modality" value="CR"></td><td>CR</td>
				<td> <input  type="radio" name="modality" value="DX"></td><td>DX</td>
			</tr>
			
			<tr>
				<td> <input  type="radio" name="modality" value="CT"></td><td>CT</td>
				<td> <input  type="radio" name="modality" value="SC"></td><td>SC</td>
				<td> <input  type="radio" name="modality" value="US"></td><td>US</td>
			</tr>
			
			<tr>
				<td> <input  type="radio" name="modality" value="MR"></td><td>MR</td>
				<td> <input  type="radio" name="modality" value="NM"></td><td>NM</td>
				<td> <input  type="radio" name="modality" value="PX" ></td><td>PX</td>
			</tr>
			
			<tr>
				<td> <input  type="radio" name="modality" value="XA"></td><td>XA</td>
				<td> <input  type="radio" name="modality" value="RF"></td><td>RF</td>
				<td> <input  type="radio" name="modality" value="OT"></td><td>OT</td>
			</tr>
			<%}%>
		</table>
	</td>
</tr>
</table>