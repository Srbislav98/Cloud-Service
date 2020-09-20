<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <jsp:useBean id="user" class="beans.Korisnik" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/WebProjekat/css/pocetna.css">
<meta charset="ISO-8859-1">
<title>Kategorija</title>
</head>
<%
	response.setHeader("cache-Control","no-cache,no-store,must-revalidate"); 
	response.setHeader("Pragma","no-cache");    
	response.setHeader("Expires","0");
	System.out.println(session.getAttribute("user"));
	if(user.getPrijavljen().equals("ne"))
		response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
	if(user.getUloga().toLowerCase().equals("korisnik") || user.getUloga().toLowerCase().equals("admin")){
		response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
		//response.setStatus(HttpServletResponse.SC_FORBIDDEN);
	}
%>
<body>


  <div class="header">
    <h1>Cloud Service Provider</h1>
  </div>
  <div class="navigacija">
  	<c:if test= "${user.uloga != 'Korisnik'}">
    <form action="http://localhost:8080/WebProjekat/jsp/organizacija.jsp" class="organizacija" >
 		<input type="submit" value="Organizacija" >
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/korisnici.jsp" class="korisnici" >
 		<input type="submit" value="Korisnici">
 	</form>
 	</c:if>
    <form action="http://localhost:8080/WebProjekat/jsp/profil.jsp" class="profil" >
 		<input type="submit" value="Profil">
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/pocetna.jsp" class="vm" method="post">
 		<input type="submit" value="VM" >
 	</form>
    <form action="http://localhost:8080/WebProjekat/jsp/disk.jsp" class="disk" >
 		<input type="submit" value="Disk" >
 	</form>
 	<c:if test= "${user.uloga == 'Super admin'}">
    <form action="http://localhost:8080/WebProjekat/jsp/kategorija.jsp" class="kategorija" >
 		<input type="submit" value="Kategorija">
 	</form>
 	</c:if>
    <form action="http://localhost:8080/WebProjekat/Logout" class="odjava" >
 		<input type="submit" value="Odjavite se">
 	</form>
  </div>
  <div class="tablediv">
  	<table  class="table">
		<tr>
		   <th>Ime</th>
		   <th>Br jezgara</th>
		   <th>Ram</th>
		   <th>Gpu</th>
		   <th colspan="1">Uredjivanje</th>
		</tr>
		<c:forEach var="v" items="${applicationScope.kategorijeVM}">
			<tr class="filterDiv">
				<td class="myclass"><c:out value="${v.ime}" /></td>
				<td class="myclass"><c:out value="${v.jezgara}" /></td>
				<td class="myclass"><c:out value="${v.ram}" /></td>
				<td class="myclass"><c:out value="${v.gpu}" /></td>
				<td><input class="btn btn-warning btn-lg izmeni" style="width:105%;" value='Izmena/Pregled' type='button'  onclick="otvoriIzmenu('${v.ime}','${v.jezgara}','${v.ram}','${v.gpu}')"/></td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="6" style="text-align:center"><input class="btn btn-warning btn-lg izmeni" type='button' value='Dodaj kategoriju'  onclick="otvoriDodavanje()"/></td>
		</tr>	
   </table>
   <div id="modaldark">
   <div class="form-popup" id="myForm1">
    <form name="myForm1" action="http://localhost:8080/WebProjekat/DodavanjeKategorije" onsubmit="return provjeriIme(0)"  method="post">
    <legend>Dodavanje kategorije</legend>
    <br>
    <label>Ime:<span style="color:red" id="greskaDodavanja"></span><br><input name="ime" type="text" class="fotrol" placeholder="Unesite ime" required><br></label>
    <label>Broj jezgara:<br><input name="jezgara" min="0" max="1000" type="number" class="fotrol" placeholder="Unesite broj jezgara" required><br></label>
    <label>Ram:<br><input name="ram" type="number" min="1" max="1000" class="fotrol" placeholder="Unesite ram" required><br></label>
    <label>Gpu:<br><input name="gpu" type="number" min="0" max="1000" class="fotrol" placeholder="Unesite gpu"><br></label>
    <br><br>
    <button type="submit" class="btn maal leftbutton">Potvrdi</button>
    <button type="button" class="btn zaal rightbutton" onclick="otkaziDodavanje()">Otkazi</button>
   </form>
   </div>
   <div class="form-popup" id="myForm2">
    <form name="myForm2" action="http://localhost:8080/WebProjekat/IzmjenaKategorije" onsubmit="return provjeriIme(1)" method="post">
    <legend>Izmena i pregled kategorije</legend>
    <br>
    <label>Ime:<span style="color:red"  id="greskaIzmjene"></span><br><input name="ime" id="a" type="text" class="fotrol" placeholder="Unesite ime" required><span id="greska"></span><br></label>
    <input id="aaa" name="PravoIme" type="text" required style="display:none;">
    <label>Broj jezgara:<br><input id="b" name="jezgara" min="0" max="1000" name="" type="number" class="fotrol" placeholder="Unesite broj jezgara" required><br></label>
    <label>Ram:<br><input name="ram" id="c" min="0" max="1000" type="number" class="fotrol" placeholder="Unesite ram" required ><br></label>
    <label>Gpu:<br><input name="gpu" id="d" min="0" max="1000"  type="number" class="fotrol" placeholder="Unesite gpu"><br></label>
    <br><br>
    <button type="submit" class="btn maal leftbutton">Potvrdi</button>
    </form>
    <button type="button" class="btn zaal rightbutton" onclick="otkaziIzmenu()">Otkazi</button>
    <form name="myForm3" action="http://localhost:8080/WebProjekat/BrisanjeKategorije" onsubmit="return provjeriBrisanje()" method="post">
    <input id="aa" name="ime" type="text" class="fotrol" placeholder="Unesite ime" required style="display:none;">
    <button id="obrisi" type="submit" class="btn btn-warning" style="width:100%;"  onclick="obrisi()">Obrisi</button>
   </form>
   </div>
   </div>
   </div>
