package servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Aktivnost;
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
		//String organizacija=request.getParameter("organizacija");
		String kategorija=request.getParameter("kategorija");
		String jezgara=request.getParameter("jezgara");
		String ram=request.getParameter("ram");
		String gpu=request.getParameter("gpu");
		String[] disks= request.getParameterValues("diskovi");
		String[] akts= request.getParameterValues("aktivnosti");
		ArrayList<String> diskoviVM=new ArrayList<String>();
		ArrayList<Aktivnost> aktivnosti=new ArrayList<Aktivnost>();
		//String linija=ime+";"+organizacija+";"+kategorija+";"+jezgara+";"+ram+";"+gpu+";";	
		for (String s : disks) {
			diskoviVM.add(s);
			System.out.println("D:"+s);
		}
		Aktivnost a=new Aktivnost();
		a.setPocetak(null);
		for (String ss : akts) {
			String s=ss.substring(0,10)+" "+ss.substring(11,16);
			SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date date= new Date();
			try {
				date = formatter.parse(s);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(a.getPocetak()==null) {
				a.setPocetak(date);
			}else {
				a.setKraj(date);
				aktivnosti.add(a);
				a=new Aktivnost();
				a.setPocetak(null);
				
			}
			System.out.println("A:"+s);
		}
		if(a.getPocetak()!=null) {
			aktivnosti.add(a);
		}
		Collection<VM> vmee = (Collection<VM>) (getServletContext().getAttribute("vme"));
		ArrayList<VM> vme=new ArrayList<VM>(vmee);
		for(VM vm :vme) {
			if(pime.equals(vm.getIme())) {
				vm.setIme(ime);
				//vm.setOrganizacija(organizacija);
				vm.setKategorija(kategorija);
				vm.setGpu(Integer.parseInt(gpu));
				vm.setJezgara(Integer.parseInt(jezgara));
				vm.setRam(Integer.parseInt(ram));
				vm.setDiskovi(diskoviVM);
				vm.setAktivnosti(aktivnosti);
			}
		}
		System.out.println(aktivnosti.size()+" OVO JE VELICINA");
		Collection<Disk> diskovii = (Collection<Disk>) (getServletContext().getAttribute("diskovi"));
		ArrayList<Disk> diskovi=new ArrayList<Disk>(diskovii);
		for(String dVM:diskoviVM) {
			for (Disk k :diskovi) {
				if (dVM.equals(k.getIme())) {
					k.setVm(ime);
				}
			}
		}
		javax.servlet.ServletContext ctx=getServletContext();
		
		Diskovi kvm=new Diskovi();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),diskovi);
		((javax.servlet.ServletContext) ctx).setAttribute("diskovi",diskovi);
		
		VMe vmovi=new VMe();
		vmovi.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),vme);
		((javax.servlet.ServletContext) ctx).setAttribute("vme", vme);

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
