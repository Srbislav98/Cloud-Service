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
import beans.KategorijeVM;
import beans.Korisnik;
import beans.Organizacija;
import beans.Organizacije;
import beans.VM;
import beans.VMe;

/**
 * Servlet implementation class DodavanjeDiska
 */
@WebServlet("/DodavanjeDiska")
public class DodavanjeDiska extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DodavanjeDiska() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("DODAJE DISK");
		HttpSession session=request.getSession();
		Korisnik user=(Korisnik) session.getAttribute("user");
		String ime=request.getParameter("ime");
		String organizacija=request.getParameter("organizacija");
		if(user.getUloga().toLowerCase().equals("korisnik") || (user.getUloga().toLowerCase().equals("admin") && user.getOrganizacija().equals(organizacija))){
			response.setStatus(403);
			return;
		}	
		String tip=request.getParameter("tip");
		String kapacitet=request.getParameter("kapacitet");
		String vm=request.getParameter("vm");
		String linija=ime+";"+organizacija+";"+tip+";"+kapacitet+";"+vm;
		System.out.println(linija);
		Collection<Disk> diskovii = (Collection<Disk>) (getServletContext().getAttribute("diskovi"));
		ArrayList<Disk> diskovi=new ArrayList<Disk>(diskovii);
		Disk k=new Disk(ime,organizacija,tip,Integer.parseInt(kapacitet),vm);
		diskovi.add(k);
		javax.servlet.ServletContext ctx=getServletContext();
		
		Diskovi kvm=new Diskovi();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),diskovi);
		
		((javax.servlet.ServletContext) ctx).setAttribute("diskovi",diskovi);
		
		Collection<VM> vmee = (Collection<VM>) (getServletContext().getAttribute("vme"));
		ArrayList<VM> vme=new ArrayList<VM>(vmee);
		for(VM a : vme) {
			if(a.getIme().equals(vm)) {
				a.getDiskovi().add(ime);
			}
		}
		VMe vmovi=new VMe();
		vmovi.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),vme);
		((javax.servlet.ServletContext) ctx).setAttribute("vme", vme);

		Collection<Organizacija> organizacijee = (Collection<Organizacija>) (getServletContext().getAttribute("organizacije"));
		ArrayList<Organizacija> organizacije=new ArrayList<Organizacija>(organizacijee);
		for(Organizacija a : organizacije) {
			if(a.getIme().equals(organizacija)) {
				a.getResursi().add(ime);
			}
		}
		Organizacije orgs=new Organizacije();
		orgs.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),organizacije);
		((javax.servlet.ServletContext) ctx).setAttribute("organizacije",organizacije);
		
		response.sendRedirect(request.getContextPath() + "/jsp/disk.jsp");
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
