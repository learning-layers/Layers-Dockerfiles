package de.dbis.acis.cloud.Tethys.message.client;
import de.dbis.acis.cloud.Tethys.message.server.*;

public class Auth {

	PasswordCredentials passwordCredentials;
	String tenantName;
	
	Auth(SMessageAuth message) {
		tenantName = message.getService();
		passwordCredentials = new PasswordCredentials(message);
	}
}
