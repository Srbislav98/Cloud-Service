package beans;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.StringTokenizer;

public class Organizacije {
		private HashMap<String, Organizacija> organizacije = new HashMap<String, Organizacija>();
	
	public Organizacije() {
		this("C:\\Users\\Srbislav\\Desktop\\projekatweb\\Web-Projekat\\WebProjekat\\WebContent\\data");
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
}