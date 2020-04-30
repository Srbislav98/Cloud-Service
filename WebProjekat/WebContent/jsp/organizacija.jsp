<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <jsp:useBean id="user" class="beans.Korisnik" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/WebProjekat/css/pocetna.css">
<meta charset="ISO-8859-1">
<title>Organizacija</title>
</head>
<%
	response.setHeader("cache-Control","no-cache,no-store,must-revalidate"); 
	response.setHeader("Pragma","no-cache");    
	response.setHeader("Expires","0");
	System.out.println(session.getAttribute("user"));
	if(user.getPrijavljen().equals("ne"))
		response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
%>
<body>


  <div class="header">
    <h1>WEB 1920</h1>
    <p class="citat">Dobro dosli na nas web sajt.</p>
  </div>
  <div class="navigacija">
  	<c:if test= "${user.uloga != 'Korisnik'}">
    <form action="http://localhost:8080/WebProjekat/jsp/organizacija.jsp" class="organizacija" >
 		<input type="submit" value="Organizacija">
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/korisnici.jsp" class="korisnici" >
 		<input type="submit" value="Korisnici">
 	</form>
 	</c:if>
    <form action="http://localhost:8080/WebProjekat/jsp/profil.jsp" class="profil" >
 		<input type="submit" value="Profil" >
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/pocetna.jsp" class="vm" method="post">
 		<input type="submit" value="VM" >
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/disk.jsp" class="disk" >
 		<input type="submit" value="Disk">
 	</form>
 	<c:if test= "${user.uloga == 'Super admin'}">
    <form action="http://localhost:8080/WebProjekat/jsp/kategorija.jsp" class="kategorija" >
 		<input type="submit" value="Kategorija">
 	</form>
 	</c:if>
    <form action="http://localhost:8080/WebProjekat/Logout" class="odjava" >
 		<input type="submit" value="Logout">
 	</form>
  </div>
  <div class="tablediv">
  	<table class="table">
		<tr>
		   <th>Ime</th>
		   <th>Opis</th>
		   <th>Logo</th>
		  <th>Uredjivanje</th>
		</tr>
		<c:forEach var="v" items="${applicationScope.organizacije}">
		<c:if test= "${user.uloga == 'Super admin' || user.organizacija==v.ime }">
			<tr class="filterDiv">
				<td class="myclass"><c:out value="${v.ime}" /></td>
				<td class="myclass"><c:out value="${v.opis}" /></td>
				<td class="myclass"><c:out value="${v.logo}" /></td>
				<!--  
				<td>
					<ul>
						<c:forEach var="diskic" items="${v.korisnici}">
							<li class="myclass"><c:out value="${diskic}" /></li>
						</c:forEach>
					</ul>
				</td>
				<td>
					<ul>
						<c:forEach var="diskic" items="${v.resursi}">
							<li class="myclass"><c:out value="${diskic}" /></li>
						</c:forEach>
					</ul>
				</td>
				-->
				<td><input class="btn btn-warning btn-lg izmeni" style="width:105%;" value='Izmena/Pregled' type='button'  onclick="otvoriIzmenu()"/></td>
			</tr>
		</c:if>
		</c:forEach>
		<tr>
			<td colspan="4" style="text-align:center"><input class="btn btn-warning btn-lg izmeni" type='button' value='Dodavanje'  onclick="otvoriDodavanje()"/></td>
		</tr>	
   </table>
   <div id="modaldark">
   <div class="form-popup" id="myForm1">
    <h4>Dodavanje organizacije</h4>
    <br>
    <input type="text" class="fotrol" placeholder="Ime">
    <input type="text" class="fotrol" placeholder="Opis">
    <input type="text" class="fotrol" placeholder="URL logo">
    <input type="file" value = "onUpload" >
    <button type="button" class="btn maal leftbutton" onclick="dodaj()">Potvrdi</button>
    <button type="button" class="btn zaal rightbutton" onclick="otkaziIzmenu()">Otkazi</button>
   </div>
   <div class="form-popup" id="myForm2">
    <h4>Izmena organizacije</h4>
    <br>
    <input type="text" class="fotrol" placeholder="Ime">
    <input type="text" class="fotrol" placeholder="Opis">
    <input type="text" class="fotrol" placeholder="URL logo">
    <input type="file" value = "onUpload" >
    <button type="button" class="btn maal leftbutton" onclick="izmeni()">Potvrdi</button>
    <button type="button" class="btn zaal rightbutton" onclick="otkaziIzmenu()">Otkazi</button>
   </div>
   </div>
   </div>
</body>
<script>
function otvoriDodavanje() {
	document.getElementById("myForm1").style.display = "block";
	document.getElementById("modaldark").style.display = "block";
	document.getElementById("modaldark").style.opacity="1";
}
function otvoriIzmenu() {
	document.getElementById("myForm2").style.display = "block";
	document.getElementById("modaldark").style.display = "block";
	document.getElementById("modaldark").style.opacity="1";
}
function otkaziDodavanje() {
	document.getElementById("myForm1").style.display = "none";
	document.getElementById("modaldark").style.display = "none";
	document.getElementById("modaldark").style.opacity="0";
}
function otkaziIzmenu() {
	document.getElementById("myForm2").style.display = "none";
	document.getElementById("modaldark").style.display = "none";
	document.getElementById("modaldark").style.opacity="0";
}
</script>
</html>