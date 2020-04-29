package beans;

import java.util.ArrayList;

public class VM {

	private String ime;
	private String organizacija;
	private String kategorija;
	private int jezgara;
	private int ram;
	private int gpu;
	private ArrayList<String> diskovi;
	private ArrayList<Aktivnost> aktivnosti;

	public VM(String ime, String organizacija, String kategorija, int jezgara, int ram, int gpu,
			ArrayList<String> diskovi, ArrayList<Aktivnost> aktivnosti) {
		super();
		this.ime = ime;
		this.organizacija = organizacija;
		this.kategorija = kategorija;
		this.jezgara = jezgara;
		this.ram = ram;
		this.gpu = gpu;
		this.diskovi = diskovi;
		this.aktivnosti = aktivnosti;
	}
	public String getIme() {
		return ime;
	}
	public void setIme(String ime) {
		this.ime = ime;
	}
	public String getOrganizacija() {
		return organizacija;
	}
	public void setOrganizacija(String organizacija) {
		this.organizacija = organizacija;
	}
	public String getKategorija() {
		return kategorija;
	}
	public void setKategorija(String kategorija) {
		this.kategorija = kategorija;
	}
	public int getJezgara() {
		return jezgara;
	}
	public void setJezgara(int jezgara) {
		this.jezgara = jezgara;
	}
	public int getRam() {
		return ram;
	}
	public void setRam(int ram) {
		this.ram = ram;
	}
	public int getGpu() {
		return gpu;
	}
	public void setGpu(int gpu) {
		this.gpu = gpu;
	}
	public ArrayList<String> getDiskovi() {
		return diskovi;
	}
	public void setDiskovi(ArrayList<String> diskovi) {
		this.diskovi = diskovi;
	}
	public ArrayList<Aktivnost> getAktivnosti() {
		return aktivnosti;
	}
	public void setAktivnosti(ArrayList<Aktivnost> aktivnosti) {
		this.aktivnosti = aktivnosti;
	}
	
}
