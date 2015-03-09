package de.dbis.acis.cloud.Tethys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;

/**
 * Represents the ServiceFlavors-Entity.
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
@Entity
@Table(name = "ServiceFlavors")
@NamedNativeQueries({ 
	@NamedNativeQuery(name = "ServicesFlavors.findAllServiceFlavors", query = "SELECT * FROM Serviceflavors",resultClass=ServiceFlavors.class),
	@NamedNativeQuery(name = "ServicesFlavors.findServiceFlavorsBySID", query = "SELECT * FROM Serviceflavors where Services.SID= :sid",resultClass=ServiceFlavors.class),
	@NamedNativeQuery(name = "ServicesFlavors.findServiceFlavorsByType", query = "SELECT * FROM Serviceflavors s where s.TYPE= :type",resultClass=ServiceFlavors.class),
	
	@NamedNativeQuery(name = "ServicesFlavors.findServiceFlavorByID", query = "SELECT * FROM Serviceflavors where Services.ID= :id",resultClass=ServiceFlavors.class)
})
public class ServiceFlavors {
	
	//@Expose(serialize = false, deserialize = false)
	 
	@Id
	@Column(name = "ID", nullable = false)
	private int id;
	
	@Column(name = "SID", nullable = false)
	private int sid;
	
	@Column(name = "TYPE", nullable = false)
	private String type;

	@Column(name = "version", nullable = false)
	private int version;
		
	@Column(name = "DESCRIPTION", nullable = true)
	private String description;
	

	public void setId(int id){
		this.id = id;
	}
	
	public int getId(){
		return this.id;
	}
	
	public void setSId(int sid){
		this.sid = sid;
	}
	
	public int getSId(){
		return this.sid;
	}
	
	public void setType(String type) {
		this.type = type;
	}

	public String getType() {
		return this.type;
	}
	
	public void setversion(int version){
		this.version = version;
	}
	
	public int getVersion(){
		return this.version;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}
}