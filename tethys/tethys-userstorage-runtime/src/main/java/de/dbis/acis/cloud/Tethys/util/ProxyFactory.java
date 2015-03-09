package de.dbis.acis.cloud.Tethys.util;

import javax.ws.rs.client.ClientBuilder;

import org.glassfish.hk2.api.Factory;
import org.glassfish.jersey.client.proxy.WebResourceFactory;

/**
 * Factory to create Proxy classes. Testing Purposes.
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
public class ProxyFactory<T> implements Factory<T> {

	private Class<T> t;
	
	public ProxyFactory(Class<T> t) {
		this.t =t;
	}
	
    public T provide(){
    	return WebResourceFactory.newResource(t, ClientBuilder.newClient().target("http://137.226.58.2:5000"));
    }

    public void dispose(T instance) { }

}