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

import beans.KategorijaVM;
import beans.KategorijeVM;
import beans.Korisnik;
import beans.Organizacija;
import beans.Organizacije;
import beans.Korisnici;
import beans.VM;
import beans.VMe;

/**
 * Servlet implementation class IzmjenaProfila
 */
@WebServlet("/IzmjenaProfila")
public class IzmjenaProfila extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IzmjenaProfila() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("IZMJENA KATEGORIJE");
		String pemail=request.getParameter("pemail");
		System.out.println(pemail);
		HttpSession session=request.getSession();
		Korisnik user=(Korisnik) session.getAttribute("user");
		if(!user.getEmail().toLowerCase().equals(pemail)){
			response.setStatus(403);
			return;
		}
		String email=request.getParameter("email");
		String ime=request.getParameter("ime");
		String prezime=request.getParameter("prezime");
		String lozinka=request.getParameter("lozinka");

		String linija=ime+";"+prezime+";"+email+";"+lozinka;
		System.out.println(linija);
		Collection<Korisnik> korisnicii = (Collection<Korisnik>) (getServletContext().getAttribute("korisnici"));
		ArrayList<Korisnik> korisnici=new ArrayList<Korisnik>(korisnicii);
		for (Korisnik k :korisnici) {
			System.out.println(k.getEmail()+"->"+pemail);
			if (pemail.equals(k.getEmail())) {
				k.setEmail(email);
				k.setIme(ime);
				k.setPrezime(prezime);
				k.setLozinka(lozinka);		
				session.setAttribute("user",k);
			}
		}
		javax.servlet.ServletContext ctx=getServletContext();
		
		Korisnici kvm=new Korisnici();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),korisnici);
		
		Collection<Organizacija> organizacijee = (Collection<Organizacija>) (getServletContext().getAttribute("organizacije"));
		ArrayList<Organizacija> organizacije=new ArrayList<Organizacija>(organizacijee);
		for(Organizacija a : organizacije) {
			int index=0,i=0;
			for(String z:a.getKorisnici()) {
				if(z.toLowerCase().equals(pemail.toLowerCase())) {
					index=i;
					a.getKorisnici().set(index, email);
				}
				i++;
			}
		}
		Organizacije orgs=new Organizacije();
		orgs.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),organizacije);
		((javax.servlet.ServletContext) ctx).setAttribute("organizacije",organizacije);
		
		((javax.servlet.ServletContext) ctx).setAttribute("korisnici", korisnici);
		response.sendRedirect(request.getContextPath() + "/jsp/profil.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
