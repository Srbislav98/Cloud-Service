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
 * Servlet implementation class Disk
 */
@WebServlet("/BrisanjeDiska")
public class BrisanjeDiska extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BrisanjeDiska() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		Korisnik user=(Korisnik) session.getAttribute("user");
		if(user.getUloga().toLowerCase().equals("korisnik")){
			response.setStatus(403);
			return;
		}
		System.out.println("BRISANE DISKA");
		String ime=request.getParameter("ime");
		Collection<Disk> diskovii = (Collection<Disk>) (getServletContext().getAttribute("diskovi"));
		int index=0,i=0;
		ArrayList<Disk> diskovi=new ArrayList<Disk>(diskovii);
		for (Disk k :diskovi) {
			if (ime.equals(k.getIme())) {
				index=i;
				break;
			}
			i++;
		}
		diskovi.remove(index);
		javax.servlet.ServletContext ctx=getServletContext();
		
		Collection<VM> vmee = (Collection<VM>) (getServletContext().getAttribute("vme"));
		ArrayList<VM> vme=new ArrayList<VM>(vmee);
		for(VM a : vme) {
			index=-1;
			i=0;
			for(String z:a.getDiskovi()) {
				if(z.equals(ime)) {
					index=i;
					break;
				}
				i++;
			}
			if(!a.getDiskovi().isEmpty() && index!=-1) {
			a.getDiskovi().remove(index);
			}
		}
		VMe vmovi=new VMe();
		vmovi.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),vme);
		((javax.servlet.ServletContext) ctx).setAttribute("vme", vme);
		
		Collection<Organizacija> organizacijee = (Collection<Organizacija>) (getServletContext().getAttribute("organizacije"));
		ArrayList<Organizacija> organizacije=new ArrayList<Organizacija>(organizacijee);
		for(Organizacija a : organizacije) {
			index=-1;
			i=0;
			for(String z:a.getResursi()) {
				if(z.equals(ime)) {
					index=i;
					break;
				}
				i++;
			}
			if(!a.getResursi().isEmpty() && index!=-1) {
				a.getResursi().remove(index);
			}
		}
		Organizacije orgs=new Organizacije();
		orgs.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),organizacije);
		((javax.servlet.ServletContext) ctx).setAttribute("organizacije",organizacije);
		
		Diskovi kvm=new Diskovi();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),diskovi);
		
		((javax.servlet.ServletContext) ctx).setAttribute("diskovi",diskovi);
		response.sendRedirect(request.getContextPath() + "/jsp/disk.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}


}
