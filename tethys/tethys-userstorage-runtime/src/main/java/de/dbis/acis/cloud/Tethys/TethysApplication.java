package de.dbis.acis.cloud.Tethys;

import javax.ws.rs.ApplicationPath;

import org.glassfish.jersey.filter.LoggingFilter;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.ServerProperties;

/**
 * Deployment class for a JAX-RS (Jersey) application with Servlet 3.0.
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
@ApplicationPath("/*")
public class TethysApplication extends ResourceConfig {

	public TethysApplication() {
		System.out.println("Tethys starts...");
		packages("de.dbis.acis.cloud.Tethys.resource");
		register(new TethysBinder());
		register(de.dbis.acis.cloud.Tethys.util.GsonMessageBodyHandler.class);
		register(de.dbis.acis.cloud.Tethys.util.CORSFilter.class);
		register(de.dbis.acis.cloud.Tethys.util.ContainerContextClosedHandler.class);
		packages("com.wordnik.swagger.jaxrs.json");
	
		register(com.wordnik.swagger.jersey.listing.ApiListingResource.class);
		register(com.wordnik.swagger.jersey.listing.JerseyApiDeclarationProvider.class);
		register(com.wordnik.swagger.jersey.listing.ApiListingResourceJSON.class);
		register(com.wordnik.swagger.jersey.listing.JerseyResourceListingProvider.class);
		
//		register(com.wordnik.swagger.jaxrs.listing.ApiListingResource.class);
//		register(com.wordnik.swagger.jaxrs.listing.ApiDeclarationProvider.class);
//		register(com.wordnik.swagger.jaxrs.listing.ApiListingResourceJSON.class);
//		register(com.wordnik.swagger.jaxrs.listing.ResourceListingProvider.class);
		register(new LoggingFilter());
		property(ServerProperties.TRACING, "ALL");
		System.out.println("Tethys started!");
		System.out.println("");
	}
}