</body>
<script>
function provjeriBrisanje(){
	var trenutnoIme = document.forms["myForm3"]["ime"].value;
	<c:forEach var="v" items="${applicationScope.vme}">
		var a="<c:out value="${v.kategorija}" />";
		if(a==trenutnoIme){
			alert("Kategorija ima dodjeljene VM. Ne moze se obrisati.");
			return false;
		}
	</c:forEach>
	return true;
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
		trenutnoIme = document.forms["myForm3"]["ime"].value;
	}
	ime=ime.trim();
	if(ime.length>20){
		document.getElementById("greskaIzmjene").textContent="Predugacko ime(Max 20 karaktera)";
		document.getElementById("greskaDodavanja").textContent="Predugacko ime(Max 20 karaktera)";
		return false;
	}
	if(ime==""){
		document.getElementById("greskaIzmjene").textContent="Molimo vas, popunite polje";
		document.getElementById("greskaDodavanja").textContent="Molimo vas, popunite polje";
		return false;
	}
	ime=ime.toLowerCase();
	<c:forEach var="v" items="${applicationScope.kategorijeVM}">
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

		document.getElementById("greskaIzmjene").textContent=" Vec postoji ovo ime. Promenite ga.";
		document.getElementById("greskaDodavanja").textContent=" Vec postoji ovo ime. Promenite ga.";
		return false;
	}
}
function otvoriDodavanje() {
	document.getElementById("myForm1").style.display = "block";
	document.getElementById("modaldark").style.display = "block";
	document.getElementById("modaldark").style.opacity="1";
}
function otvoriIzmenu(a,b,c,d) {
	document.getElementById("a").value = a;
	document.getElementById("aa").value = a;
	document.getElementById("aaa").value = a;
	document.getElementById("b").value = b;
	document.getElementById("c").value = c;
	document.getElementById("d").value = d;
	document.getElementById("myForm2").style.display = "block";
	document.getElementById("modaldark").style.display = "block";
	document.getElementById("modaldark").style.opacity="1";
}
function otkaziDodavanje() {
	document.getElementById("greskaIzmjene").textContent="";
	document.getElementById("greskaDodavanja").textContent="";
	document.getElementById("myForm1").style.display = "none";
	document.getElementById("modaldark").style.display = "none";
	document.getElementById("modaldark").style.opacity="0";
}
function otkaziIzmenu() {
	document.getElementById("greskaIzmjene").textContent="";
	document.getElementById("greskaDodavanja").textContent="";
	document.getElementById("greska").textContent="";
	document.getElementById("myForm2").style.display = "none";
	document.getElementById("modaldark").style.display = "none";
	document.getElementById("modaldark").style.opacity="0";
}
</script>
</html>