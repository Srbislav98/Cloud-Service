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
import beans.Korisnici;
import beans.Korisnik;
import beans.Organizacija;
import beans.Organizacije;

/**
 * Servlet implementation class IzmjenaKorisnika
 */
@WebServlet("/IzmjenaKorisnika")
public class IzmjenaKorisnika extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IzmjenaKorisnika() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		Korisnik user=(Korisnik) session.getAttribute("user");
		System.out.println("menja KORISNIKA");
		String email=request.getParameter("email");
		String ime=request.getParameter("ime");
		String prezime=request.getParameter("prezime");
		String lozinka=request.getParameter("lozinka");
		String organizacija=request.getParameter("organizacija");
		if(user.getUloga().toLowerCase().equals("korisnik") || (user.getUloga().toLowerCase().equals("admin") && user.getOrganizacija().equals(organizacija))){
			response.setStatus(403);
			return;
		}
		String tip=request.getParameter("tip");
		String linija=ime+";"+organizacija+";"+tip+";"+email+";"+prezime;
		System.out.println(linija);
		Collection<Korisnik> korisnicii = (Collection<Korisnik>) (getServletContext().getAttribute("korisnici"));
		ArrayList<Korisnik> korisnici=new ArrayList<Korisnik>(korisnicii);
		System.out.println(email+"sasasa");
		for (Korisnik k :korisnici) {
			if (email.equals(k.getEmail())) {
				k.setIme(ime);
				k.setPrezime(prezime);
				k.setLozinka(lozinka);
				k.setUloga(tip);
			}
		}
		javax.servlet.ServletContext ctx=getServletContext();
		
		Korisnici kvm=new Korisnici();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),korisnici);
		
		((javax.servlet.ServletContext) ctx).setAttribute("korisnici",korisnici);
		
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
