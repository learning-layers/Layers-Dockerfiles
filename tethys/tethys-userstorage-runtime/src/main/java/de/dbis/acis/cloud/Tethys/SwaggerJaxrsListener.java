package de.dbis.acis.cloud.Tethys;

import java.util.ResourceBundle;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.wordnik.swagger.config.ConfigFactory;
import com.wordnik.swagger.config.ScannerFactory;
import com.wordnik.swagger.config.SwaggerConfig;
import com.wordnik.swagger.jaxrs.config.DefaultJaxrsScanner;
import com.wordnik.swagger.jaxrs.reader.DefaultJaxrsApiReader;
import com.wordnik.swagger.reader.ClassReaders;

@WebListener
public class SwaggerJaxrsListener implements ServletContextListener {

	ResourceBundle resourceBundle = ResourceBundle.getBundle("swagger");

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("Swagger starts...");
		SwaggerConfig swaggerConfig = new SwaggerConfig();
		ConfigFactory.setConfig(swaggerConfig);
		swaggerConfig.setBasePath(
				"http://"+resourceBundle.getString("swaggerWebApplicationHost")
				+":"		+resourceBundle.getString("swaggerWebApplicationPort")
				+"/"		+resourceBundle.getString("swaggerWebApplicationName")
		);
		swaggerConfig.setApiVersion("1.0.0");
		ScannerFactory.setScanner(new DefaultJaxrsScanner());
		ClassReaders.setReader(new DefaultJaxrsApiReader());
		System.out.println("Swagger started!");
		System.out.println("");
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("Swagger destroyed");
	}

}
