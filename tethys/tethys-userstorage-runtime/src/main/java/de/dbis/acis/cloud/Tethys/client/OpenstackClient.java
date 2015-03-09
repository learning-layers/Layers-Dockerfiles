package de.dbis.acis.cloud.Tethys.client;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;


//import javax.servlet.ServletOutputStream;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.core.StreamingOutput;

import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.client.ClientResponse;
import org.glassfish.jersey.client.JerseyClient;
import org.glassfish.jersey.client.JerseyClientBuilder;
import org.glassfish.jersey.client.JerseyWebTarget;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import de.dbis.acis.cloud.Tethys.entity.LDAP.LDAPUserInfo;
import de.dbis.acis.cloud.Tethys.message.client.MessageAuth;
import de.dbis.acis.cloud.Tethys.message.server.SMessageAuth;
import de.dbis.acis.cloud.Tethys.util.GsonMessageBodyHandler;

/**
 * Contains all methods to communicate with Openstack.
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
public class OpenstackClient {
	
	// TODO hardcodet!?
	private static ClientConfig cfg = null;
	private static String protocol = "http://";
	private static String externalOpenstackIP ="137.226.58.2";
	private static String internalOpenstackIP ="10.255.255.3";
	private static String openstackIPForPublishing = externalOpenstackIP;
	private static String portKeystoneAdmin = ":35357";
	private static String portKeystoneMember = ":5000";
	private static String portNovaMember = ":8774";
	private static String portSwiftMember = ":8888";
	@SuppressWarnings("unused")
	private static String portGlanceMember = ":9292";
	
	//private static String oidcUserinfo = "http://137.226.58.15/o/oauth2/userinfo";
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
//			cfg.getFeatures().put(JSONConfiguration.FEATURE_POJO_MAPPING, true);
		}
		return cfg;
	}
	
	
	/**
	 * Authenticates against Openstack.
	 * <p>
	 * input: {"service":""}, {"username":""}, {"password":""}
	 * <p>
	 * output: like openstack gives it back. 
	 * 
	 * @param tenantName
	 * @param username
	 * @param password
	 * @return JsonObject
	 */
	public static JsonObject authOpenstack(SMessageAuth smessage, boolean admin) {
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+ (admin?portKeystoneAdmin:portKeystoneMember) +"/v2.0/tokens");
		MessageAuth message = new MessageAuth(smessage);
		
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).post(Entity.entity(message,MediaType.APPLICATION_JSON),ClientResponse.class);
		JsonObject output = null;
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(JsonObject.class);
		}
		
		return output;		  
	}
	
	// TODO refactor
	/**
	 * Manipulates the Auth-Response of Openstack.
	 * <p>
	 * input: {"service":""}, {"username":""}, {"password":""}
	 * <p>
	 * output {"X-Auth-Token":"","expires":"","service-id":"","swift-url":""}
	 * 
	 * @param tenantName
	 * @param username
	 * @param password
	 * @return JsonObject
	 */
	public static JsonObject manipulateAuthAndReturnToken(SMessageAuth smessage) {
		
		JsonObject output = null;
		JsonObject response = authOpenstack(smessage,false);
		
		if(response!=null) {

			output = new JsonObject();
		
			output.add("X-Auth-Token", response.getAsJsonObject("access").getAsJsonObject("token").get("id"));
			output.add("expires", response.getAsJsonObject("access").getAsJsonObject("token").get("expires"));
			//output.add("tenant-id", response.getAsJsonObject("access").getAsJsonObject("token").getAsJsonObject("tenant").get("id"));
			output.addProperty("swift-url", protocol+openstackIPForPublishing+portSwiftMember+"/v1/AUTH_"+
					response.getAsJsonObject("access").getAsJsonObject("token").getAsJsonObject("tenant").get("id").getAsString());
		}
		
		return output;		  
	}
	
	/**
	 * Manipulates the Auth-Response of Openstack.
	 * <p>
	 * input: {"service":""}, {"username":""}, {"password":""}
	 * <p>
	 * output {"X-Auth-Token":"","expires":"","service-id":"","swift-url":""}
	 * 
	 * @param tenantName
	 * @param username
	 * @param password
	 * @return JsonObject
	 */
	public static JsonObject adminAuth(SMessageAuth smessage) {
		
		JsonObject output = null;
		JsonObject response = authOpenstack(smessage,true);
		
		if(response!=null) {

			output = new JsonObject();
		
			output.add("X-Auth-Token", response.getAsJsonObject("access").getAsJsonObject("token").get("id"));
			output.add("expires", response.getAsJsonObject("access").getAsJsonObject("token").get("expires"));
			output.add("tenant-id", response.getAsJsonObject("access").getAsJsonObject("token").getAsJsonObject("tenant").get("id"));
		}
		
		return output;		  
	}
	
	/**
	 * Gets the limits of a service/tenant in Openstack.
	 * <p>
	 * output: like openstack gives it back.
	 * 
	 * @param xAuthToken
	 * @param tenantId
	 * @return JsonObject
	 */
	public static JsonObject serviceLimits(String xAuthToken, String tenantId) {
		
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portNovaMember+"/v2/"+tenantId+"/limits");
		
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).get(ClientResponse.class);
		JsonObject output = null;
		
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(JsonObject.class);
		}
		
		return output;
	}
	

	/**
	 * Creates an instance for an service/tenant.
	 * <p>
	 * output: like openstack gives it back.
	 * 
	 * @param xAuthToken
	 * @param tenantId
	 * @param name
	 * @param script
	 * @param imageRef
	 * @param flavorRef
	 * @return JsonObject
	 */
	public static JsonObject createInstance(String xAuthToken, String tenantId, JsonElement name, JsonElement script, JsonElement imageRef ,JsonElement flavorRef) {
		
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portNovaMember+"/v2/"+tenantId+"/servers");
		
		JsonObject request = new JsonObject();	
		JsonObject serverdata = new JsonObject();
		serverdata.add("name", name);
		serverdata.add("user_data", script);
		serverdata.add("imageRef", imageRef);
        serverdata.add("flavorRef", flavorRef);
        serverdata.addProperty("max_count", "1");
        serverdata.addProperty("min_count", "1");
        request.add("server", serverdata);
		
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).post(Entity.entity(request,MediaType.APPLICATION_JSON),ClientResponse.class);
		JsonObject output = null;
		
		if(response.getStatusInfo()==Status.ACCEPTED) {
			output = response.readEntity(JsonObject.class);
		}

		return output;
	}
	
	/**
	 * Uploads a file to the given container of a service/tenant to Swift.
	 * 
	 * @param bis
	 * @param xAuthToken
	 * @param tenantid
	 * @param path
	 * @return ResponseBuilder
	 * @throws MalformedURLException
	 * @throws IOException
	 */
	public static ResponseBuilder uploadFile(InputStream bis, String xAuthToken, String tenantid, String path ) throws MalformedURLException, IOException {
		
		URLConnection urlconnection=null;

		urlconnection =  (HttpURLConnection) new URL(protocol+internalOpenstackIP+portSwiftMember+"/v1/AUTH_"+tenantid+"/"+path).openConnection();

		urlconnection.setDoOutput(true);
		urlconnection.setDoInput(true);
		
		if (urlconnection instanceof HttpURLConnection) {
			    
			((HttpURLConnection)urlconnection).setRequestMethod("PUT");
			((HttpURLConnection)urlconnection).setChunkedStreamingMode(16384);//1024? 4096? 16384?
			((HttpURLConnection)urlconnection).setRequestProperty("X-Auth-Token", xAuthToken);
			((HttpURLConnection)urlconnection).connect();

		} 
		 
		DataOutputStream bos = new DataOutputStream(urlconnection.getOutputStream());
		int i;
		
		while ((i = bis.read()) != -1) {
			bos.write(i);
		}

		
		bis.close();
		bos.flush();
		bos.close();
		
		//System.out.println(((HttpURLConnection)urlconnection).getResponseMessage());
		//System.out.println(((HttpURLConnection)urlconnection).getContentLength());
		
		//InputStream inputStream = ((HttpURLConnection)urlconnection).getInputStream();
		//Object responseObject = ((HttpURLConnection)urlconnection).getContent();
		//String responseType = ((HttpURLConnection)urlconnection).getContentType();
		int responseCode = ((HttpURLConnection)urlconnection).getResponseCode();
//		if ((responseCode>= 200) &&(responseCode<=202) ) {
//			
//			inputStream = ((HttpURLConnection)urlconnection).getInputStream();
//			int j;
//			while ((j = inputStream.read()) >0) {
//				
//				System.out.print((char)j);
//				
//			}
//			
//		} else {
//			
//			inputStream = ((HttpURLConnection)urlconnection).getErrorStream();
//			
//		}
		//inputStream.close();
		
		((HttpURLConnection)urlconnection).disconnect();
		
		JsonObject responseObject = null;
		
		if(responseCode == 201) {
			responseObject = new JsonObject();
			responseObject.addProperty("swift-url", protocol+openstackIPForPublishing+portSwiftMember+"/v1/AUTH_"+tenantid+"/"+path);
		}
		
		return Response.ok(responseObject).status(responseCode);//new ResponseImpl(responseCode, null, responseMessage, String.class); //(responseCode, null, null, null);
		
	}

	/**
	 * Gets all uploaded Files in a given container of a service/tenant in Swift.
	 * 
	 * @param xAuthToken
	 * @param tenantid
	 * @param path
	 * @return JsonArray
	 */
	public static JsonArray getUploadedFiles(String xAuthToken, String tenantid, String path ) {
		
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portSwiftMember+"/v1/AUTH_"+tenantid+"/"+path);
		
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).get(ClientResponse.class);

		JsonArray output = null;
		
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(JsonArray.class);
		}
		
		return output;
		
	}
	
	public static Status createContainer(String xAuthToken, String tenantid, String containerName){
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portSwiftMember+"/v1/AUTH_"+tenantid+"/"+containerName);
		
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).put(null,ClientResponse.class);

		
		return (Status) response.getStatusInfo();
	}
	
