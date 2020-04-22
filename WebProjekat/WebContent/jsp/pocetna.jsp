<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
    <p class="citat">You're too pretty to have to look for a parking spot.</p>
  </div>
  <div class="fotter">
  <form method="post" action="Kupac.php">
    <button class="novosti" id="novosti" name="novosti">Organizacija</button>
    <button class="podaci" id="podaci" name="podaci">Korisnici</button>
    <button class="novosti" id="novosti" name="novosti">Profil</button>
    <button class="podaci" id="podaci" name="podaci">VM</button>
    <button class="novosti" id="novosti" name="novosti">Disk</button>
    <button class="podaci" id="podaci" name="podaci">Kategorija</button>
  </form>
    <form action="http://localhost:8080/WebProjekat/Logout" class="odjava" >
 		<input type="submit" value="Logout" style="background-color:red;height:48px;font-weight:999;">
 	</form>
  </div>
</body>
</html>