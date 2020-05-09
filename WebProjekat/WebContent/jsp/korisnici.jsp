<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <jsp:useBean id="user" class="beans.Korisnik" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/WebProjekat/css/pocetna.css">
<meta charset="ISO-8859-1">
<title>Korisnici</title>
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
 		<input type="submit" value="Organizacija" >
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
 		<input type="submit" value="Disk">
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
  	<table class="table">
		<tr>
		   <th>Email</th>
		   <th>Ime</th>
		   <th>Prezime</th>
		   <c:if test= "${user.uloga == 'Super admin'}">
		   <th>Organizacija</th>
		   </c:if>
		   <th colspan="1">Uredjivanje</th>
		</tr>
		<c:forEach var="v" items="${applicationScope.korisnici}">
		<c:if test= "${user.uloga == 'Super admin' || user.organizacija==v.organizacija }">
			<tr class="filterDiv">
				<td class="myclass"><c:out value="${v.email}" /></td>
				<td class="myclass"><c:out value="${v.ime}" /></td>
				<td class="myclass"><c:out value="${v.prezime}" /></td>
				<c:if test= "${user.uloga == 'Super admin'}">
				<td class="myclass"><c:out value="${v.organizacija}" /></td>
				</c:if>
				<td><input class="btn btn-warning btn-lg izmeni" style="width:105%;" value='Izmena/Pregled' type='button'  onclick="otvoriIzmenu('${v.email}','${v.ime}','${v.prezime}','${v.lozinka}','${v.organizacija}','${v.uloga}')"/></td>
			</tr>
		</c:if>
		</c:forEach>
		<tr>
			<td colspan="9" style="text-align:center"><input class="btn btn-warning btn-lg izmeni" type='button' value='Dodaj novog korisnika'  onclick="otvoriDodavanje()"/></td>
		</tr>	
   </table>
   <div id="modaldark">
   <div class="form-popup" id="myForm1">
   <form action="http://localhost:8080/WebProjekat/DodavanjeKorisnika" name="myForm1" method="get" onsubmit="return provjeriSve(0)">
    <legend>Dodavanje korisnika</legend>
    <br>
    <label>Email:<span style="color:red" id="greskaEmail"></span> <input name="email" id="x"  type="text" required class="fotrol" placeholder="Unesite email"></label>
    <label>Ime:<input type="text" class="fotrol" name="ime"  placeholder="Unesite ime" required></label>
    <label>Prezime:<input  type="text" name="prezime" class="fotrol"  placeholder="Unesite prezime" required ></label>
    <label>Lozinka:<input type="password" name="lozinka" class="fotrol" minlength="6" maxlength="10" placeholder="Unesite lozinku" required ></label>
    <label>Organizacija korisnika:
    	<select id="organizacija" name="organizacija">
    	 <c:forEach var="v" items="${applicationScope.organizacije}">
    	 	<c:if test= "${user.uloga == 'Super admin' || user.organizacija==v.ime }">
    		<option value="${v.ime}"><c:out value="${v.ime}" /></option>
    		</c:if>
    	</c:forEach>
    	</select>
    </label>
    <label>Tip:
    	<select id="tip" name="tip">
    	
    		<option value="admin">Admin</option>
    		<option value="korisnik">Korisnik</option>
    	</select>
    </label>
    <br><br><br>
    <button type="submit" class="btn maal leftbutton">Potvrdi</button>
    <button type="button" class="btn zaal rightbutton" onclick="otkaziDodavanje()">Otkazi</button>
   </form>
   </div>
   <div class="form-popup" id="myForm2">
    <form action="http://localhost:8080/WebProjekat/IzmjenaKorisnika" method="get" name="myForm2" onsubmit="return provjeriSve(1)">
    <legend>Izmena i pregled korisnika</legend>
    <br>
    <label>Email:<input name="email" id="a" type="text" class="fotrol" placeholder="Unesite email" readonly="readonly"></label>
    <label>Ime:<input name="ime" id="b" type="text" class="fotrol" placeholder="Unesite ime" required></label>
    <label>Prezime:<input name="prezime" id="c" type="text" class="fotrol" placeholder="Unesite prezime" required></label>
    <label>Lozinka:<input name="lozinka"  id="d" type="password" minlength="6" maxlength="10" class="fotrol" placeholder="Unesite lozinku"></label>
    <label>Organizacija korisnika: <input name="organizacija" id="e" type="text" class="fotrol" placeholder="Unesite organizaciju" readonly="readonly"></label>
    <label>Tip:<span style="color:red" id="greskaIzmjeneTip"></span><input name="tip" id="f" type="text" class="fotrol" placeholder="Unesite tip"></label>
    <br><br><br>
    <button type="submit" class="btn maal leftbutton">Potvrdi</button>
    </form>
    <form name="myForm3" action="http://localhost:8080/WebProjekat/BrisanjeKorisnika" method="post">
    <button type="button" class="btn zaal rightbutton" onclick="otkaziIzmenu()">Otkazi</button>
    <input name="email" id="aa" type="text" class="fotrol" placeholder="Unesite email" required style="display:none;">
    <button type="submit" class="btn btn-warning btn-lg izmeni" style="width:100%;"  onclick="obrisi()">Obrisi</button>
   </form>
   </div>
   </div>
   </div>
