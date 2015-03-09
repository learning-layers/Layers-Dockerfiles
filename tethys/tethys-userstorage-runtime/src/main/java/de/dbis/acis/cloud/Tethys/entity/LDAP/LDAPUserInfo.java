package de.dbis.acis.cloud.Tethys.entity.LDAP;

public class LDAPUserInfo {

	private String sub; 
	private String name;
	private String preferred_username;
	private float updated_time;
	private String email;
	private Boolean email_verified;
	
	public LDAPUserInfo() {
		super();
	}

	public String getSub() {
		return sub;
	}

	public void setSub(String sub) {
		this.sub = sub;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPreferred_username() {
		return preferred_username;
	}

	public void setPreferred_username(String preferred_username) {
		this.preferred_username = preferred_username;
	}

	public float getUpdated_time() {
		return updated_time;
	}

	public void setUpdated_time(float updated_time) {
		this.updated_time = updated_time;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Boolean getEmail_verified() {
		return email_verified;
	}

	public void setEmail_verified(Boolean email_verified) {
		this.email_verified = email_verified;
	}
}
