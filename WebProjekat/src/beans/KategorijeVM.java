package beans;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.Collection;
import java.util.HashMap;
import java.util.StringTokenizer;

public class KategorijeVM {
		private HashMap<String, KategorijaVM> kategorije = new HashMap<String, KategorijaVM>();
	
	public KategorijeVM() {
		this("C:\\Users\\Srbislav\\Desktop\\projekatweb\\Web-Projekat\\WebProjekat\\WebContent\\data");
	}
	
	public KategorijeVM(String path) {
		BufferedReader in = null;
		try {
			File file = new File(path + "/data/kategorijaVM.csv");
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
		String line,ime="";
		int jezgara=0,ram=0,gpu=0;
		StringTokenizer st;
		try {
			while ((line = in.readLine()) != null) {
				line = line.trim();
				if (line.equals("") || line.indexOf('#') == 0)
					continue;
				st = new StringTokenizer(line, ";");
				while (st.hasMoreTokens()) {
					ime = st.nextToken().trim();
					jezgara = Integer.parseInt(st.nextToken().trim());
					ram= Integer.parseInt(st.nextToken().trim());
					gpu = Integer.parseInt(st.nextToken().trim());

				}
				kategorije.put(ime, new KategorijaVM(ime,jezgara,ram,gpu));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/** Vraca kolekciju proizvoda. */
	public Collection<KategorijaVM> values() {
		return kategorije.values();
	}

	/** Vraca kolekciju proizvoda. */
	public Collection<KategorijaVM> getValues() {
		return kategorije.values();
	}

	/** Vraca proizvod na osnovu njegovog id-a. */
	public KategorijaVM getKorisnik(String id) {
		return kategorije.get(id);
	}
}