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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" isELIgnored="false" %> 
<%@ page errorPage="ErrorPage.jsp" %>
<%@ taglib prefix="ser" uri="SeriesInfo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 	//Redireciona se a sessao for invalida
if ((session.getAttribute("sessao")=="F")||(null == session.getAttribute("sessao"))){response.sendRedirect("login.jsp");} %>

<center>	
	<div>
		<table>
			<ser:Series patientId="${param.patient}" study="${param.study}">
				<tr><td>
				<c:choose>				 
					<c:when test="${modality =='SR' }">
						<div class="image">
						<img width="128px" class="reflec" src="images/icons/SR_Latest.png"  onclick="loadSeriesHandler(this,'ImageContainer.jsp?patient=${param.patient}&study=${param.study}&series=${seriesId}&modality=${modality}&seriesDesc=${seriesDescs }&totalImages=${numberOfImages}&imageId=${imageId }&studyDescription=${param.studyDescription }&sex=${param.sex }&birthDate=${param.birthDate}&studyDates=${param.studyDates }&physicianName=${param.physicianName}','${numberOfImages}', 'SRContent','Image.do?study=${param.study}&series=${seriesId}&object=${imageId }&contentType=text/html');"/>
						</div>
						<div class="seriesDetails">${seriesDescs}</div>
						<div class="seriesDetails">Total Images : ${numberOfImages}</div><br>
					</c:when>
					
					<c:when test="${modality =='KO' }">
						<div class="image" onclick=>
						    <img  width="128px" class="reflec" src="images/icons/KO.png"  onclick="loadSeriesHandler(this,'ImageContainer.jsp?patient=${param.patient}&study=${param.study}&series=${seriesId}&modality=${modality}&seriesDesc=${seriesDescs}&totalImages=${numberOfImages}&imageId=${imageId }&studyDescription=${param.studyDescription }&sex=${param.sex }&birthDate=${param.birthDate }&studyDates=${param.studyDates }&physicianName=${param.physicianName }',' ${numberOfImages}', 'KOContent', 'Image.do?study=${param.study}&series=${seriesId}&object=${imageId }&contentType=text/html');"/>
						</div>
						<div class="seriesDetails">${seriesDescs}</div>				
						<div class="seriesDetails">Total Images : ${numberOfImages}</div><br>
					</c:when>
					
					<c:when test="${modality =='XA' }">
						<div class="image">
						    <img id="series${seriesNumber}" width="128px" class="reflec" src="Image.do?study=${param.study}&series=${seriesId}&object=${imageId}&rows=128" onclick="inc=0; loadSeriesHandler(this,'ImageContainer.jsp?patient=${param.patient}&study=${param.study}&series=${seriesId}&modality=${modality}&seriesDesc=${seriesDescs}&totalImages=${numberOfImages}&imageId=${imageId }&studyDescription=${param.studyDescription }&sex=${param.sex }&birthDate=${param.birthDate }&studyDates=${param.studyDates }&physicianName=${param.physicianName }','${numberOfImages}');">
						</div>
						<div class="seriesDetails">${seriesDescs}</div>				
						<div class="seriesDetails">Total Images : ${numberOfImages}</div><br>
					</c:when>
					
					<c:when test="${modality == 'ES' && sopClassUID == '1.2.840.10008.5.1.4.1.1.77.1.1.1' }">					
						<div class="image">
						    <img id="series${seriesNumber}" width="128px" class="reflec" src="images/icons/icn_video.gif" onclick="loadSeriesHandler(this,'ImageContainer.jsp?patient=${param.patient}&study=${param.study}&series=${seriesId}&modality=${modality}&seriesDesc=${seriesDescs}&totalImages=${numberOfImages}&imageId=${imageId }&studyDescription=${param.studyDescription }&sex=${param.sex }&birthDate=${param.birthDate }&studyDates=${param.studyDates }&physicianName=${param.physicianName }&sopClassUid=${sopClassUID}'); "/>
						</div>
						<div class="seriesDetails">${seriesDescs}</div>				
						<div class="seriesDetails">Total Images : ${numberOfImages}</div><br>
					</c:when>	
					
					<c:when test="${sopClassUID =='1.2.840.10008.5.1.4.1.1.104.1' }">
						<div class="image" onclick="borderThumb=''; initScroll(); loadImages('ImageContainer.jsp?patient=${param.patient}&study=${param.study}&series=${seriesId}&modality=${modality}&seriesDesc=${seriesDescs}&totalImages=${numberOfImages}&imageId=${imageId }&studyDescription=${param.studyDescription }&sex=${param.sex }&birthDate=${param.birthDate }&studyDates=${param.studyDates }&physicianName=${param.physicianName }&sopClassUid=${sopClassUID}');"><img  width="128px" class="reflec" src="images/icons/PDF.png" onclick="changeSeriesBorder(this); changeFirstImgBorder('img0'); "></div>
						<div class="seriesDetails">${seriesDescs}</div>				
						<div class="seriesDetails">Total Images : ${numberOfImages}</div><br>
					</c:when>

					<c:otherwise>
<%--Standard dicom image here.--%>
						<div class="image"> 
						    <img id="series${seriesNumber}"  width="128px" class="reflec" src="Image.do?study=${param.study}&series=${seriesId}&object=${imageId}&rows=128" onclick="resetAll();globalWC=globalWW=0;isWLAdjusted=false; slideshowspeed=500; resetLoop(); multiFrames=false;inc=0; loadSeriesHandler(this,'ImageContainer.jsp?patient=${param.patient}&study=${param.study}&series=${seriesId}&modality=${modality}&seriesDesc=${seriesDescs}&totalImages=${numberOfImages}&imageId=${imageId }&studyDescription=${param.studyDescription }&sex=${param.sex }&birthDate=${param.birthDate }&studyDates=${param.studyDates }&physicianName=${param.physicianName }', '${numberOfImages}'); hideDataSet();"/></div>
						<div class="seriesDetails">${seriesDescs}</div>				
						<div class="seriesDetails">Total Images : ${numberOfImages}</div><br>
					</c:otherwise>
				</c:choose>
				</td></tr>
			</ser:Series>
		</table>
	</div>
</center>