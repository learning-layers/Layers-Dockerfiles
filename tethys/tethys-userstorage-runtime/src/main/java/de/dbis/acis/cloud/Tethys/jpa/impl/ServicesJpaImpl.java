package de.dbis.acis.cloud.Tethys.jpa.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;

import de.dbis.acis.cloud.Tethys.entity.Services;
import de.dbis.acis.cloud.Tethys.jpa.ServicesJpa;
import de.dbis.acis.cloud.Tethys.util.JPAHelper;

/**
 * Implementation of the JPA-Interface for the Services-entity.
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
public class ServicesJpaImpl implements ServicesJpa{

	private EntityManager entityManager; 
	
	public ServicesJpaImpl() {
		entityManager = JPAHelper.getTethysEntityManager().createEntityManager();
	}
	
	@Override
	public boolean save(Services services) {
		EntityTransaction entityTransaction = entityManager.getTransaction();
		entityTransaction.begin();
		entityManager.persist(services);
		entityTransaction.commit();
		//entityManager.flush();
		return true;
	}

	@Override
	public boolean delete(Services services) {
		services = entityManager.getReference(Services.class, services.getId());
		if (services == null)
			return false;
		entityManager.remove(services);
		entityManager.flush();
		return true;
	}

	@Override
	public boolean update(Services services) {
		entityManager.merge(services);
		entityManager.flush();
		return true;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Services> getAllServices() {
		Query queryFindServiceByName = entityManager.createNamedQuery("Services.findAllServices");
		List<Services> services = queryFindServiceByName.getResultList();
		return services;
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public Services getServiceByName(String name) {
		Query queryFindServiceByName = entityManager.createNamedQuery("Services.findServiceByName");
		queryFindServiceByName.setParameter("name", name);
		List<Services> services = queryFindServiceByName.getResultList();
		Services result = null;
		if(services.size() > 0) {
			result = services.get(0);
		}
		return result;
	}

	@Override
	@SuppressWarnings("unchecked")
	public Services getServiceById(int id) {
		Query queryFindServiceByID = entityManager.createNamedQuery("Services.findServiceByID");
		queryFindServiceByID.setParameter("id", id);
		List<Services> users = queryFindServiceByID.getResultList();
		Services result = null;
		if(users.size() > 0) {
			result = users.get(0);
		}
		return result;
	}

}
