package beans;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.StringTokenizer;

public class Organizacije {
		private HashMap<String, Organizacija> organizacije = new HashMap<String, Organizacija>();
	
	public Organizacije(int a) {
		this("C:\\Users\\Srbislav\\Desktop\\projekatweb\\Web-Projekat\\WebProjekat\\WebContent\\data");
	}
	public Organizacije() {
		
	}
	
	public Organizacije(String path) {
		BufferedReader in = null;
		try {
			File file = new File(path + "/data/organizacija.csv");
			System.out.println(file.getCanonicalPath());
			in = new BufferedReader(new FileReader(file));
			readKategorije(in);
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if ( in != null ) {
				try {
					in.close();
				}
				catch (Exception e) { }
			}
		}
	}

	private void readKategorije(BufferedReader in) {
		String line,ime="",opis="",logo="",korisnicii="",resursii="";
		ArrayList<String> korisnici=new ArrayList<String>(),resursi=new ArrayList<String>();
		StringTokenizer st,st1;
		try {
			while ((line = in.readLine()) != null) {
				line = line.trim();
				if (line.equals("") || line.indexOf('#') == 0)
					continue;
				st = new StringTokenizer(line, ";");
				while (st.hasMoreTokens()) {
					ime = st.nextToken().trim();
					opis = st.nextToken().trim();
					logo = st.nextToken().trim();
					
					korisnicii = st.nextToken().trim();
					st1 = new StringTokenizer(korisnicii, "#");
					while (st1.hasMoreTokens()) {
						korisnici.add(st1.nextToken().trim());
					}
					resursii = st.nextToken().trim();
					st1 = new StringTokenizer(resursii, "#");
					while (st1.hasMoreTokens()) {
						resursi.add(st1.nextToken().trim());
					}
				}
				organizacije.put(ime, new Organizacija(ime,opis,logo,korisnici,resursi));
				korisnici=new ArrayList<String>();
				resursi=new ArrayList<String>();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/** Vraca kolekciju proizvoda. */
	public Collection<Organizacija> values() {
		return organizacije.values();
	}

	/** Vraca kolekciju proizvoda. */
	public Collection<Organizacija> getValues() {
		return organizacije.values();
	}

	/** Vraca proizvod na osnovu njegovog id-a. */
	public Organizacija getKorisnik(String id) {
		return organizacije.get(id);
	}
	public void fajlUpis(String path, ArrayList<Organizacija> organs) {
		PrintWriter out = null;
		try {
			System.out.println("ovo je "+path);
			File file = new File(path + "/data/organizacija.csv");
			System.out.println(file.getCanonicalPath());
			out = new PrintWriter(new PrintWriter(file));
			String resursi="",korisnici="";
			for (Organizacija k : organs) {
				resursi="";
				korisnici="";
				ArrayList<String> kor=k.getKorisnici();
				if(kor!=null) {
					for(String i :kor) {
						korisnici+=i;
						korisnici+="#";
					}
					if(korisnici.length()!=0) {
						korisnici=korisnici.substring(0, korisnici.length()-1);
					}
				}
				ArrayList<String> res=k.getResursi();
				if(res!=null) {
					for(String i :res) {
						resursi+=i;
						resursi+="#";
					}
					if(resursi.length()!=0) {
						resursi=resursi.substring(0, resursi.length()-1);
					}
				}
				String linija=k.getIme()+";"+k.getOpis()+";"+k.getLogo()+";"+korisnici+";"+resursi;
				out.println(linija);
				System.out.println(linija);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if ( out != null ) {
				try {
					out.close();
				}
				catch (Exception e) { }
			}
		}
	}
}