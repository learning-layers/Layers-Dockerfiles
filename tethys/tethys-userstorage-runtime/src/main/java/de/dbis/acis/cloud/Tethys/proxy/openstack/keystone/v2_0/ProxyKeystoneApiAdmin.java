package de.dbis.acis.cloud.Tethys.proxy.openstack.keystone.v2_0;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.HEAD;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.google.gson.JsonObject;

/**
 * JAX-RS annotated Interface for Openstack Keystone. We will use it to generate Proxies.
 * 
 * All annotations are from the specification you can find under http://developer.openstack.org/api-ref-identity-v2.html
 * This class reference to the second section "Identity admin API v2.0 (STABLE)"
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
@Path("/v2.0")
public interface ProxyKeystoneApiAdmin {

	/**
	 * Versions : Get version details
	 * @return
	 */
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject getApiVersionDetails();
	
	// Extensions

	/**
	 * Extensions : List extensions
	 * @return
	 */
	@Path("/extensions")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject listExtensions();
	
	/**
	 * Extensions : Get extension details
	 * @param extensionAlias
	 * @return
	 */
	@Path("/extensions/{alias}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject getExtensionDetails(@PathParam("alias") String extensionAlias);
	
	// Tokens
	
	/**
	 * Tokens : Authenticate for Admin API
	 * @param userdata
	 * @return
	 */
	@Path("/tokens")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject authenticate(JsonObject userdata);
	
	/**
	 * Tokens: Validate token
	 * @param tokenId
	 * @return
	 */
	@Path("/tokens/{tokenId}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject validateToken(@PathParam("tokenId") String tokenId, @HeaderParam("X-Auth-Token") String xAuthToken);
	
	/**
	 * Tokens : Validate token (admin)
	 * @param tokenId
	 * @return
	 */
	@Path("/tokens/{tokenId}")
	@HEAD
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject validateAdminToken(@PathParam("tokenId") String tokenId, @HeaderParam("X-Auth-Token") String xAuthToken);
	
	//Users
	
	@Path("/users")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject addUser(@HeaderParam("X-Auth-Token") String xAuthToken, JsonObject newUser);
	
	@Path("/users/​{user_id}​")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject updateUser(@PathParam("userId") String userId, JsonObject newUser);
	
	@Path("/users/​{user_id}​")
	@DELETE
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject deleteUser(@PathParam("userId") String userId);
	
	@Path("/users/​{name}​")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject getUserDetailsByName(@PathParam("name") String userName);
	
	@Path("/users/​{user_id}​")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject getUserDetailsById(@PathParam("userId") String userId);
	
	@Path("/users/{user_id}/roles")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject listUserRolesGlobal(@PathParam("userId") String userId);
	
	//Tenants
	
	@Path("/tenants")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject listTenants(@HeaderParam("X-Auth-Token") String xAuthToken);
	
	@Path("/tenants")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject getTenantDetailsByName(@HeaderParam("X-Auth-Token") String xAuthToken);
	
	@Path("/tenants/{tenantId}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject getTenantDetailsById(@PathParam("tenantId") String tenantId, @HeaderParam("X-Auth-Token") String xAuthToken);
	
	@Path("/tenants/{tenantId}/users/{userId}/roles")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public JsonObject listUserRolesInTenant(@PathParam("tenantId") String tenantId, @PathParam("userId") String userId, @HeaderParam("X-Auth-Token") String xAuthToken);
	
}
