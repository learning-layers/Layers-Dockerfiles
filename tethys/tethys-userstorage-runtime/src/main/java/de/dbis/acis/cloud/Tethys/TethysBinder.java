package de.dbis.acis.cloud.Tethys;

import javax.ws.rs.client.ClientBuilder;

import org.glassfish.hk2.utilities.binding.AbstractBinder;
import org.glassfish.jersey.client.proxy.WebResourceFactory;
import de.dbis.acis.cloud.Tethys.util.GsonMessageBodyHandler;

/**
 * HK2 Binding class. Which binds classes for Dependency Injection(DI).
 * See "HK2", "JSR-330", "DI" and "CDI" for more Information.
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
public class TethysBinder extends AbstractBinder {

	@Override
	protected void configure() {
		//Binding via Factory. In this Case too much overhead.
		//bindFactory(new ProxyFactory<ProxyKeystoneApi>(ProxyKeystoneApi.class)).to(ProxyKeystoneApi.class);
		//Binding by Hand. Faster than binding by Factory.
		//bind(WebResourceFactory.newResource(ProxyKeystoneApi.class, ClientBuilder.newClient().target("http://137.226.58.2:5000").register(GsonMessageBodyHandler.class))).to(ProxyKeystoneApi.class);
		//bind(WebResourceFactory.newResource(ProxyKeystoneApiAdmin.class, ClientBuilder.newClient().target("http://137.226.58.2:35357").register(GsonMessageBodyHandler.class))).to(ProxyKeystoneApiAdmin.class);
	}

}