//	/**
//	 * Gets a file from a given container of a service/tenant in Swift.
//	 * 
//	 * @param xAuthToken
//	 * @param tenantid
//	 * @param path
//	 * @return the file
//	 * @throws IOException
//	 * @throws ClassNotFoundException
//	 */
//	public static ResponseBuilder getFile(String xAuthToken, String tenantid, String path ) throws IOException, ClassNotFoundException {
//		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
//		client.setChunkedEncodingSize(16384);
//		JerseyWebTarget tokens = client.target(protocol+openstackIP+portSwiftMember+"/v1/AUTH_"+tenantid+"/"+path);
//		ClientResponse response = tokens.header("X-Auth-Token", xAuthToken).get(ClientResponse.class);
//
//		ByteArrayOutputStream bos = new ByteArrayOutputStream();
//		IOUtils.copy(response.getEntityInputStream(), bos);
//		
//		ServletOutputStream
//
//		return Response.ok(bos.toByteArray()).type(response.getType());
//		
//	}
	
//	/**
//	 * Gets a file from a given container of a service/tenant in Swift.
//	 * 
//	 * @param xAuthToken
//	 * @param tenantid
//	 * @param path
//	 * @return the file
//	 * @throws IOException
//	 * @throws ClassNotFoundException
//	 */
//	public static void getFile(ServletOutputStream bos, String xAuthToken, String tenantid, String path ) throws IOException, ClassNotFoundException {
//		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
//		client.setChunkedEncodingSize(16384);
//		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portSwiftMember+"/v1/AUTH_"+tenantid+"/"+path);
//		ClientResponse response = tokens.header("X-Auth-Token", xAuthToken).get(ClientResponse.class);
//
//		
//		InputStream bis = response.getEntityInputStream();
//		
//		
//		int i;
//		
//		while ((i = bis.read()) != -1) {
//			bos.write(i);
//		}
//		
//		bis.close();
//		bos.flush();
//		bos.close();
//
//		//return Response.ok().type(response.getType());
//		
//	}
	
	/**
	 * Gets a file from a given container of a service/tenant in Swift.
	 * 
	 * @param xAuthToken
	 * @param tenantid
	 * @param path
	 * @return the file
	 * @throws IOException
	 * @throws ClassNotFoundException
	 */
	public static Response getFile2(String xAuthToken, String tenantid, String path ) throws IOException, ClassNotFoundException {
		StreamingOutput clientOS = null;
		HttpURLConnection urlconnection =  (HttpURLConnection) new URL(protocol+internalOpenstackIP+portSwiftMember+"/v1/AUTH_"+tenantid+"/"+path).openConnection();
		urlconnection.addRequestProperty("X-Auth-Token", xAuthToken);
		urlconnection.setDoOutput(true);
		urlconnection.setRequestMethod("GET");
		
		int responseCode = urlconnection.getResponseCode();
		System.out.println(responseCode);
		System.out.println(protocol+internalOpenstackIP+portSwiftMember+"/v1/AUTH_"+tenantid+"/"+path);
		
		if((responseCode >= 200 && responseCode <= 208 )|| responseCode == 226){
			final InputStream serviceIS = urlconnection.getInputStream();
			clientOS = new StreamingOutput() {
				@Override
				public void write(OutputStream clientOS) throws IOException, WebApplicationException{
					int i;			
					while ((i = serviceIS.read()) != -1) {
						clientOS.write(i);
					}	
					serviceIS.close();
					clientOS.flush();
					clientOS.close();
				}
			};
		}
		return Response.status(responseCode).entity(clientOS).type(urlconnection.getContentType()).build();
	}
	
