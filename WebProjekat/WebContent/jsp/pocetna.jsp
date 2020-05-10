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
		   <th colspan="1">Uredjivanje</th>
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
				<td><input class="btn btn-warning btn-lg izmeni" style="width:105%;" value='Izmena/Pregled' type='button'  onclick="otvoriIzmenu('${v.ime}','${v.organizacija}','${v.kategorija}','${v.jezgara}','${v.ram}','${v.gpu}','${v.diskovi}','${v.aktivnosti}')"/></td>
				<c:if test= "${user.uloga == 'Super admin' || (user.organizacija==v.organizacija && user.uloga=='Admin') }">

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
    <form name="myForm1" action="http://localhost:8080/WebProjekat/DodavanjeVM" onsubmit="return provjeriSve(0)"  method="post">
    <legend>Dodavanje virtuelne masine</legend>
    <br>
    <label>Ime:<span style="color:red"  id="greskaIme"></span><input name="ime" type="text" class="fotrol" placeholder="Unesite ime" required></label>
    <label>Organizacija:
    	<select id="organizacija" name="organizacija">
    	 <c:forEach var="v" items="${applicationScope.organizacije}">
    	 	<c:if test= "${user.uloga == 'Super admin' || user.organizacija==v.ime }">
    		<option value="${v.ime}"><c:out value="${v.ime}" /></option>
    		</c:if>
    	</c:forEach>
    	</select>
    </label>
    <label>Kategorija:<span style="color:red"  id="greskaKategorija"></span>
    	<select id="kategorijaa" name="kategorija" required onchange="kateg1()">
    	 <c:forEach var="v" items="${applicationScope.kategorijeVM}">
    		<option value="${v.ime}"><c:out value="${v.ime}" /></option>
    	</c:forEach>
    	</select>
    </label>
    <label>Broj jezgara:<input name="jezgara" id="a1" type="number" class="fotrol" placeholder="Unesite broj jezgara" readonly="readonly" required></label>
    <label>Ram:<input name="ram" id="a2" type="number" class="fotrol" placeholder="Unesite ram" readonly="readonly"></label>
    <label>Gpu:<input name="gpu" id="a3" type="number" class="fotrol" placeholder="Unesite gpu" readonly="readonly"></label>
    <label>Diskovi:
    	<select id="diskovi" name="diskovi" multiple="multiple" >
    	 <c:forEach var="v" items="${applicationScope.diskovi}">
    	 	<c:if test= "${user.uloga == 'Super admin' || user.organizacija==v.organizacija}">
    	 	<c:if test="${empty v.vm}">
    			<option value="${v.ime}"><c:out value="${v.ime}" /></option>
    		</c:if>
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
   <form name="myForm2" action="http://localhost:8080/WebProjekat/IzmjenaVM" onsubmit="return provjeriSve(1)" method="post">
    <legend>Izmena i pregled virtuelne masine</legend>
    <br>
    <label>Ime:<span style="color:red"  id="greskaIzmjenaIme"></span><input id="a" name="ime" type="text" class="fotrol" placeholder="Unesite ime"></label>
    <label>Organizacija:<input name="" id="b" type="text" class="fotrol" placeholder="Unesite organizaciju"></label>
    <label>Kategorija:<span style="color:red"  id="greskaIzmjenaKategorija"></span>
    	<select id="kategorija" name="kategorija" required onchange="kateg1()">
    	 <c:forEach var="v" items="${applicationScope.kategorijeVM}">
    		<option value="${v.ime}"><c:out value="${v.ime}" /></option>
    	</c:forEach>
    	</select>
    </label>
    <label>Broj jezgara:<input name="" id="d" type="number" class="fotrol" placeholder="Unesite broj jezgara" readonly="readonly"></label>
    <label>Ram:<input name="" id="e" type="number" class="fotrol" placeholder="Unesite ram" readonly="readonly"></label>
    <label>Gpu:<input name="" id="f" type="number" class="fotrol" placeholder="Unesite gpu" readonly="readonly"></label>
    <br><br>
    <button type="submit" class="btn maal leftbutton">Potvrdi</button>
    </form>
    <button type="button" class="btn zaal rightbutton" onclick="otkaziIzmenu()">Otkazi</button>
    <form name="myForm3" action="http://localhost:8080/WebProjekat/BrisanjeVM"  method="post">
    <input id="aa" name="ime" type="text" class="fotrol" placeholder="Unesite ime" required style="display:none;">
    <button type="submit" class="btn btn-warning btn-lg izmeni" style="width:100%;"  onclick="obrisi()">Obrisi</button>
   	</form>
   </div>
   </div>
   </div>
</body>
<script>
function provjeriBrisanje(){
	return true;
}
function kateg1(){
	xy=document.getElementById("kategorijaa").value;
	<c:forEach var="v" items="${applicationScope.kategorijeVM}">
	  var ime="<c:out value="${v.ime}" />";
	  if (ime==xy){
			document.getElementById("a1").value = "<c:out value="${v.jezgara}" />";
			document.getElementById("a2").value = "<c:out value="${v.ram}" />";
			document.getElementById("a3").value = "<c:out value="${v.gpu}" />";
		  }
	</c:forEach>
	
}
function provjeriSve(n){
	if( provjeriIme(n)==false){
		return false;
	}
	if(n==0){
		if(document.forms["myForm1"]["jezgara"].value=="" || document.forms["myForm1"]["ram"].value=="" || document.forms["myForm1"]["gpu"].value=="" ){
			document.getElementById("greskaKategorija").textContent="Izaberite Kategoriju";
			return false;
		}else{
			return true;
		}
	}
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
	<c:forEach var="v" items="${applicationScope.vme}">
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
function otvoriIzmenu(a,b,c,d,e,f,g,h) {
	//alert(document.getElementById('kategorija').getElementsByTagName('option')[c]);
	document.getElementById("a").value = a;
	document.getElementById("aa").value = a;
	document.getElementById("b").value = b;
	document.getElementById('kategorija').value=c;
	document.getElementById("d").value = d;
	document.getElementById("e").value = e;
	document.getElementById("f").value = f;
	alert(g);
	alert(h);
	document.getElementById("myForm2").style.display = "block";
	document.getElementById("modaldark").style.display = "block";
	document.getElementById("modaldark").style.opacity="1";
}
function otkaziDodavanje() {
	document.getElementById("greskaIme").textContent="";
	document.getElementById("greskaIzmjenaIme").textContent="";
	document.getElementById("greskaKategorija").textContent="";
	document.getElementById("myForm1").style.display = "none";
	document.getElementById("modaldark").style.display = "none";
	document.getElementById("modaldark").style.opacity="0";
}
function otkaziIzmenu() {
	document.getElementById("greskaIme").textContent="";
	document.getElementById("greskaIzmjenaIme").textContent="";
	document.getElementById("myForm2").style.display = "none";
	document.getElementById("modaldark").style.display = "none";
	document.getElementById("modaldark").style.opacity="0";
}
</script>
</html>