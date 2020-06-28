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
<body onload="provjeri('${user.uloga}')">


  <div class="header">
    <h1>Cloud Service Provider</h1>
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
		<tr>
        <td colspan="2">
          <input type="text" name="" id="pime" placeholder="Unesite ime" />
        </td>
        <td>
          <input class="unosbroja" type="number" id="podjezgra" placeholder="Od" />
          <input class="unosbroja" type="number" id="pdojezgra" placeholder="Do" />
        </td>
        <td>
          <input class="unosbroja" type="number" id="podram" placeholder="Od" />
          <input class="unosbroja" type="number" id="pdoram" placeholder="Do" />
        </td>
        <td>
          <input class="unosbroja" type="number" id="podgpu" placeholder="Od" />
          <input class="unosbroja" type="number" id="pdogpu" placeholder="Do" />
        </td>
        <td><input class="btn btn-warning btn-lg izmeni" style="width:105%;" value='Pretrazi' type='button'  onclick="pretrazi()"/></td>
      </tr>
		<c:forEach var="v" items="${applicationScope.vme}">
		<c:if test= "${user.uloga == 'Super admin' || user.organizacija==v.organizacija }">
			<ul id="${v.ime}" style="display:none;">
			<c:forEach var="vreme" items="${v.aktivnosti}">
				<li class="myclass"><c:out value="${vreme.pocetak}" /></li>
				<li class="myclass"><c:out value="${vreme.kraj}" /></li>
			</c:forEach>
			</ul>
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
				<td><input class="btn btn-warning btn-lg izmeni" style="width:105%;" value='Izmena/Pregled' type='button'  onclick="otvoriIzmenu('${user.uloga}','${v.ime}','${v.organizacija}','${v.kategorija}','${v.jezgara}','${v.ram}','${v.gpu}','${v.diskovi}','${v.aktivnosti}')"/></td>
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
    <input id="aaa" name="PravoIme" type="text" required style="display:none;">
    <label>Organizacija:<input name="" id="b" type="text" class="fotrol" placeholder="Unesite organizaciju" readonly="readonly"></label>
    <label>Kategorija:<span style="color:red"  id="greskaIzmjenaKategorija"></span>
    	<select id="kategorij" name="kategorija" required onchange="kateg2()">
    	 <c:forEach var="v" items="${applicationScope.kategorijeVM}">
    		<option value="${v.ime}"><c:out value="${v.ime}" /></option>
    	</c:forEach>
    	</select>
    </label>
    <table>
    	<tr>
    		<th>Broj jezgara:</th>
    		<th>Ram:</th>
    		<th>Gpu:</th>
    	</tr>
    	<tr>
    		<td><input name="jezgara" id="b1" type="number" class="fotrol" placeholder="Unesite broj jezgara" readonly="readonly">
    		</td>
    		<td><input name="ram" id="b2" type="number" class="fotrol" placeholder="Unesite ram" readonly="readonly">
    		</td>
    		<td><input name="gpu" id="b3" type="number" class="fotrol" placeholder="Unesite gpu" readonly="readonly">
    		</td>
    	</tr>
    </table>
    <label>Diskovi:
    	<select id="diskoviIzmjena" name="diskovi" multiple="multiple" >
    	</select>
    </label>
    <label>
    	<select id="aktListaIzmjena" name="aktivnosti" multiple="multiple" required style="display:none;" >
    	<option value="audi" selected>Audi</option>
    	</select>
    </label>
    <label>Aktivnosti:<span style="color:blue"  id="tipAktivnosti"></span><span style="color:red"  id="greskaAktivnosti"></span></label>
    <div style="overflow-y:scroll;height:100px;">
    <table id="aktivnostiIzmjena">
    <tr>
    		<th>Pocetak</th>
		   <th>Kraj</th>
	</tr>
    </table>
    </div>
    <button id="paligasi" type="button" class="btn btn-success" style="width:100%;"  onclick="paliGasi('${user.uloga}')">Paljenje/gasenje</button>
    <button id="potvrdi" type="submit" class="btn maal leftbutton">Potvrdi</button>
    </form>
    <button id="otkazisiroki" type="button" class="btn btn-success" onclick="otkaziIzmenu()" style="display:none;width:100%;" >Otkazi</button>
    <button id="otkaziuski" type="button" class="btn zaal rightbutton" onclick="otkaziIzmenu()">Otkazi</button>
    <form name="myForm3" action="http://localhost:8080/WebProjekat/BrisanjeVM"  method="post">
    <input id="aa" name="ime" type="text" class="fotrol" placeholder="Unesite ime" required style="display:none;">
    <button id="obrisi" type="submit" class="btn btn-warning" style="width:100%;"  onclick="obrisi()">Obrisi</button>
   	</form>
   </div>
   </div>
   </div>
