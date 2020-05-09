package beans;

public class Korisnik {

	private static final long serialVersionUID = -6365144622373103590L;
	
	private String email;
	private String lozinka;
	private String ime;
	private String prezime;
	private String organizacija;
	private String uloga;
	private String prijavljen;

	public Korisnik(String email, String lozinka, String ime, String prezime, String organizacija, String uloga) {
		super();
		this.email = email;
		this.lozinka = lozinka;
		this.ime = ime;
		this.prezime = prezime;
		this.organizacija = organizacija;
		this.uloga = uloga;
		this.prijavljen="ne";
	}

	public Korisnik() {
		super();
		this.prijavljen="ne";
	}

	public String getPrijavljen() {
		return prijavljen;
	}

	public void setPrijavljen(String prijavljen) {
		this.prijavljen = prijavljen;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLozinka() {
		return lozinka;
	}

	public void setLozinka(String lozinka) {
		this.lozinka = lozinka;
	}

	public String getIme() {
		return ime;
	}

	public void setIme(String ime) {
		this.ime = ime;
	}

	public String getPrezime() {
		return prezime;
	}

	public void setPrezime(String prezime) {
		this.prezime = prezime;
	}

	public String getOrganizacija() {
		return organizacija;
	}

	public void setOrganizacija(String organizacija) {
		this.organizacija = organizacija;
	}

	public String getUloga() {
		return uloga;
	}

	public void setUloga(String uloga) {
		this.uloga = uloga;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void logoff() {
		this.email = "";
		this.lozinka = "";
		this.ime = "";
		this.prezime = "";
		this.organizacija = "";
		this.uloga = "";
		this.prijavljen="ne";
	}


}
