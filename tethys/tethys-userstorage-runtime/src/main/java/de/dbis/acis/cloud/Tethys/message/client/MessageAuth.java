package de.dbis.acis.cloud.Tethys.message.client;

import de.dbis.acis.cloud.Tethys.message.server.*;

public class MessageAuth {

	Auth auth;
	
	public MessageAuth(SMessageAuth message) {
		auth = new Auth(message);
	}
}
