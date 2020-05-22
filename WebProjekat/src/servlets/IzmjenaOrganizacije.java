package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.Disk;
import beans.Diskovi;
import beans.KategorijaVM;
import beans.Korisnici;
import beans.Korisnik;
import beans.Organizacija;
import beans.Organizacije;
import beans.VM;
import beans.VMe;

/**
 * Servlet implementation class IzmjenaOrganizacije
 */
@WebServlet("/IzmjenaOrganizacije")
public class IzmjenaOrganizacije extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IzmjenaOrganizacije() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		Korisnik user=(Korisnik) session.getAttribute("user");
		System.out.println("sdsd");
		
		String pime=request.getParameter("pime");
		if(user.getUloga().toLowerCase().equals("korisnik") || (user.getUloga().toLowerCase().equals("admin") && user.getOrganizacija()!=pime)){
			response.setStatus(403);
			return;
		}
		String ime=request.getParameter("ime");
		String opis=request.getParameter("opis");
		String logo1=request.getParameter("logo1");
		String logo2=request.getParameter("logo2");
		String linija=ime+";"+opis+";"+logo1+";"+logo2;
		System.out.println(linija);
		String logo="logo.png";
		if(!logo2.isEmpty()) {
			logo=logo2;
		}else if(!logo1.isEmpty()) {
			logo=logo1;
		}
		javax.servlet.ServletContext ctx=getServletContext();
	
		Collection<Organizacija> organizacijee = (Collection<Organizacija>) (getServletContext().getAttribute("organizacije"));
		ArrayList<Organizacija> organizacije=new ArrayList<Organizacija>(organizacijee);
		for (Organizacija k :organizacije) {
			if (pime.equals(k.getIme())) {
				k.setIme(ime);
				k.setOpis(opis);
				k.setLogo(logo);
			}
		}
		Organizacije orgs=new Organizacije();
		orgs.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),organizacije);
		((javax.servlet.ServletContext) ctx).setAttribute("organizacije",organizacije);
		
		//disk
		Collection<Disk> diskovii = (Collection<Disk>) (getServletContext().getAttribute("diskovi"));
		ArrayList<Disk> diskovi=new ArrayList<Disk>(diskovii);
		for (Disk k :diskovi) {
			if (pime.equals(k.getOrganizacija())) {
				k.setOrganizacija(ime);

			}
		}		
		Diskovi dvm=new Diskovi();
		dvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),diskovi);
		((javax.servlet.ServletContext) ctx).setAttribute("diskovi",diskovi);
		//korisnik
		Collection<Korisnik> korisnicii = (Collection<Korisnik>) (getServletContext().getAttribute("korisnici"));
		ArrayList<Korisnik> korisnici=new ArrayList<Korisnik>(korisnicii);
		for (Korisnik k :korisnici) {
			if (pime.equals(k.getOrganizacija())) {
				k.setOrganizacija(ime);
			}
		}		
		Korisnici kvm=new Korisnici();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),korisnici);
		((javax.servlet.ServletContext) ctx).setAttribute("korisnici",korisnici);
		//vm
		Collection<VM> vmee = (Collection<VM>) (getServletContext().getAttribute("vme"));
		ArrayList<VM> vme=new ArrayList<VM>(vmee);
		for (VM k :vme) {
			if (pime.equals(k.getOrganizacija())) {
				k.setOrganizacija(ime);
			}
		}		
		VMe vmovi=new VMe();
		vmovi.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),vme);
		((javax.servlet.ServletContext) ctx).setAttribute("vme", vme);
		response.sendRedirect(request.getContextPath() + "/jsp/organizacija.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
