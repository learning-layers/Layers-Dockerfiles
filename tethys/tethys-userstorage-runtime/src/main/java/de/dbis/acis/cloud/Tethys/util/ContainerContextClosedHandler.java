package de.dbis.acis.cloud.Tethys.util;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;
//import java.util.logging.Logger;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.mysql.jdbc.AbandonedConnectionCleanupThread;


/**
 * This class is here to prevent a memory leak, because tomcat can't stop them jdbc-thread(mysqlconnection).
 */
@WebListener
public class ContainerContextClosedHandler implements ServletContextListener {
    //private static final Logger logger = Logger.getLogger(ContainerContextClosedHandler.class.getName());

	/**
	 * Does nothing.
	 */
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        // nothing to do
    	System.out.println("Initialize Container Context");
    }

    /**
     * To Clean up.
     */
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
    	System.out.println("Destroy Container Context");
        Enumeration<Driver> drivers = DriverManager.getDrivers();     

        Driver driver = null;

        // clear drivers
        while(drivers.hasMoreElements()) {
            try {
                driver = drivers.nextElement();
                DriverManager.deregisterDriver(driver);

            } catch (SQLException ex) {
                // deregistration failed, might want to do something, log at the very least
            }
        }

        // MySQL driver leaves around a thread. This static method cleans it up.
        try {
            AbandonedConnectionCleanupThread.shutdown();
        } catch (InterruptedException e) {
            // again failure, not much you can do
        }
    }

}
