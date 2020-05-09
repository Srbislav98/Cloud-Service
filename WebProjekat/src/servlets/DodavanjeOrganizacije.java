package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import beans.Organizacija;
import beans.Organizacije;

/**
 * Servlet implementation class DodavanjeOrganizacije
 */
@WebServlet("/DodavanjeOrganizacije")
public class DodavanjeOrganizacije extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DodavanjeOrganizacije() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ime=request.getParameter("ime");
		String opis=request.getParameter("opis");
		String logo1=request.getParameter("logo1");
		String logo2=request.getParameter("logo2");
		String linija=ime+";"+opis+";"+logo1+";"+logo2;
		System.out.println(linija);
		String logo="logo.png";
		if(!logo2.isEmpty()) {
			logo=logo2;
		}else if(!logo1.isEmpty()) {
			logo=logo1;
		}
		javax.servlet.ServletContext ctx=getServletContext();
	
		Collection<Organizacija> organizacijee = (Collection<Organizacija>) (getServletContext().getAttribute("organizacije"));
		ArrayList<Organizacija> organizacije=new ArrayList<Organizacija>(organizacijee);

		Organizacija o=new Organizacija(ime,opis,logo);
		organizacije.add(o);
		Organizacije orgs=new Organizacije();
		orgs.fajlUpis((((javax.servlet.ServletContext) ctx).getRealPath("")),organizacije);
		((javax.servlet.ServletContext) ctx).setAttribute("organizacije",organizacije);
		
		response.sendRedirect(request.getContextPath() + "/jsp/organizacija.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