</body>
<script>
function provjeriSve(n){
	if(provjeriEmail(n)==false){
		return false;
	}
	if(n==0){
		if(provjeriPonavljanje()==false){
			return false;
		}
	}else{
		if(provjeriTip()==false){
			return false;
		}else{
			return true;
		}
	}
}
function provjeriPonavljanje(){
	var br=0;
	var brt=0;
	var trenutnoIme="";
	var ime="";
	ime = document.forms["myForm1"]["email"].value;
	ime=ime.trim();
	if(ime.length>20){
		document.getElementById("greskaEmail").textContent="Predugacko ime(Max 20 karaktera)";
		return false;
	}
	if(ime==""){
		document.getElementById("greskaEmail").textContent="Molimo vas, popunite polje";
		return false;
	}
	ime=ime.toLowerCase();
	<c:forEach var="v" items="${applicationScope.korisnici}">
		var a="<c:out value="${v.email}"/>";
		a=a.toLowerCase();
		if(a==ime){
			br=br+1;
		}
	</c:forEach>
	if(br==0){
		return true;
	}else{
		document.getElementById("greskaEmail").textContent=" Vec postoji ovo ime. Promenite ga.";
		return false;
	}
}
function provjeriTip(){
	ime = document.forms["myForm2"]["tip"].value;
	ime=ime.toLowerCase();
	if(ime=="admin"){
		return true;
	}else if(ime=="korisnik"){
		return true
	}else{
		document.getElementById("greskaIzmjeneTip").textContent="Ovaj tip ne postoji. Promenite ga.";
		return false;
	}
}
function provjeriEmail(n) {
	if(n==0){
		var a=document.getElementById("x").value;
	}else{
		var a=document.getElementById("a").value;
	}
	if(a.substring(a.length-4)!=".com" || a.includes("@")==false || a.charAt(0)=="@" || a.charAt(a.length-5)=="@"){
		alert("Email ne valja");
		return false;
	}else{
		return true;
	}
}
function otvoriDodavanje() {
	document.getElementById("myForm1").style.display = "block";
	document.getElementById("modaldark").style.display = "block";
	document.getElementById("modaldark").style.opacity="1";
}
function otvoriIzmenu(a,b,c,d,e,f) {
	document.getElementById("a").value = a;
	document.getElementById("aa").value = a;
	document.getElementById("b").value = b;
	document.getElementById("c").value = c;
	document.getElementById("d").value = d;
	document.getElementById("e").value = e;
	document.getElementById("f").value = f;
	/*if(f=="Admin"){
		document.getElementById("g").value = f;
		document.getElementById("h").value = "Korisnik";
	}else{
		document.getElementById("g").value = f;
		document.getElementById("h").value = "Admin";
	}*/
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