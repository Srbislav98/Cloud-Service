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

/**
 * Servlet implementation class BrisanjeKategorije
 */
@WebServlet("/BrisanjeKategorije")
public class BrisanjeKategorije extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BrisanjeKategorije() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("BRISANJE KATEGORIJE");
		String ime=request.getParameter("ime");
		Collection<KategorijaVM> kategorijee = (Collection<KategorijaVM>) (getServletContext().getAttribute("kategorijeVM"));
		int index=0,i=0;
		ArrayList<KategorijaVM> kategorije=new ArrayList<KategorijaVM>(kategorijee);
		for (KategorijaVM k :kategorije) {
			if (ime.equals(k.getIme())) {
				index=i;
				break;
			}
			i++;
		}
		kategorije.remove(index);
		javax.servlet.ServletContext ctx=getServletContext();
		
		KategorijeVM kvm=new KategorijeVM();
		kvm.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),kategorije);
		
		((javax.servlet.ServletContext) ctx).setAttribute("kategorijeVM", kategorije);
		response.sendRedirect(request.getContextPath() + "/jsp/kategorija.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
