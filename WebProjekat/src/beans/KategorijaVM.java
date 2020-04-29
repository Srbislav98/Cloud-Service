package beans;

public class KategorijaVM {
	
	private String ime;
	private int jezgara;
	private int ram;
	private int gpu;
	
	public KategorijaVM(String ime, int jezgara, int ram, int gpu) {
		super();
		this.ime = ime;
		this.jezgara = jezgara;
		this.ram = ram;
		this.gpu = gpu;
	}
	public String getIme() {
		return ime;
	}
	public void setIme(String ime) {
		this.ime = ime;
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
}
