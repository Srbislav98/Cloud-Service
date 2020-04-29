package beans;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.StringTokenizer;

public class VMe {
		private HashMap<String, VM> vme = new HashMap<String, VM>();
	
	public VMe() {
		this("C:\\Users\\Srbislav\\Desktop\\projekatweb\\Web-Projekat\\WebProjekat\\WebContent\\data");
	}
	
	public VMe(String path) {
		BufferedReader in = null;
		try {
			File file = new File(path + "/data/vm.csv");
			System.out.println(file.getCanonicalPath());
			in = new BufferedReader(new FileReader(file));
			readVMe(in);
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

	private void readVMe(BufferedReader in) {
		String line,ime="",organizacija="",kategorija="",diskovii="",aktivnostii="",vreme="";
		int jezgara=0,ram=0,gpu=0;
		ArrayList<String> diskovi=new ArrayList<String>();
		ArrayList<Aktivnost> aktivnosti= new ArrayList<Aktivnost>();
		//Aktivnost aktivnost=new Aktivnost();
		SimpleDateFormat formatter=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		StringTokenizer st,st1,st2;
		try {
			while ((line = in.readLine()) != null) {
				line = line.trim();
				if (line.equals("") || line.indexOf('#') == 0)
					continue;
				st = new StringTokenizer(line, ";");
				System.out.println("*************1***********");
				while (st.hasMoreTokens()) {
					ime = st.nextToken().trim();
					organizacija = st.nextToken().trim();
					kategorija = st.nextToken().trim();
					jezgara=Integer.parseInt(st.nextToken().trim());
					ram=Integer.parseInt(st.nextToken().trim());
					gpu=Integer.parseInt(st.nextToken().trim());
					System.out.println("*************2***********");
					System.out.println(gpu);
					diskovii = st.nextToken().trim();
					System.out.println(diskovii);
					st1 = new StringTokenizer(diskovii, "#");
					while (st1.hasMoreTokens()) {
						String a=st1.nextToken().trim();
						System.out.println("DISK:"+a);
						diskovi.add(a);
					}
					if(st.hasMoreTokens()) {
						aktivnostii = st.nextToken().trim();
						st1 = new StringTokenizer(aktivnostii, "#");
						while (st1.hasMoreTokens()) {
							Aktivnost aktivnost=new Aktivnost();
							vreme = st1.nextToken().trim();
							st2 = new StringTokenizer(vreme, "|");
							if (st2.hasMoreTokens()) {
								aktivnost.setPocetak(formatter.parse(st2.nextToken().trim()));
							}
							if (st2.hasMoreTokens()) {
								aktivnost.setKraj(formatter.parse(st2.nextToken().trim()));
							}
							aktivnosti.add(aktivnost);
						}
					}
				}
				vme.put(ime, new VM(ime,organizacija,kategorija,jezgara,ram,gpu,diskovi,aktivnosti));
				VM vs=vme.get(ime);
				System.out.println("//////////////");
				for (String a : vs.getDiskovi()) {
					System.out.println(a);
				}
				System.out.println("//////////////");
				diskovi=new ArrayList<String>();
				aktivnosti= new ArrayList<Aktivnost>();
				VM va=vme.get(ime);
				System.out.println("++++++++++++++++++++");
				for (Aktivnost a : va.getAktivnosti()) {
					System.out.println(a.getPocetak());
					System.out.println(a.getKraj());
				}
				System.out.println("++++++++++++++++++++");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/** Vraca kolekciju proizvoda. */
	public Collection<VM> values() {
		return vme.values();
	}

	/** Vraca kolekciju proizvoda. */
	public Collection<VM> getValues() {
		return vme.values();
	}

	/** Vraca proizvod na osnovu njegovog id-a. */
	public VM getKorisnik(String id) {
		return vme.get(id);
	}
}