package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.Korisnici;
import beans.Korisnik;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@SuppressWarnings("deprecation")
	@Override
	public void init(javax.servlet.ServletConfig cfg) {
		Korisnici korisnici;
		try {
			super.init(cfg);
		} catch (ServletException e) {
			e.printStackTrace();
		}
		javax.servlet.ServletContext ctx=getServletContext();
		korisnici = new Korisnici((((javax.servlet.ServletContext) ctx).getRealPath("")));
		((javax.servlet.ServletContext) ctx).setAttribute("korisnici", korisnici);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		String uname=request.getParameter("username");
		String passwd=request.getParameter("password");
		String prijavljen=request.getParameter("prijavljen");
		HttpSession session=request.getSession();
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAA");
		if(uname!=null && passwd!=null) {
			Korisnici korisnici = (Korisnici) getServletContext().getAttribute("korisnici");
				Korisnik user=korisnici.getKorisnik(uname);
				if(user!=null &&(user.getLozinka()).equals(passwd)) {
					user.setPrijavljen("da");
					session.setAttribute("user",user);
					response.sendRedirect(request.getContextPath() + "/jsp/pocetna.jsp");
				}else {
					session.setAttribute("errorMessage", "Korisničko ime ili šifra nije ispravna");
					response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
				}
				
		}
	}

}
