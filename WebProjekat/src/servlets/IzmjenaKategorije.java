package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.KategorijaVM;
import beans.KategorijeVM;
import beans.VM;
import beans.VMe;

/**
 * Servlet implementation class IzmjenaKategorije
 */
@WebServlet("/IzmjenaKategorije")
public class IzmjenaKategorije extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IzmjenaKategorije() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("IZMJENA KATEGORIJE");
		String pime=request.getParameter("PravoIme");
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
		Collection<VM> vmee = (Collection<VM>) (getServletContext().getAttribute("vme"));
		ArrayList<VM> vme=new ArrayList<VM>(vmee);
		for (KategorijaVM k :kategorije) {
			if (pime.equals(k.getIme())) {
				k.setIme(ime);
				k.setGpu(Integer.parseInt(gpu));
				k.setJezgara(Integer.parseInt(jezgara));
				k.setRam(Integer.parseInt(ram));
			}
		}
		for(VM a : vme) {
			if(pime.equals(a.getKategorija())) {
				a.setKategorija(ime);
				a.setGpu(Integer.parseInt(gpu));
				a.setJezgara(Integer.parseInt(jezgara));
				a.setRam(Integer.parseInt(ram));
			}		
		}
		javax.servlet.ServletContext ctx=getServletContext();
		
		KategorijeVM kvm=new KategorijeVM();
		VMe vmovi=new VMe();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),kategorije);
		vmovi.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),vme);
		
		((javax.servlet.ServletContext) ctx).setAttribute("kategorijeVM", kategorije);
		((javax.servlet.ServletContext) ctx).setAttribute("vme", vme);
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