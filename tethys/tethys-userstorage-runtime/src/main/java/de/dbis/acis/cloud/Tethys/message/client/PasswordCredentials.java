package de.dbis.acis.cloud.Tethys.message.client;

import de.dbis.acis.cloud.Tethys.message.server.SMessageAuth;

public class PasswordCredentials {

	String username;
	String password;
	
	public PasswordCredentials(SMessageAuth message) {
		this.username=message.getUsername();
		this.password=message.getPassword();
	}
}
