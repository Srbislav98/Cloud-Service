<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <jsp:useBean id="user" class="beans.Korisnik" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/WebProjekat/css/pocetna.css">
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
  <div class="navigacija">
  	<c:if test= "${user.uloga != 'Korisnik'}">
    <form action="http://localhost:8080/WebProjekat/jsp/organizacija.jsp" class="organizacija" >
 		<input type="submit" value="Organizacija">
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/korisnici.jsp" class="korisnici" >
 		<input type="submit" value="Korisnici" >
 	</form>
 	</c:if>
    <form action="http://localhost:8080/WebProjekat/jsp/profil.jsp" class="profil" >
 		<input type="submit" value="Profil">
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/pocetna.jsp" class="vm" method="post">
 		<input type="submit" value="VM">
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
 		<input type="submit" value="Logout">
 	</form>
  </div>
  <div class="tablediv">
  	<table  class="table">
		<tr>
		   <th>Email</th>
		   <td class="myclass"><input type="text"  style="border:none;background:#fff;"class="form-control"  value="${user.email}"></td>
		</tr>
		<tr>
		   <th>Ime</th>
		   <td class="myclass"><input type="text" style="border:none;background:#EBEBEB;" class="form-control"  value="${user.ime}"></td>
		</tr>
		<tr>
		   <th>Prezime</th>
		   <td class="myclass"><input type="text"  style="border:none;background:#fff;" class="form-control"  value="${user.prezime}"></td>
		</tr>
		<tr>
		   <th>Organizacija</th>
		   <td class="myclass"><input type="text"  style="border:none;background:#EBEBEB;" class="form-control"  value="${user.organizacija}" disabled></td>
		</tr>
		<tr>
		   <th>Uloga</th>
		   <td class="myclass"><input type="text"  style="border:none;background:#fff;" class="form-control"  value="${user.uloga}" disabled></td>
		</tr>
		<tr>
		   <th>Sifra</th>
		   <td class="myclass"><input type="password"  style="border:none;background:#EBEBEB;" class="form-control"  value="${user.lozinka}" ></td>
		</tr>
		<tr>
		   <th>Ponovi sifru</th>
		   <td class="myclass"><input type="password" style="border:none;background:#fff;" class="form-control"  value="${user.lozinka}" ></td> 
		</tr>
		<tr>
			<td colspan="2" style="text-align:center"><input class="btn btn-warning btn-lg izmeni" value='Izmeni' type='button'  onclick="obrisi()"/></td>
		</tr>	
   </table>
   </div>
</body>
<script>
function obrisi() {
  alert("aaa");
}
</script>
</html>