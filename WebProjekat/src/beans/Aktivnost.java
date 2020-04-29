package beans;

import java.util.Date;

public class Aktivnost {
	private Date pocetak;
	private Date kraj;
	
	public Aktivnost(Date pocetak) {
		super();
		this.pocetak = pocetak;
	}
	public Aktivnost() {
		// TODO Auto-generated constructor stub
	}
	public Date getPocetak() {
		return pocetak;
	}
	public void setPocetak(Date pocetak) {
		this.pocetak = pocetak;
	}
	public Date getKraj() {
		return kraj;
	}
	public void setKraj(Date kraj) {
		this.kraj = kraj;
	}
	
}
