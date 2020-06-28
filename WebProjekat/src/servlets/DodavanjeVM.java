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
import beans.Organizacija;
import beans.Organizacije;
import beans.VM;
import beans.VMe;

/**
 * Servlet implementation class DodavanjeVM
 */
@WebServlet("/DodavanjeVM")
public class DodavanjeVM extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DodavanjeVM() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		Korisnik user=(Korisnik) session.getAttribute("user");
		System.out.println("DODAJE DISK");
		String ime=request.getParameter("ime");
		String organizacija=request.getParameter("organizacija");
		if(user.getUloga().toLowerCase().equals("korisnik") || (user.getUloga().toLowerCase().equals("admin") && user.getOrganizacija().equals(organizacija))){
			response.setStatus(403);
			return;
		}
		String kategorija=request.getParameter("kategorija");
		String jezgara=request.getParameter("jezgara");
		String ram=request.getParameter("ram");
		String gpu=request.getParameter("gpu");
		String[] disks= request.getParameterValues("diskovi");
		ArrayList<String> diskovi=new ArrayList<String>();
		String linija=ime+";"+organizacija+";"+kategorija+";"+jezgara+";"+ram+";"+gpu+";";
		if(disks!=null) {
			for (String s : disks) {
				diskovi.add(s);
			}
		}
		System.out.println(linija);
		javax.servlet.ServletContext ctx=getServletContext();
		
		Collection<Disk> diskovii = (Collection<Disk>) (getServletContext().getAttribute("diskovi"));
		ArrayList<Disk> diskov=new ArrayList<Disk>(diskovii);

		for(Disk a : diskov) {
			for (String s : disks) {
				System.out.println(a.getIme()+"->"+s);
				if(a.getIme().equals(s)) {
					a.setVm(ime);
					a.setOrganizacija(organizacija);
				}
			}
		}
		
		Diskovi kvm=new Diskovi();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),diskov);
		((javax.servlet.ServletContext) ctx).setAttribute("diskovi",diskov);

		Collection<VM> vmee = (Collection<VM>) (getServletContext().getAttribute("vme"));
		ArrayList<VM> vme=new ArrayList<VM>(vmee);
		VM vm=new VM();
		vm.setIme(ime);
		vm.setOrganizacija(organizacija);
		vm.setKategorija(kategorija);
		vm.setGpu(Integer.parseInt(gpu));
		vm.setJezgara(Integer.parseInt(jezgara));
		vm.setRam(Integer.parseInt(ram));
		vm.setDiskovi(diskovi);
		vme.add(vm);
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
		
		response.sendRedirect(request.getContextPath() + "/jsp/pocetna.jsp");
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
