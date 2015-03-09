package de.dbis.acis.cloud.Tethys.proxy.openstack.keystone.v2_0;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.google.gson.JsonObject;

/**
 * JAX-RS annotated Interface for Openstack Keystone. We will use it to generate Proxies.
 * 
 * All annotations are from the specification you can find under http://developer.openstack.org/api-ref-identity-v2.html
 * This class reference to the first section "Identity API v2.0 (STABLE)"
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
@Path("/")
public interface ProxyKeystoneApi {
		
	// API versions
	
	/**
	 * API versions : List versions
	 * @return
	 */
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject listApiVersions();
	
	/**
	 * API versions : Show version details
	 * @return
	 */
	@Path("v2.0")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject getApiVersionDetails();
	
	// Extensions

	/**
	 * Extensions : List extensions
	 * @return
	 */
	@Path("v2.0/extensions")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject listExtensions();
	
	/**
	 * Extensions : Get extension details
	 * @param extensionAlias
	 * @return
	 */
	@Path("v2.0/extensions/{alias}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject getExtensionDetails(@PathParam("alias") String extensionAlias);
	
	// Tokens
	
	/**
	 * Tokens : Authenticate
	 * @param userdata
	 * @return
	 */
	@Path("v2.0/tokens")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject authenticate(JsonObject userdata);
	
	/**
	 * Tokens : List tenants
	 * @param xAuthToken
	 * @return
	 */
	@Path("v2.0/tenants")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject listTenants(@HeaderParam("X-Auth-Token") String xAuthToken);
}
