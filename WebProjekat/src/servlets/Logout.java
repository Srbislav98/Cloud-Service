package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.Korisnik;
@WebServlet("/Logout")
public class Logout extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		Korisnik user=(Korisnik) session.getAttribute("user");
		user.logoff();
		session.removeAttribute("user");
		session.invalidate();
		response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
		return;
	}


}
