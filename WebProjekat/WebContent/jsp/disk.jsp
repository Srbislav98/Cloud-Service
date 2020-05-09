<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <jsp:useBean id="user" class="beans.Korisnik" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/WebProjekat/css/pocetna.css">
<meta charset="ISO-8859-1">
<title>Diskovi</title>
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
 		<input type="submit" value="VM">
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
		   <th>Kapacitet</th>
		   <th>VM</th>
		   <th colspan="1">Uredjivanje</th>
		</tr>
		<c:forEach var="v" items="${applicationScope.diskovi}">
		<c:if test= "${user.uloga == 'Super admin' || user.organizacija==v.organizacija }">
			<tr class="filterDiv">
				<td class="myclass"><c:out value="${v.ime}" /></td>
				<td class="myclass"><c:out value="${v.kapacitet}" /></td>
				<td class="myclass"><c:out value="${v.vm}" /></td>
				<td><input class="btn btn-warning btn-lg izmeni" style="width:105%;" value='Izmena/Pregled' type='button'  onclick="otvoriIzmenu('${v.ime}','${v.tip}','${v.kapacitet}','${v.vm}','${v.organizacija}')"/></td>
			</tr>
		</c:if>
		</c:forEach>
		<c:if test= "${user.uloga == 'Super admin' || user.uloga=='Admin'}">
		<tr>
			<td colspan="5" style="text-align:center"><input class="btn btn-warning btn-lg izmeni" type='button' value='Dodaj disk'  onclick="otvoriDodavanje()"/></td>
		</tr>	
		</c:if>
   </table>
   <div id="modaldark">
   <div class="form-popup" id="myForm1">
    <form name="myForm1" action="http://localhost:8080/WebProjekat/DodavanjeDiska" method="post" onsubmit="return provjeriSve(0)">
    <legend>Dodavanje diska</legend>
    <br>
    <label>Ime:<span style="color:red" id="greskaIme"></span><input name="ime" type="text" class="fotrol" placeholder="Unesite ime"></label>
    <label>Tip:
    	<select id="tip" name="tip">
    	
    		<option value="SSD">SSD</option>
    		<option value="HDD">HDD</option>
    	</select>
    </label>
    <label>Kapacitet:<input name="kapacitet" type="number" class="fotrol" min="0" max="10000" placeholder="Unesite kapacitet" required></label>
    <label>Virtuelna masina:
    	<select id="organizacija" name="vm">
    	 	<c:forEach var="d" items="${applicationScope.vme}">
    	 	<c:if test= "${user.organizacija==d.organizacija || user.uloga == 'Super admin' }">
    		<option value="${d.ime}"><c:out value="${d.ime}" /></option>
    		</c:if>
    		</c:forEach>	
    	</select>
    </label>
    <label>Organizacija kojoj pripada:
    	<select id="organizacija" name="organizacija">
    	 <c:forEach var="v" items="${applicationScope.organizacije}">
    	 	<c:if test= "${user.uloga == 'Super admin' || user.organizacija==v.ime }">
    		<option value="${v.ime}"><c:out value="${v.ime}" /></option>
    		</c:if>
    	</c:forEach>
    	</select>
    </label>
    <br><br><br>
    <button type="submit" class="btn maal leftbutton">Potvrdi</button>
    <button type="button" class="btn zaal rightbutton" onclick="otkaziDodavanje()">Otkazi</button>
   </form>
   </div>
   <div class="form-popup" id="myForm2">
    <form name="myForm2" action="http://localhost:8080/WebProjekat/IzmjenaDiska" method="post" onsubmit="return provjeriSve(1)">
    <legend>Izmena i pregled diska</legend>
    <br>
    <label>Ime:<span style="color:red" id="greskaIzmjene"></span><input name="ime" type="text" class="fotrol" id="a" placeholder="Unesite ime"></label>
    <input id="aaa" name="PravoIme" type="text" required style="display:none;">
    <label>Tip:<span style="color:red" id="greskaTip"></span><input name="tip"  id="b" type="text" class="fotrol" placeholder="Unesite tip"></label>
	<label>Kapacitet:<input name="kapacitet"  id="c" type="number" name="kapacitet" min="0" max="100000" class="fotrol" placeholder="Unesite kapacitet" required></label>
	<label>Virtuelna masina:<span style="color:red" id="greskaVm"></span><input name="vm"  id="d" type="text" class="fotrol" placeholder="Unesite vm"></label>
	<label>Organizacija kojoj pripada:<input name="organizacija"  id="e" type="text" class="fotrol" readonly="readonly" ></label>
    <br><br><br>
    <button type="submit" class="btn maal leftbutton">Potvrdi</button>
    </form>
    <button type="button" class="btn zaal rightbutton" onclick="otkaziIzmenu()">Otkazi</button>
    <form name="myForm3" action="http://localhost:8080/WebProjekat/BrisanjeDiska" method="post">
    	<input id="aa" name="ime" type="text" class="fotrol" placeholder="Unesite ime" required style="display:none;">
    	<input name="vm"  id="dd" type="text" class="fotrol" placeholder="Unesite vm" required style="display:none;">
    	<c:if test= "${user.uloga == 'Super admin' || (user.organizacija==v.organizacija && user.uloga=='Admin') }">
    	<button type="submit" class="btn btn-warning btn-lg izmeni" style="width:100%;"  onclick="obrisi()">Obrisi</button>
   		</c:if>
    </form>
   </div>
   </div>
   </div>