//	REQ: curl -i http://137.226.58.142:35357/v2.0/users -X POST -H "User-Agent: python-keystoneclient" -H "Content-Type: application/json" -H "X-Auth-Token: f1895418260b4c549969d8f4c58e14e9"
//	REQ BODY: {"user": {"email": null, "password": "TTest", "enabled": true, "name": "TestUser", "tenantId": null}}
//
//	RESP: [200] {'date': 'Wed, 11 Dec 2013 16:19:11 GMT', 'content-type': 'application/json', 'content-length': '122', 'vary': 'X-Auth-Token'}
//	RESP BODY: {"user": {"name": "TestUser", "id": "9da4e5a0ef6f411287290da982373838", "tenantId": null, "enabled": true, "email": null}}

	public static JsonObject createNewUser(String xAuthToken, String name, String password, String email, String tenantId, Boolean enabled  )  {
		
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portKeystoneAdmin+"/v2.0/users");
		
		JsonObject jsonUserData = new JsonObject();
		JsonObject jsonUser = new JsonObject();
		jsonUserData.addProperty("name", name);
		jsonUserData.addProperty("password", password);
		jsonUserData.addProperty("email", email);
		jsonUserData.addProperty("tenantId", tenantId);
		jsonUserData.addProperty("enabled", enabled);
		jsonUser.add("user", jsonUserData);
		
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).post(Entity.entity(jsonUser,MediaType.APPLICATION_JSON),ClientResponse.class);

		JsonObject output = null;
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(JsonObject.class);
		}
		
		return output;	
		
	}
	