</body>
<script>
function pretrazi() {
    var ime = document.getElementById("pime").value;
    var odjezgra = document.getElementById("podjezgra").value;
    var dojezgra = document.getElementById("pdojezgra").value;
    var odram = document.getElementById("podram").value;
    var doram = document.getElementById("pdoram").value;
    var odgpu = document.getElementById("podgpu").value;
    var dogpu = document.getElementById("pdogpu").value;
    var tabela = document.getElementsByClassName("table");
    var tr = tabela[0].children;
    tr = tr[0].children;
    for (var i = 2; i < tr.length; i++) {
      var td = tr[i].children;
      for (var j = 0; j < td.length - 1; j++) {
    	if(j==1)continue;
        var vrijednost = td[j].textContent.toLowerCase();
        if (j != 0) vrijednost = Number(vrijednost);
        if (j == 0 && ime != "" && vrijednost.search(ime) == -1) {
          tr[i].style.display = "none";
          break;
        } else {
          tr[i].style.display = "table-row";
        }
        if (j == 2 && odjezgra != "" && dojezgra != "" && ((vrijednost < odjezgra) ||( vrijednost > dojezgra))) {
          tr[i].style.display = "none";
          break;
        } else {
          tr[i].style.display = "table-row";
        }
        if (j == 3 && odram != "" && doram != "" && ((vrijednost < odram) || (vrijednost > doram))) {
          tr[i].style.display = "none";
          break;
        } else {
          tr[i].style.display = "table-row";
        }
        if (j == 4 && odgpu != "" && dogpu != "" && ((vrijednost < odgpu) || (vrijednost > dogpu))) {
          tr[i].style.display = "none";
          break;
        } else {
          tr[i].style.display = "table-row";
        }
      }
    }
  }
