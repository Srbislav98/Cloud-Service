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
import beans.Korisnik;
import beans.Korisnici;
import beans.Organizacija;
import beans.Organizacije;
import beans.VM;
import beans.VMe;

/**
 * Servlet implementation class DodavanjeKorisnika
 */
@WebServlet("/DodavanjeKorisnika")
public class DodavanjeKorisnika extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DodavanjeKorisnika() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("DODAJE KORISNIKA");
		HttpSession session=request.getSession();
		Korisnik user=(Korisnik) session.getAttribute("user");
		String email=request.getParameter("email");
		String ime=request.getParameter("ime");
		String prezime=request.getParameter("prezime");
		String lozinka=request.getParameter("lozinka");
		String organizacija=request.getParameter("organizacija");
		if(user.getUloga().toLowerCase().equals("korisnik") || (user.getUloga().toLowerCase().equals("admin") && user.getOrganizacija()!=organizacija)){
			response.setStatus(403);
			return;
		}
		String tip=request.getParameter("tip");
		String linija=ime+";"+organizacija+";"+tip+";"+email+";"+prezime;
		System.out.println(linija);
		Collection<Korisnik> korisnicii = (Collection<Korisnik>) (getServletContext().getAttribute("korisnici"));
		ArrayList<Korisnik> korisnici=new ArrayList<Korisnik>(korisnicii);
		Korisnik k=new Korisnik(email,lozinka,ime,prezime,organizacija,tip);
		korisnici.add(k);
		javax.servlet.ServletContext ctx=getServletContext();
		
		Korisnici kvm=new Korisnici();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),korisnici);
		
		((javax.servlet.ServletContext) ctx).setAttribute("korisnici",korisnici);
		
		Collection<Organizacija> organizacijee = (Collection<Organizacija>) (getServletContext().getAttribute("organizacije"));
		ArrayList<Organizacija> organizacije=new ArrayList<Organizacija>(organizacijee);
		for(Organizacija a : organizacije) {
			if(a.getIme().equals(organizacija)) {
				a.getKorisnici().add(email);
			}
		}
		Organizacije orgs=new Organizacije();
		orgs.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),organizacije);
		((javax.servlet.ServletContext) ctx).setAttribute("organizacije",organizacije);
		
		response.sendRedirect(request.getContextPath() + "/jsp/korisnici.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
