package de.dbis.acis.cloud.Tethys.jpa;

import java.util.List;

import de.dbis.acis.cloud.Tethys.entity.ServiceFlavors;

/**
 * JPA-Interface for the ServiceFlavors-entity.
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
public interface ServiceFlavorsJpa {

	public boolean save(ServiceFlavors serviceflavors);
	public boolean delete(ServiceFlavors serviceflavors);
	public boolean update(ServiceFlavors serviceflavors);
	
	public List<ServiceFlavors> getAllServiceFlavors();
	public List<ServiceFlavors> getServiceFlavorsBySId(int sid);
	public List<ServiceFlavors> getServiceFlavorsByType(String type);
	
	public ServiceFlavors getServiceFlavorById(int id);
	
}
