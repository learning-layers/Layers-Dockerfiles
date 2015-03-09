package de.dbis.acis.cloud.Tethys.client;

import javax.ws.rs.core.Response.Status;

import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.client.ClientResponse;
import org.glassfish.jersey.client.JerseyClient;
import org.glassfish.jersey.client.JerseyClientBuilder;
import org.glassfish.jersey.client.JerseyWebTarget;

import de.dbis.acis.cloud.Tethys.entity.LDAP.LDAPUserInfo;
import de.dbis.acis.cloud.Tethys.util.GsonMessageBodyHandler;

/**
 * Contains all methods to communicate with Openstack.
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
public class OpenstackClient {
	
	private static ClientConfig cfg = null;
	private static String oidcUserinfo = "https://api.learning-layers.eu/o/oauth2/userinfo";
	
	
	/**
	 * Returns a special ClientConfig to communicate with Openstack.
	 * 
	 * @return ClientConfig
	 */
	private static ClientConfig returnClientConfig() {
		if(cfg == null) {
			cfg = new ClientConfig();
			cfg.getClasses().add(GsonMessageBodyHandler.class);
		}
		return cfg;
	}

	public static LDAPUserInfo verifyAccessToken(String accessToken) {
		
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(oidcUserinfo);
	
		System.out.println("curl -X GET -H 'Authorization: "+accessToken+"' "+oidcUserinfo);
		ClientResponse response = tokens.request().header("Authorization", accessToken).get(ClientResponse.class);

		LDAPUserInfo output = new LDAPUserInfo();
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(LDAPUserInfo.class);
		}
	
		return output;	
	}
}