//	REQ: curl -i http://137.226.58.142:35357/v2.0/tenants -X POST -H "User-Agent: python-keystoneclient" -H "Content-Type: application/json" -H "X-Auth-Token: 01a935ea36884711a4f30e06b9bcca30"
//	REQ BODY: {"tenant": {"enabled": true, "name": "TestUser", "description": null}}
	public static JsonObject createNewService(String service, String description,String xAuthToken)  {
		
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portKeystoneAdmin+"/v2.0/tenants");
		
		JsonObject jsonTenantData = new JsonObject();
		JsonObject jsonTenant = new JsonObject();
		jsonTenantData.addProperty("name", service);
		jsonTenantData.addProperty("description", description);
		jsonTenantData.addProperty("enabled", true);
		jsonTenant.add("tenant", jsonTenantData);
		
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).post(Entity.entity(jsonTenant,MediaType.APPLICATION_JSON),ClientResponse.class);

		JsonObject output = null;
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(JsonObject.class);
		}
		
		return output;	
		
	}

	
//	curl -X PUT -H 'X-Auth-Token:<token>' https://localhost:35357/v2.0/tenants/<tenantid>/users/<userid>/roles/OS-KSADM/<role-id>
	public static JsonObject addUserRole(String tenantid, String userid, String roleid, String xAuthToken)  {
		
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portKeystoneAdmin+"/v2.0/tenants/"+tenantid+"/users/"+userid+"/roles/OS-KSADM/"+roleid);
		
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).put(null,ClientResponse.class);

		JsonObject output = null;
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(JsonObject.class);
		}
		
		return output;		
	}
	
	
