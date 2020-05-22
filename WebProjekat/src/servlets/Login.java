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
import javax.servlet.jsp.PageContext;

import beans.Disk;
import beans.Diskovi;
import beans.KategorijaVM;
import beans.KategorijeVM;
import beans.Korisnici;
import beans.Korisnik;
import beans.Organizacija;
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
		Collection<Korisnik> korisnici= new ArrayList<Korisnik>();
		Collection<Disk> diskovi= new ArrayList<Disk>();
		Collection<KategorijaVM> kategorijeVM= new ArrayList<KategorijaVM>();
		Collection<Organizacija> organizacije= new ArrayList<Organizacija>();
		Collection<VM> vme = new ArrayList<VM>();
		try {
			super.init(cfg);
		} catch (ServletException e) {
			e.printStackTrace();
		}
		javax.servlet.ServletContext ctx=getServletContext();
		korisnici = new Korisnici((((javax.servlet.ServletContext) ctx).getRealPath(""))).values();
		diskovi = new Diskovi((((javax.servlet.ServletContext) ctx).getRealPath(""))).values();
		kategorijeVM = new KategorijeVM((((javax.servlet.ServletContext) ctx).getRealPath(""))).values();
		organizacije = new Organizacije((((javax.servlet.ServletContext) ctx).getRealPath(""))).values();
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
			Collection<Korisnik> korisnicii = (Collection<Korisnik>) getServletContext().getAttribute("korisnici");
			ArrayList<Korisnik> korisnici=new ArrayList<Korisnik>(korisnicii);
			System.out.println(korisnici.size());
			Korisnik user=null;
			System.out.println(uname);
			for (Korisnik korisnik :korisnici) {
				System.out.println(korisnik.getEmail());
				if(korisnik.getEmail().equals(uname)) {
					System.out.println(korisnik.getEmail());
					user=new Korisnik(korisnik.getEmail(),korisnik.getLozinka(),korisnik.getIme(),
							korisnik.getPrezime(),korisnik.getOrganizacija(),korisnik.getUloga());
					}
			}
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
