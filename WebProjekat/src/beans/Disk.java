package beans;

public class Disk {

	private String ime;
	private String organizacija;
	private String tip;
	private int kapacitet;
	private String vm;
	
	public Disk(String ime, String organizacija, String tip, int kapacitet, String vm) {
		super();
		this.ime = ime;
		this.organizacija = organizacija;
		this.tip = tip;
		this.kapacitet = kapacitet;
		this.vm = vm;
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
	public String getTip() {
		return tip;
	}
	public void setTip(String tip) {
		this.tip = tip;
	}
	public int getKapacitet() {
		return kapacitet;
	}
	public void setKapacitet(int kapacitet) {
		this.kapacitet = kapacitet;
	}
	public String getVm() {
		return vm;
	}
	public void setVm(String vm) {
		this.vm = vm;
	}
	
}
