package beans;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.Collection;
import java.util.HashMap;
import java.util.StringTokenizer;

public class Korisnici {
		private HashMap<String, Korisnik> korisnici = new HashMap<String, Korisnik>();
	
	public Korisnici() {
		this("C:\\Users\\Srbislav\\Desktop\\projekatweb\\Web-Projekat\\WebProjekat\\WebContent\\data");
	}
	
	public Korisnici(String path) {
		BufferedReader in = null;
		try {
			File file = new File(path + "/data/korisnik.csv");
			System.out.println(file.getCanonicalPath());
			in = new BufferedReader(new FileReader(file));
			readKorisnici(in);
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

	private void readKorisnici(BufferedReader in) {
		String line, email = "", lozinka = "", ime = "",prezime="",organizacija="",uloga="",korisnickoIme="";
		StringTokenizer st;
		try {
			while ((line = in.readLine()) != null) {
				line = line.trim();
				if (line.equals("") || line.indexOf('#') == 0)
					continue;
				st = new StringTokenizer(line, ";");
				while (st.hasMoreTokens()) {
					email = st.nextToken().trim();
					System.out.println(email);
					lozinka = st.nextToken().trim();
					System.out.println(lozinka);
					ime = st.nextToken().trim();
					System.out.println(ime);
					prezime = st.nextToken().trim();
					System.out.println(prezime);
					organizacija = st.nextToken().trim();
					System.out.println(organizacija);
					uloga = st.nextToken().trim();
					System.out.println("1"+uloga);
					korisnickoIme = st.nextToken().trim();
					System.out.println(korisnickoIme);
				}
				korisnici.put(korisnickoIme, new Korisnik(email, lozinka,ime,prezime,organizacija,
						uloga,korisnickoIme));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/** Vraca kolekciju proizvoda. */
	public Collection<Korisnik> values() {
		return korisnici.values();
	}

	/** Vraca kolekciju proizvoda. */
	public Collection<Korisnik> getValues() {
		return korisnici.values();
	}

	/** Vraca proizvod na osnovu njegovog id-a. */
	public Korisnik getKorisnik(String id) {
		return korisnici.get(id);
	}
}
