<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <jsp:useBean id="user" class="beans.Korisnik" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/Projekat/CSS/pocetna.css">
<meta charset="ISO-8859-1">
<title>Početna</title>
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
  <div class="fotter">
    <form action="http://localhost:8080/WebProjekat/Organizacija" class="organizacija" >
 		<input type="submit" value="Organizacija" style="background-color:red;height:48px;font-weight:999;">
 	</form>
    <form action="http://localhost:8080/WebProjekat/Korisnici" class="korisnici" >
 		<input type="submit" value="Korisnici" style="background-color:red;height:48px;font-weight:999;">
 	</form>
    <form action="http://localhost:8080/WebProjekat/Profil" class="profil" >
 		<input type="submit" value="Profil" style="background-color:red;height:48px;font-weight:999;">
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/pocetna.jsp" class="vm" method="post">
 		<input type="submit" value="VM" style="background-color:red;height:48px;font-weight:999;">
 	</form>
    <form action="http://localhost:8080/WebProjekat/Disk" class="disk" >
 		<input type="submit" value="Disk" style="background-color:red;height:48px;font-weight:999;">
 	</form>
    <form action="http://localhost:8080/WebProjekat/Kategorija" class="kategorija" >
 		<input type="submit" value="Kategorija" style="background-color:red;height:48px;font-weight:999;">
 	</form>
    <form action="http://localhost:8080/WebProjekat/Logout" class="odjava" >
 		<input type="submit" value="Logout" style="background-color:red;height:48px;font-weight:999;">
 	</form>
  </div>
  	<table align="left" class="table">
		<tr>
		   <th>Ime</th>
		   <th>Organizacija</th>
		   <th>Kategorija</th>
		   <th>Br jezgara</th>
		   <th>Ram</th>
		   <th>Gpu</th>
		   <th>Diskovi</th>
		   <th colspan="2">Aktivnosti</th>
		</tr>
		<c:forEach var="v" items="${applicationScope.vme}">
			<tr class="filterDiv">
				<td class="myclass"><c:out value="${v.ime}" /></td>
				<td class="myclass"><c:out value="${v.organizacija}" /></td>
				<td class="myclass"><c:out value="${v.kategorija}" /></td>
				<td class="myclass"><c:out value="${v.jezgara}" /></td>
				<td class="myclass"><c:out value="${v.ram}" /></td>
				<td class="myclass"><c:out value="${v.gpu}" /></td>
				<!--<c:forEach var="diskic" items="${v.diskovi}">
				<td class="myclass"><c:out value="${diskic}" /></td>
				</c:forEach>-->
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
				</td>
				<td><input class="btn btn-warning btn-lg" value='Izmeni' type='button'  onclick="obrisi()"/></td>
				<td><input class="btn btn-danger btn-lg" value='Obrisi' type='button' onclick="obrisi()"/></td>
			</tr>
		</c:forEach>
		<tr>
			<td></td>
			<td><input type="text" class="fotrol" placeholder="Naziv pregleda"></td>
			<td><input class="btn btn-success" type='button' value='Dodavanje'  onclick="obrisi()"/></td>
		</tr>	
   </table>
</body>
<script>
function obrisi() {
  alert("aaa");
}
</script>
</html>