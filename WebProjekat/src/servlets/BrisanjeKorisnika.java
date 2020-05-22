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
import beans.Korisnici;
import beans.Korisnik;
import beans.Organizacija;
import beans.Organizacije;
import beans.VM;
import beans.VMe;

/**
 * Servlet implementation class BrisanjeKorisnika
 */
@WebServlet("/BrisanjeKorisnika")
public class BrisanjeKorisnika extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BrisanjeKorisnika() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("BRISANE DISKA");
		HttpSession session=request.getSession();
		Korisnik user=(Korisnik) session.getAttribute("user");
		if(user.getUloga().toLowerCase().equals("korisnik")){
			response.setStatus(403);
			return;
		}
		String email=request.getParameter("email");
		int index=0,i=0;
		Collection<Korisnik> korisnicii = (Collection<Korisnik>) (getServletContext().getAttribute("korisnici"));
		ArrayList<Korisnik> korisnici=new ArrayList<Korisnik>(korisnicii);
		for (Korisnik k :korisnici) {
			if (email.equals(k.getEmail())) {
				index=i;
				break;
			}
			i++;
		}
		korisnici.remove(index);
		javax.servlet.ServletContext ctx=getServletContext();
			
		Collection<Organizacija> organizacijee = (Collection<Organizacija>) (getServletContext().getAttribute("organizacije"));
		ArrayList<Organizacija> organizacije=new ArrayList<Organizacija>(organizacijee);
		for(Organizacija a : organizacije) {
			index=-1;
			i=0;
			for(String z:a.getKorisnici()) {
				if(z.equals(email)) {
					index=i;
					break;
				}
				i++;
			}
			if(!a.getKorisnici().isEmpty() && index!=-1) {
				a.getKorisnici().remove(index);
			}
		}
		Organizacije orgs=new Organizacije();
		orgs.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),organizacije);
		((javax.servlet.ServletContext) ctx).setAttribute("organizacije",organizacije);
		
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
