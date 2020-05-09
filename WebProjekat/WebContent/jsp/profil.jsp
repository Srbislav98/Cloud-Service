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
  <form name="myForm1" action="http://localhost:8080/WebProjekat/IzmjenaProfila" method="post" onsubmit="return provjeriLozinku()">
  	<input id="aa" name="pemail" type="text" value="${user.email}" required style="display:none;">
  	<table  class="table">
		<tr>
		   <th>Email</th>
		   <td class="myclass"><input type="text" name="email" id="c" style="border:none;background:#fff;"class="form-control"  value="${user.email}"></td>
		</tr>
		<tr>
		   <th>Ime</th>
		   <td class="myclass"><input type="text" name="ime" style="border:none;background:#EBEBEB;" class="form-control"  value="${user.ime}" required></td>
		</tr>
		<tr>
		   <th>Prezime</th>
		   <td class="myclass"><input type="text"  name="prezime" style="border:none;background:#fff;" class="form-control"  value="${user.prezime}" required></td>
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
		   <td class="myclass"><input type="password" id="a" name="lozinka" minlength="6" maxlength="10" style="border:none;background:#EBEBEB;" class="form-control"  value="${user.lozinka}" required></td>
		</tr>
		<tr>
		   <th>Ponovi sifru</th>
		   <td class="myclass"><input type="password" id="b" minlength="6" maxlength="10" name="plozinka" style="border:none;background:#fff;" class="form-control"  value="${user.lozinka}" required></td> 
		</tr>
		<tr>
			<td colspan="2" style="text-align:center"><button type="submit" class="btn btn-warning btn-lg izmeni">Izmeni</button></td>
		</tr>	
   </table>
   </form>
   </div>
</body>
<script>
function provjeriLozinku() {
	if(provjeriEmail()==false){
		return false;
	}
	var a=document.getElementById("a").value;
	var b=document.getElementById("b").value;
	if(a!=b){
		alert("Lozinke se ne slazu.");
		return false;
	}else{
		return true;
		alert("Uspesna izmena");
	}
}
function provjeriEmail() {
	var a=document.getElementById("c").value;
	if(a.substring(a.length-4)!=".com" || a.includes("@")==false || a.charAt(0)=="@" || a.charAt(a.length-5)=="@"){
		alert("Email ne valja");
		return false;
	}else if(provjeriPonavljanje()==false){
		return false;
	}else{
		return true;
	}
}
function provjeriPonavljanje(){
	var br=0;
	var brt=0;
	var trenutnoIme="";
	var ime="";
	ime = document.forms["myForm1"]["email"].value;
	trenutnoIme = document.forms["myForm1"]["pemail"].value;
	ime=ime.trim();
	ime=ime.toLowerCase();
	<c:forEach var="v" items="${applicationScope.korisnici}">
		var a="<c:out value="${v.email}" />";
		a=a.toLowerCase();
		if(a==ime){
			br=br+1;
		}
		if(trenutnoIme==a){
			brt=1;
		}
	</c:forEach>
	if(br==1 && ime==trenutnoIme){
		return true;
	}else if(br==0 && ime!=trenutnoIme && brt==1){
		return true;
	}else{

		alert("Vec postoji ovaj email. Promenite ga");
		return false;
	}
}
</script>
</html>