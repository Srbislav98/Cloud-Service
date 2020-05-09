package beans;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.StringTokenizer;

public class Diskovi {
	private HashMap<String, Disk> diskovi = new HashMap<String, Disk>();
	
	public Diskovi(int a) {
		this("C:\\Users\\Srbislav\\Desktop\\projekatweb\\Web-Projekat\\WebProjekat\\WebContent\\data");
	}
	public Diskovi() {
		
	}

	public Diskovi(String path) {
		BufferedReader in = null;
		try {
			File file = new File(path + "/data/disk.csv");
			System.out.println(file.getCanonicalPath());
			in = new BufferedReader(new FileReader(file));
			readDiskovi(in);
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

	private void readDiskovi(BufferedReader in) {
		String line, ime = "", imeOrg = "", tip = "",imeVM="";
		int kapacitet=0;
		StringTokenizer st;
		try {
			while ((line = in.readLine()) != null) {
				line = line.trim();
				if (line.equals("") || line.indexOf('#') == 0)
					continue;
				st = new StringTokenizer(line, ";");
				while (st.hasMoreTokens()) {
					ime = st.nextToken().trim();
					imeOrg = st.nextToken().trim();
					tip = st.nextToken().trim();
					kapacitet=Integer.parseInt(st.nextToken().trim());
					imeVM = st.nextToken().trim();
				}
				diskovi.put(ime, new Disk(ime,imeOrg,tip,kapacitet,imeVM));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/** Vraca kolekciju proizvoda. */
	public Collection<Disk> values() {
		return diskovi.values();
	}

	/** Vraca kolekciju proizvoda. */
	public Collection<Disk> getValues() {
		return diskovi.values();
	}

	/** Vraca proizvod na osnovu njegovog id-a. */
	public Disk getKorisnik(String id) {
		return diskovi.get(id);
	}
	
	public void fajlUpis(String path, ArrayList<Disk> disks) {
		PrintWriter out = null;
		try {
			System.out.println("ovo je "+path);
			File file = new File(path + "/data/disk.csv");
			System.out.println(file.getCanonicalPath());
			out = new PrintWriter(new PrintWriter(file));
			String resursi="",aktivnosti="";
			for (Disk k : disks) {
				String linija=k.getIme()+";"+k.getOrganizacija()+";"+k.getTip()+";"+k.getKapacitet()+";"+k.getVm();
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