function provjeri(a){
	if(a=="Korisnik"){
		document.getElementById("otkazisiroki").style.display="block";
		document.getElementById("otkaziuski").style.display="none";
		document.getElementById("paligasi").style.display="none";
		document.getElementById("obrisi").style.display="none";
		document.getElementById("potvrdi").style.display="none";
		document.getElementById("a").setAttribute("readonly","readonly");

	}
	
}
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
function kateg2(){
	xy=document.getElementById("kategorij").value;
	<c:forEach var="v" items="${applicationScope.kategorijeVM}">
	  var ime="<c:out value="${v.ime}" />";
	  if (ime==xy){
			document.getElementById("b1").value = "<c:out value="${v.jezgara}" />";
			document.getElementById("b2").value = "<c:out value="${v.ram}" />";
			document.getElementById("b3").value = "<c:out value="${v.gpu}" />";
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
	}else{
		if(provjeriIzmjenu()==false){
			return false;
		}
	}
	return true;
}
function provjeriIzmjenu(){
	var brojac=0,brojac1=0;
	document.getElementById("greskaAktivnosti").textContent="";
	var table = document.getElementById("aktivnostiIzmjena");
	var x = document.getElementById("aktListaIzmjena");
	x.options[0].selected=false;
	for (var i = 0, row; row = table.rows[i]; i++) {
		   for (var j = 0, col; col = row.cells[j]; j++) {
			   	if(brojac!=0 && brojac!=1){
			   		if(new Date(table.rows[i].cells[j].childNodes[0].value)>new Date()){
			   			document.getElementById("greskaAktivnosti").textContent="  Nevalidan unos(kraj>=trenutno).";
		   				return false;
			   		}
			   		brojac1++;
			   		if(brojac1==2){
			   			var poc=new Date(table.rows[i].cells[j-1].childNodes[0].value);
			   			var kra=new Date(table.rows[i].cells[j].childNodes[0].value);
			   			if(poc>=kra){
			   				document.getElementById("greskaAktivnosti").textContent="  Nevalidan unos(pocetak>=kraj).";
			   				return false;
			   			}	
			   			brojac1=0;
			   		}
			   		var tekst=table.rows[i].cells[j].childNodes[0].value;
					var option =document.createElement("option");
					option.text=tekst;
					option.value=tekst;
					x.add(option);
					x.options[brojac-1].selected=true;
			   	}
				brojac++;
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
		if(trenutnoIme.toLowerCase()==a){
			brt=1;
		}
	</c:forEach>
	if(n==0 && br==0){
		return true;
	}else if(n==1 && br==1 && ime==trenutnoIme.toLowerCase()){
		//treba LOWER CASE
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
function otvoriIzmenu(uloga,a,b,c,d,e,f,g,h) {
	//alert(document.getElementById('kategorija').getElementsByTagName('option')[c]);
	document.getElementById("a").value = a;
	document.getElementById("aa").value = a;
	document.getElementById("aaa").value = a;
	document.getElementById("b").value = b;
	document.getElementById('kategorij').value=c;
	document.getElementById("b1").value = d;
	document.getElementById("b2").value = e;
	document.getElementById("b3").value = f;
	var x = document.getElementById("diskoviIzmjena");
	var brojac=0;
	<c:forEach var="v" items="${applicationScope.diskovi}">
	 	<c:if test= "${user.uloga == 'Super admin' || user.organizacija==v.organizacija}">
		 	<c:if test="${empty v.vm }">
				var option =document.createElement("option");
				option.text="${v.ime}";
				option.value="${v.ime}";
				x.add(option);
					brojac++;
			</c:if>
		</c:if>
	</c:forEach>
	var diski=g.substring(1,g.length-1);
	var diskii=diski.split(",");
	var diskiiduz=diskii.length;
	for(i=0;i<diskii.length;i++){
		var option =document.createElement("option");
		option.text=diskii[i];
		option.value=diskii[i];
		x.add(option);
		x.options[brojac].selected=true;
		brojac++;
	}
	var ul = document.getElementById(a);
	var duzinaTabele = document.getElementById("aktivnostiIzmjena").rows.length;
	for(var i =0; i<(duzinaTabele-1); ++i){
		document.getElementById("aktivnostiIzmjena").deleteRow(1);
	}
	var table = document.getElementById("aktivnostiIzmjena");
	var items = ul.getElementsByTagName("li");
	for (var i = 0; i < items.length; ++i) {
	  var tr = document.createElement('tr');
	  table.appendChild(tr);
	  var td = document.createElement('td');
	  tr.appendChild(td);
	  var vreme=document.createElement("input");
	  vreme.type = 'datetime-local';
	  var tekstic=convertujDatum(items[i].textContent);
	  //tekstic=tekstic.substring(0,10);
	  //var txt = document.createTextNode(tekstic);
	  vreme.value=tekstic;
	  //alert(tekstic);
	  td.appendChild(vreme);
	  document.getElementById("tipAktivnosti").textContent="VM je upaljena.";
	  if((i+1)<items.length && items[i+1].textContent.trim()!=""){
		  i++;
		  var td = document.createElement('td');
		  tr.appendChild(td);
		  //alert(items[i].textContent);
		  var tekstic=convertujDatum(items[i].textContent);
		  //alert(tekstic);
		  //tekstic=tekstic.substring(0,10);
		  //var txt = document.createTextNode(tekstic);
		  var vreme=document.createElement("input");
	      vreme.type = 'datetime-local';
	      vreme.value=tekstic;
		  td.appendChild(vreme);
		  document.getElementById("tipAktivnosti").textContent="VM je ugasena.";
	  }else if(items[i+1].textContent.trim()==""){
		  i++;
	  }
	}
	document.getElementById("myForm2").style.display = "block";
	document.getElementById("modaldark").style.display = "block";
	document.getElementById("modaldark").style.opacity="1";
	if(uloga=="Korisnik"){
		var ketegorij=document.getElementById("kategorij").children;
		for(var i=0;i<kategorij.length;i++){
			kategorij[i].setAttribute("disabled","true");
		}
	}
	if(uloga=="Korisnik"||uloga=="Admin"){
		var aktivnost=document.getElementById("aktivnostiIzmjena").children;
		for(var i=0;i<aktivnost.length;i++){
			if(aktivnost[i].tagName=="TR"){
				var tr=aktivnost[i].children;
				for(var j=0;j<tr.length;j++){
					var inputi=tr[j].children;
					for(var k=0;k<inputi.length;k++){
						inputi[k].setAttribute("readonly","readonly");
					}
				}
			}
		}
	}
}
function paliGasi(uloga){
	var table = document.getElementById("aktivnostiIzmjena");
	var provjera=false;
	for (var i = 0, row; row = table.rows[i]; i++) {
		var duzina=document.getElementById('aktivnostiIzmjena').rows[i].cells.length;
		if(duzina==1){
			var td = document.createElement('td');
			table.rows[i].appendChild(td);
			var vreme=document.createElement("input");
		    vreme.type = 'datetime-local';
		    var d = new Date();
		    var n = d.toISOString();
		    vreme.value=n.substring(0,n.length-8);
		    td.appendChild(vreme);
		    provjera=true;
		    document.getElementById("tipAktivnosti").textContent="VM je ugasena.";
		    if(uloga=="Admin"){
		    	vreme.setAttribute("readonly","readonly");
		    }
		}
	}
	if(provjera==false){
		  var tr = document.createElement('tr');
		  table.appendChild(tr);
		  var td = document.createElement('td');
		  tr.appendChild(td);
		  var vreme=document.createElement("input");
	      vreme.type = 'datetime-local';
	      var d = new Date();
	      var n = d.toISOString();
	      vreme.value=n.substring(0,n.length-8);
		  td.appendChild(vreme);
		  document.getElementById("tipAktivnosti").textContent="VM je upaljena.";
		  if(uloga=="Admin"){
		    	vreme.setAttribute("readonly","readonly");		    	
		  }
	}
	
	

	td.appendChild(vreme);
}
function convertujDatum(str){
	  var mnths = {
		      Jan: "01",
		      Feb: "02",
		      Mar: "03",
		      Apr: "04",
		      May: "05",
		      Jun: "06",
		      Jul: "07",
		      Aug: "08",
		      Sep: "09",
		      Oct: "10",
		      Nov: "11",
		      Dec: "12"
		    },
		    date = str.split(" ");
	  var datum= [date[5], mnths[date[1]], date[2]].join("-");
	  datum=[datum,date[3].substring(0,5)].join("T");
	  datum=[datum,"00.00"].join(":");
	  return datum;
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
	var x = document.getElementById("diskoviIzmjena");
    while (x.options.length > 0) {                
        x.remove(0);
    } 
	document.getElementById("greskaIme").textContent="";
	document.getElementById("greskaIzmjenaIme").textContent="";
	document.getElementById("greskaAktivnosti").textContent="";
	document.getElementById("myForm2").style.display = "none";
	document.getElementById("modaldark").style.display = "none";
	document.getElementById("modaldark").style.opacity="0";
}
</script>
</html>