//	curl -i http://137.226.58.2:35357/v2.0/OS-KSADM/roles -X GET -H "X-Auth-Token: "	
	public static JsonObject getRoles(String xAuthToken)  {
	
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portKeystoneAdmin+"/v2.0/OS-KSADM/roles");
	
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).get(ClientResponse.class);

		JsonObject output = null;
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(JsonObject.class);
		}
	
		return output;		
	}
	
	
//	curl -i http://137.226.58.142:35357/v2.0/users -X GET  -H "X-Auth-Token: "
	public static JsonObject getUsers(String xAuthToken)  {
	
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portKeystoneAdmin+"/v2.0/users");
	
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).get(ClientResponse.class);

		JsonObject output = null;
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(JsonObject.class);
		}
	
		return output;	
	}
	
	//curl -i http://137.226.58.142:8774/v2/d34a0c1691fd4bf6b89214e2731c0b33/images/detail -X GET -H "X-Auth-Token: 4ffb1aa188804dd4bce98e4ce11d8839"
	public static JsonObject getImages(String xAuthToken, String tenantId)  {
		
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portNovaMember+"/v2/"+tenantId+"/images/detail");
	
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).get(ClientResponse.class);

		JsonObject output = null;
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(JsonObject.class);
		}
	
		return output;	
	}
	
	//curl -i http://137.226.58.142:8774/v2/d34a0c1691fd4bf6b89214e2731c0b33/servers/detail -X GET  -H "X-Auth-Token: e8e4949e56ab4072be08287d3fd52d3d"
	public static JsonObject getInstances(String xAuthToken, String tenantId)  {
		
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portNovaMember+"/v2/"+tenantId+"/servers/detail");
	
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).get(ClientResponse.class);

		JsonObject output = null;
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(JsonObject.class);
		}
	
		return output;	
	}
	//curl -i http://137.226.58.142:8774/v2/d34a0c1691fd4bf6b89214e2731c0b33/servers/detail -X GET  -H "X-Auth-Token: e8e4949e56ab4072be08287d3fd52d3d"
	//curl -i http://137.226.58.142:8774/v2/d34a0c1691fd4bf6b89214e2731c0b33/servers/44268c11-64d9-4b7b-95ea-d63f28c6db5f/action -X POST -H "Content-Type: application/json" -H "Accept: application/json" -H "X-Auth-Token: 67bdf0dc06f04d8fb75dfe27ba946ca6" -d '{"os-start": null}'
	public static JsonObject doActionOnInstance(String xAuthToken, String tenantId, String instanceId, JsonObject action)  {
		
		JerseyClient client = JerseyClientBuilder.createClient(returnClientConfig());
		JerseyWebTarget tokens = client.target(protocol+internalOpenstackIP+portNovaMember+"/v2/"+tenantId+"/servers/"+instanceId+"/action");
	
		ClientResponse response = tokens.request().accept(MediaType.APPLICATION_JSON).header("X-Auth-Token", xAuthToken).post(Entity.entity(action,MediaType.APPLICATION_JSON),ClientResponse.class);

		JsonObject output = null;
		if(response.getStatusInfo()==Status.OK) {
			output = response.readEntity(JsonObject.class);
		}
	
		return output;	
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