</body>
<script>
function provjeriSve(n){
	if(provjeriIme(n)==false){
		return false;
	}
	if(n==0){
		return true;
	}else{
		if(provjeriTip()==false){
			return false
		}else if(provjeriVM()==false){
			return false
		}else{
			return true
		}
	}
}
function provjeriTip(){
	ime = document.forms["myForm2"]["tip"].value;
	ime=ime.toLowerCase();
	if(ime=="ssd"){
		return true;
	}else if(ime=="hdd"){
		return true
	}else{
		document.getElementById("greskaTip").textContent="Ovaj tip ne postoji. Promenite ga.";
		return false;
	}
}
function provjeriVM(){
	var br=0;
	var brt=0;
	var trenutnoIme="";
	var ime="";
	ime = document.forms["myForm2"]["vm"].value;
	trenutnoIme = document.forms["myForm3"]["vm"].value;
	ime=ime.trim();
	if(ime.length>20){
		document.getElementById("greskaVm").textContent="Predugacko ime(Max 20 karaktera)";
		return false;
	}
	if(ime==""){
		document.getElementById("greskaVm").textContent="Molimo vas, popunite polje";
		return false;
	}
	trenutnoIme=trenutnoIme.toLowerCase();
	ime=ime.toLowerCase();
	<c:forEach var="v" items="${applicationScope.vme}">
		var a="<c:out value="${v.ime}" />";
		a=a.toLowerCase();
		if(a==ime){
			br=br+1;
		}
	</c:forEach>
     if(ime==trenutnoIme){
		return true;
	}else if(br==1 && ime!=trenutnoIme){
		return true;
	}else{
		document.getElementById("greskaVm").textContent=" Ova vm ne postoji. Promenite naziv.";
		return false;
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
		trenutnoIme = document.forms["myForm3"]["ime"].value;
	}
	ime=ime.trim();
	if(ime.length>20){
		document.getElementById("greskaIme").textContent="Predugacko ime(Max 20 karaktera)";
		document.getElementById("greskaIzmjene").textContent="Predugacko ime(Max 20 karaktera)";
		return false;
	}
	if(ime==""){
		document.getElementById("greskaIme").textContent="Molimo vas, popunite polje";
		document.getElementById("greskaIzmjene").textContent="Molimo vas, popunite polje";
		return false;
	}
	ime=ime.toLowerCase();
	trenutnoIme=trenutnoIme.toLowerCase();
	<c:forEach var="v" items="${applicationScope.diskovi}">
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
		document.getElementById("greskaIzmjene").textContent=" Vec postoji ovo ime. Promenite ga.";
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
	document.getElementById("b").value = b;
	document.getElementById("c").value = c;
	document.getElementById("d").value = d;
	document.getElementById("e").value = e;
	//document.getElementById("e").disabled=true;
	document.getElementById("aa").value = a;
	document.getElementById("dd").value = d;
	document.getElementById("aaa").value = a;
	document.getElementById("myForm2").style.display = "block";
	document.getElementById("modaldark").style.display = "block";
	document.getElementById("modaldark").style.opacity="1";
}
function otkaziDodavanje() {
	document.getElementById("greskaIme").textContent="";
	document.getElementById("greskaIzmjene").textContent="";
	document.getElementById("myForm1").style.display = "none";
	document.getElementById("modaldark").style.display = "none";
	document.getElementById("modaldark").style.opacity="0";
}
function otkaziIzmenu() {
	document.getElementById("greskaIme").textContent="";
	document.getElementById("greskaIzmjene").textContent="";
	document.getElementById("greskaTip").textContent="";
	document.getElementById("greskaVm").textContent="";
	document.getElementById("myForm2").style.display = "none";
	document.getElementById("modaldark").style.display = "none";
	document.getElementById("modaldark").style.opacity="0";
}
</script>
</html>