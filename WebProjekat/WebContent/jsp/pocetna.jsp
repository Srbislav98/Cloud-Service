<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <jsp:useBean id="user" class="beans.Korisnik" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/WebProjekat/css/pocetna.css">
<meta charset="ISO-8859-1">
<title>Pocetna</title>
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
    <p class="citat">Dobro dosli na nas web sajt!</p>
  </div>
  <div class="navigacija">
  	<c:if test= "${user.uloga != 'Korisnik'}">
    <form action="http://localhost:8080/WebProjekat/jsp/organizacija.jsp" class="organizacija" >
 		<input type="submit" value="Organizacija" >
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/korisnici.jsp" class="korisnici" >
 		<input type="submit" value="Korisnici" >
 	</form>
 	</c:if>
    <form action="http://localhost:8080/WebProjekat/jsp/profil.jsp" class="profil" >
 		<input type="submit" value="Profil" >
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/pocetna.jsp" class="vm" method="post">
 		<input type="submit" value="VM" >
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/disk.jsp" class="disk" >
 		<input type="submit" value="Disk" >
 	</form>
 	<c:if test= "${user.uloga == 'Super admin'}">
    <form action="http://localhost:8080/WebProjekat/jsp/kategorija.jsp" class="kategorija" >
 		<input type="submit" value="Kategorija" >
 	</form>
 	</c:if>
    <form action="http://localhost:8080/WebProjekat/Logout" class="odjava" >
 		<input type="submit" value="Odjavi se">
 	</form>
  </div>
  <div class="tablediv">
  	<table class="table">
		<tr>
		   <th>Ime</th>
		   <th>Organizacija</th>
		   <th>Br jezgara</th>
		   <th>Ram</th>
		   <th>Gpu</th>
		   <th colspan="2">Uredjivanje</th>
		  <!--<th>Diskovi</th>
		   <th colspan="2">Aktivnosti</th>-->
		</tr>
		<c:forEach var="v" items="${applicationScope.vme}">
		<c:if test= "${user.uloga == 'Super admin' || user.organizacija==v.organizacija }">
			<tr class="filterDiv">
				<td class="myclass"><c:out value="${v.ime}" /></td>
				<td class="myclass"><c:out value="${v.organizacija}" /></td>
				<td class="myclass"><c:out value="${v.jezgara}" /></td>
				<td class="myclass"><c:out value="${v.ram}" /></td>
				<td class="myclass"><c:out value="${v.gpu}" /></td>
				<!--<c:forEach var="diskic" items="${v.diskovi}">
				<td class="myclass"><c:out value="${diskic}" /></td>
				</c:forEach>
				<td>
					<ul>
						<c:forEach var="diskic" items="${v.diskovi}">
							<li class="myclass"><c:out value="${diskic}" /></li>
						</c:forEach>
					</ul>
				</td>
				<td>
					<ul>
						<c:forEach var="vreme" items="${v.aktivnosti}">
							<li class="myclass"><c:out value="${vreme.pocetak}" /></li>
						</c:forEach>
					</ul>
				</td>
				<td>
					<ul>
						<c:forEach var="vreme" items="${v.aktivnosti}">
							<li class="myclass"><c:out value="${vreme.kraj}" /></li>
						</c:forEach>
					</ul>
				</td>-->
				<td><input class="btn btn-warning btn-lg izmeni" style="width:105%;" value='Izmena/Pregled' type='button'  onclick="otvoriIzmenu()"/></td>
				<c:if test= "${user.uloga == 'Super admin' || (user.organizacija==v.organizacija && user.uloga=='Admin') }">
				<td><input class="btn btn-warning btn-lg izmeni" style="width:115%;" value='Obrisi' type='button' onclick="obrisi()"/></td>
				</c:if>
			</tr>
		</c:if>
		</c:forEach>
		<c:if test= "${user.uloga == 'Super admin' || user.uloga=='Admin'}">
		<tr>
			<td colspan="7" style="text-align:center"><input class="btn btn-warning btn-lg izmeni" type='button' value='Dodaj novu virtuelnu masinu'  onclick="otvoriDodavanje()"/></td>
		</tr>	
		</c:if>
   </table>
   <div id="modaldark">
   <div class="form-popup" id="myForm1">
    <form action="#" method="get">
    <legend>Dodavanje virtuelne masine</legend>
    <br>
    <label>Ime:<input name="" type="text" class="fotrol" placeholder="Unesite ime"></label>
    <label>Organizacija:<input name="" type="text" class="fotrol" placeholder="Unesite organizaciju"></label>
    <label>Broj jezgara:<input name="" type="number" class="fotrol" placeholder="Unesite broj jezgara"></label>
    <label>Ram:<input name="" type="number" class="fotrol" placeholder="Unesite ram"></label>
    <label>Gpu:<input name="" type="number" class="fotrol" placeholder="Unesite gpu"></label>
    <br><br><br>
    <button type="submit" class="btn maal leftbutton">Potvrdi</button>
    <button type="button" class="btn zaal rightbutton" onclick="otkaziDodavanje()">Otkazi</button>
   </form>
   </div>
   <div class="form-popup" id="myForm2">
    <legend>Izmena i pregled virtuelne masine</legend>
    <br>
    <label>Ime:<input name="" type="text" class="fotrol" placeholder="Unesite ime"></label>
    <label>Organizacija:<input name="" type="text" class="fotrol" placeholder="Unesite organizaciju"></label>
    <label>Broj jezgara:<input name="" type="number" class="fotrol" placeholder="Unesite broj jezgara"></label>
    <label>Ram:<input name="" type="number" class="fotrol" placeholder="Unesite ram"></label>
    <label>Gpu:<input name="" type="number" class="fotrol" placeholder="Unesite gpu"></label>
    <br><br><br>
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