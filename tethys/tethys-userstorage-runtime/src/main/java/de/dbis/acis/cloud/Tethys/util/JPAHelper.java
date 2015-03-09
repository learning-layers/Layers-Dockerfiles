package de.dbis.acis.cloud.Tethys.util;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * 
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
public class JPAHelper { 
    private static EntityManagerFactory entityManagerFactoryTethys = null;

    /**
     * Empty - no instantiation
     */
    private JPAHelper() { }
    
    /**
     * static initializer - create EntityManagerFactory
     */
    static {
//        try {
            entityManagerFactoryTethys =  Persistence.createEntityManagerFactory("Tethys");
            System.out.println("Create EntityManagerFactory for Tethys");
//        } catch (Throwable ex) {
//            //logger.error("Initial SessionFactory creation failed", ex);
//            throw new ExceptionInInitializerError(ex);
//        }
        
    }

    /**
     * Returns the EntityManagerFactory
     * 
     * @return the EntityManagerFactory
     */
    public static EntityManagerFactory getTethysEntityManager() {
    	return entityManagerFactoryTethys;
    }
    
}