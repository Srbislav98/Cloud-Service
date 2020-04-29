package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.Diskovi;
import beans.KategorijeVM;
import beans.Korisnici;
import beans.Korisnik;
import beans.Organizacije;
import beans.VM;
import beans.VMe;

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
		Diskovi diskovi;
		KategorijeVM kategorijeVM;
		Organizacije organizacije;
		Collection<VM> vme = new ArrayList<VM>();
		try {
			super.init(cfg);
		} catch (ServletException e) {
			e.printStackTrace();
		}
		javax.servlet.ServletContext ctx=getServletContext();
		korisnici = new Korisnici((((javax.servlet.ServletContext) ctx).getRealPath("")));
		diskovi = new Diskovi((((javax.servlet.ServletContext) ctx).getRealPath("")));
		kategorijeVM = new KategorijeVM((((javax.servlet.ServletContext) ctx).getRealPath("")));
		organizacije = new Organizacije((((javax.servlet.ServletContext) ctx).getRealPath("")));
		vme = new VMe((((javax.servlet.ServletContext) ctx).getRealPath(""))).values();
		((javax.servlet.ServletContext) ctx).setAttribute("korisnici", korisnici);
		((javax.servlet.ServletContext) ctx).setAttribute("diskovi", diskovi);
		((javax.servlet.ServletContext) ctx).setAttribute("kategorijeVM", kategorijeVM);
		((javax.servlet.ServletContext) ctx).setAttribute("organizacije", organizacije);
		((javax.servlet.ServletContext) ctx).setAttribute("vme", vme);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		String uname=request.getParameter("username");
		String passwd=request.getParameter("password");
		String prijavljen=request.getParameter("prijavljen");
		HttpSession session=request.getSession();
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAA");
		Collection<VM> vmne = (Collection<VM>) (getServletContext().getAttribute("vme"));
		ArrayList<VM> vme=new ArrayList<VM>(vmne);
		for (VM vm :vme) {
		for (String a : vm.getDiskovi()) {
			System.out.println(a);
			System.out.println("------------------");
		}
		}
		//System.out.println(vm.getGpu());
		if(uname!=null && passwd!=null) {
			Korisnici korisnici = (Korisnici) getServletContext().getAttribute("korisnici");
				Korisnik user=korisnici.getKorisnik(uname);
				if(user!=null &&(user.getLozinka()).equals(passwd)) {
					user.setPrijavljen("da");
					session.setAttribute("user",user);
					response.sendRedirect(request.getContextPath() + "/jsp/pocetna.jsp");
				}else {
					session.setAttribute("errorMessage", "KorisniÄ�ko ime ili Å¡ifra nije ispravna");
					response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
				}
				
		}
	}

}
