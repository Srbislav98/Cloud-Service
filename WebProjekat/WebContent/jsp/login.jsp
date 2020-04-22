<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <jsp:useBean id="user" class="beans.Korisnik" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/WebProjekat/css/login.css">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>Projekat</title>
</head>
<%
	response.setHeader("cache-Control","no-cache,no-store,must-revalidate"); 
	response.setHeader("Pragma","no-cache");    
	response.setHeader("Expires","0");
	//System.out.println(session.getAttribute("user"));
	if(user.getPrijavljen().equals("da")){
		response.sendRedirect(request.getContextPath() + "/jsp/pocetna.jsp");
	}
%>
<body>
	<div class="form">
	<h1>WEB 1920</h1>
	<form action="http://localhost:8080/WebProjekat/Login" method="post">
      <input name="username" type="text" placeholder="Korisničko ime" required="required"/>
      <input name="password" type="password" placeholder="Šifra" required="required"/>
      	<p><%if(null!=session.getAttribute("errorMessage")){
	        out.println(session.getAttribute("errorMessage"));}
		%></p>
      <button>Prijavite se</button>
	</form>
	</div>
</body>
</html>