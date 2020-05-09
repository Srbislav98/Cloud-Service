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
				<td class="myclass" height="50" width="70"><c:out value="${v.ime}" /></td>
				<td class="myclass" height="50" width="400" ><c:out value="${v.opis}" /></td>
				<td class="myclass"><img class="image" src="<c:out value="${v.logo}" />" width="60" height="50"></td>
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
				<td><input class="btn btn-warning btn-lg izmeni" style="width:105%;" value='Izmena/Pregled' type='button'  onclick="otvoriIzmenu('${v.ime}','${v.opis}','${v.logo}','${v.korisnici}','${v.resursi}')"/></td>
			</tr>
		</c:if>
		</c:forEach>
		<tr>
			<td colspan="4" style="text-align:center"><input class="btn btn-warning btn-lg izmeni" type='button' value='Dodavanje'  onclick="otvoriDodavanje()"/></td>
		</tr>	
   </table>
   <div id="modaldark">
   <div class="form-popup" id="myForm1">
   <form action="http://localhost:8080/WebProjekat/DodavanjeOrganizacije" name="myForm1" method="get" onsubmit="return provjeriSve(0)">
    <legend>Dodavanje organizacije</legend>
    <br>
    <label>Ime:<span style="color:red" id="greskaIme"></span><input name="ime" type="text" class="fotrol" placeholder="Unesite ime" required></label>
    <label>Opis:<textarea name="opis"   placeholder="Unesite opis"></textarea></label>
    <label>Logo:<br><input name="logo1" type="text" class="fotrol" style="margin-bottom:0;width:80%;"  placeholder="Unesite URL logo"><span>&nbsp &nbsp ili</span>
    <input name="logo2" type="file" value = "onUpload" ></label>
    <br><br><br>
    <button type="submit" class="btn maal leftbutton">Potvrdi</button>
    <button type="button" class="btn zaal rightbutton" onclick="otkaziDodavanje()">Otkazi</button>
   </form>
   </div>
   </div>
   <div id="modaldark2">
   <div class="form-popup" id="myForm2">
   <form action="http://localhost:8080/WebProjekat/IzmjenaOrganizacije" method="get" name="myForm2" onsubmit="return provjeriSve(1)">
    <legend>Izmena i pregled organizacije</legend>
    <br>
  	<label>Ime:<span style="color:red" id="greskaIzmjenaIme"></span><input name="ime" id="a" type="text" class="fotrol" placeholder="Unesite ime" required></label>
    <input name="pime" id="aa" type="text" class="fotrol" placeholder="Unesite ime" required style="display:none;">
    <label><textarea name="opis" id="b"  placeholder="Unesite opis"></textarea></label>
    <label><br><input name="logo1" id="c" type="text" class="fotrol" style="margin-bottom:0;width:80%;"  placeholder="Unesite URL logo"><span>&nbsp &nbsp ili</span>
    <input name="logo2" type="file" value = "onUpload" ></label>
    <br><br>
	<label>Korisnici:<textarea name="opisOrg" id="d" disabled ></textarea></label>
	<label>Resursi:<textarea name="opisOrg" id="e"  disabled ></textarea></label>
    <br><br>
    <button type="submit" class="btn maal leftbutton" onclick="izmeni()">Potvrdi</button>
    <button type="button" class="btn zaal rightbutton" onclick="otkaziIzmenu()">Otkazi</button>
   </form>
   </div>
   </div>
   </div>
</body>
<script>
function provjeriSve(n){
	if(provjeriIme(n)==false){
		return false;
	}else{
	return true;
	}
}
function provjeriIme(n){
	var br=0;
	var brt=0;
	var trenutnoIme="";
	var ime="";
	if(n==0){
		ime = document.forms["myForm1"]["ime"].value;
	}else{
		ime = document.forms["myForm2"]["ime"].value;
		trenutnoIme = document.forms["myForm2"]["pime"].value;
	}
	ime=ime.trim();
	if(ime.length>20){
		document.getElementById("greskaIme").textContent="Predugacko ime(Max 20 karaktera)";
		document.getElementById("greskaIzmjenaIme").textContent="Predugacko ime(Max 20 karaktera)";
		return false;
	}
	if(ime==""){
		document.getElementById("greskaIme").textContent="Molimo vas, popunite polje";
		document.getElementById("greskaIzmjenaIme").textContent="Molimo vas, popunite polje";
		return false;
	}
	ime=ime.toLowerCase();
	trenutnoIme=trenutnoIme.toLowerCase();
	<c:forEach var="v" items="${applicationScope.organizacije}">
		var a="<c:out value="${v.ime}" />";
		a=a.toLowerCase();
		if(a==ime){
			br=br+1;
		}
		if(trenutnoIme==a){
			brt=1;
		}
	
	</c:forEach>
	if(n==0 && br==0){
		return true;
	}else if(n==1 && br==1 && ime==trenutnoIme){
		return true;
	}else if(n==1 && br==0 && ime!=trenutnoIme && brt==1){
		return true;
	}else{
		document.getElementById("greskaIme").textContent=" Vec postoji ovo ime. Promenite ga.";
		document.getElementById("greskaIzmjenaIme").textContent=" Vec postoji ovo ime. Promenite ga.";
		return false;
	}
}
function otvoriDodavanje() {
	document.getElementById("myForm1").style.display = "block";
	document.getElementById("modaldark").style.display = "block";
	document.getElementById("modaldark").style.opacity="1";
}
function otvoriIzmenu(a,b,c,d,e) {
	document.getElementById("a").value = a;
	document.getElementById("aa").value = a;
	document.getElementById("b").value = b;
	document.getElementById("c").value = c;
	document.getElementById("d").value = d.substring(1,d.length-1);
	document.getElementById("e").value = e.substring(1,e.length-1);
	document.getElementById("myForm2").style.display = "block";
	document.getElementById("modaldark2").style.display = "block";
	document.getElementById("modaldark2").style.opacity="1";
}
function otkaziDodavanje() {
	document.getElementById("greskaIme").textContent="";
	document.getElementById("myForm1").style.display = "none";
	document.getElementById("modaldark").style.display = "none";
	document.getElementById("modaldark").style.opacity="0";	
}
function otkaziIzmenu() {
	document.getElementById("greskaIzmjenaIme").textContent="";
	document.getElementById("myForm2").style.display = "none";
	document.getElementById("modaldark2").style.display = "none";
	document.getElementById("modaldark2").style.opacity="0";
}
</script>
</html>