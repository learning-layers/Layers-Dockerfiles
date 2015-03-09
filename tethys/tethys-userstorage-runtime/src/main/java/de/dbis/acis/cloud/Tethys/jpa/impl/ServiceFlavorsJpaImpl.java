package de.dbis.acis.cloud.Tethys.jpa.impl;

import java.util.List;

import javax.persistence.EntityManager;

import de.dbis.acis.cloud.Tethys.entity.ServiceFlavors;
import de.dbis.acis.cloud.Tethys.jpa.ServiceFlavorsJpa;
import de.dbis.acis.cloud.Tethys.util.JPAHelper;

/**
 * Implementation of the JPA-Interface for the ServiceFlavors-entity.
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
public class ServiceFlavorsJpaImpl implements ServiceFlavorsJpa {

	private EntityManager entityManager;
	
	
	protected EntityManager getEntityManager() {
		return entityManager;
	}
	
	public ServiceFlavorsJpaImpl() {
		entityManager= JPAHelper.getTethysEntityManager().createEntityManager();
	}
	
	@Override
	public boolean save(ServiceFlavors serviceflavors) {
		entityManager.persist(serviceflavors);
		entityManager.flush();
		return true;
	}

	@Override
	public boolean delete(ServiceFlavors serviceflavors) {
		serviceflavors = entityManager.getReference(ServiceFlavors.class, serviceflavors.getId());
		if (serviceflavors == null)
			return false;
		entityManager.remove(serviceflavors);
		entityManager.flush();
		return true;
	}

	@Override
	public boolean update(ServiceFlavors serviceflavors) {
		entityManager.merge(serviceflavors);
		entityManager.flush();
		return true;
	}

	@Override
	public List<ServiceFlavors> getAllServiceFlavors() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ServiceFlavors> getServiceFlavorsBySId(int sid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ServiceFlavors> getServiceFlavorsByType(String type) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceFlavors getServiceFlavorById(int id) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
