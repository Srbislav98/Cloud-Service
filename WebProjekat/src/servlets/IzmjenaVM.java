package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Disk;
import beans.Diskovi;
import beans.Organizacija;
import beans.Organizacije;
import beans.VM;
import beans.VMe;

/**
 * Servlet implementation class IzmjenaVM
 */
@WebServlet("/IzmjenaVM")
public class IzmjenaVM extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IzmjenaVM() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("IZMJENA DISKA");
		String pime=request.getParameter("PravoIme");
		String ime=request.getParameter("ime");
		String organizacija=request.getParameter("organizacija");
		String tip=request.getParameter("tip");
		String kapacitet=request.getParameter("kapacitet");
		String vm=request.getParameter("vm");
		String linija=ime+";"+organizacija+";"+tip+";"+kapacitet+";"+vm;
		System.out.println(linija);
		Collection<Disk> diskovii = (Collection<Disk>) (getServletContext().getAttribute("diskovi"));
		ArrayList<Disk> diskovi=new ArrayList<Disk>(diskovii);
		for (Disk k :diskovi) {
			if (pime.equals(k.getIme())) {
				k.setIme(ime);
				k.setKapacitet(Integer.parseInt(kapacitet));
				k.setOrganizacija(organizacija);
				k.setTip(tip);
				k.setVm(vm);
			}
		}
		javax.servlet.ServletContext ctx=getServletContext();		
		Diskovi kvm=new Diskovi();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),diskovi);
		((javax.servlet.ServletContext) ctx).setAttribute("diskovi",diskovi);
		
		Collection<VM> vmee = (Collection<VM>) (getServletContext().getAttribute("vme"));
		ArrayList<VM> vme=new ArrayList<VM>(vmee);
		//int ispit=0;
		for(VM a : vme) {
			int index=-1,i=0,ispit=0;
			for(String z:a.getDiskovi()) {
				if(z.equalsIgnoreCase(pime)) {
					index=i;
					if(vm.equalsIgnoreCase(a.getIme())){
						ispit=1;
						//a.getDiskovi().set(index, ime);
					}//else {
						//a.getDiskovi().remove(index);
					//}
				}
				i++;
			}
			if(ispit==0 && a.getIme().equalsIgnoreCase(vm)) {
				a.getDiskovi().add(ime);
			
			}else if(ispit==1 && index!=-1) {
				a.getDiskovi().set(index,ime);
			}
			else if(index!=-1) {
				a.getDiskovi().remove(index);
			}
		}
		VMe vmovi=new VMe();
		vmovi.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),vme);
		((javax.servlet.ServletContext) ctx).setAttribute("vme", vme);
		
		Collection<Organizacija> organizacijee = (Collection<Organizacija>) (getServletContext().getAttribute("organizacije"));
		ArrayList<Organizacija> organizacije=new ArrayList<Organizacija>(organizacijee);
		for(Organizacija a : organizacije) {
			int index=0,i=0;
			for(String z:a.getResursi()) {
				if(z.toLowerCase().equals(pime.toLowerCase())) {
					index=i;
					a.getResursi().set(index, ime);
				}
				i++;
			}
		}
		Organizacije orgs=new Organizacije();
		orgs.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),organizacije);
		((javax.servlet.ServletContext) ctx).setAttribute("organizacije",organizacije);
		
		response.sendRedirect(request.getContextPath() + "/jsp/pocetna.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
