package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.KategorijaVM;
import beans.KategorijeVM;
import beans.Korisnik;
import beans.VM;

/**
 * Servlet implementation class Kategorija
 */
@WebServlet("/DodavanjeKategorije")
public class DodavanjeKategorije extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DodavanjeKategorije() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("DODAJE KATEGORIJU");
		HttpSession session=request.getSession();
		Korisnik user=(Korisnik) session.getAttribute("user");
		if(user.getUloga().toLowerCase().equals("korisnik") || user.getUloga().toLowerCase().equals("admin")){
			response.setStatus(403);
			return;
		}
		String ime=request.getParameter("ime");
		String jezgara=request.getParameter("jezgara");
		String ram=request.getParameter("ram");
		String gpu=request.getParameter("gpu");
		//Map<String, String> greske = new HashMap<String, String>();
		if(gpu==null || gpu=="") {
			gpu="0";
		}
		String linija=ime+";"+jezgara+";"+ram+";"+gpu;
		System.out.println(linija);
		Collection<KategorijaVM> kategorijee = (Collection<KategorijaVM>) (getServletContext().getAttribute("kategorijeVM"));
		ArrayList<KategorijaVM> kategorije=new ArrayList<KategorijaVM>(kategorijee);
		/*boolean greska=false;
		for (KategorijaVM k :kategorije) {
			if (ime.equals(k.getIme())) {
				System.out.println("greska");
				greske.put("Ime", "Vec postoji.");
				greska=true;
			}
		}
		if(greska==false) {*/
		KategorijaVM k=new KategorijaVM(ime,Integer.parseInt(jezgara),Integer.parseInt(ram),Integer.parseInt(gpu));
		kategorije.add(k);
		javax.servlet.ServletContext ctx=getServletContext();
		
		KategorijeVM kvm=new KategorijeVM();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),kategorije);
		
		((javax.servlet.ServletContext) ctx).setAttribute("kategorijeVM", kategorije);
		response.sendRedirect(request.getContextPath() + "/jsp/kategorija.jsp");
		//request.getRequestDispatcher("/jsp/kategorija.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
