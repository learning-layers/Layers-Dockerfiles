package de.dbis.acis.cloud.Tethys.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;


/**
 * Represents the Services-Entity.
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
@Entity
@Table(name = "Services")
@NamedNativeQueries({ 
	@NamedNativeQuery(name = "Services.findAllServices", query = "SELECT * FROM Services",resultClass=Services.class),
	@NamedNativeQuery(name = "Services.findServiceByID", query = "SELECT * FROM Services where Services.ID= :id",resultClass=Services.class),
	@NamedNativeQuery(name = "Services.findServiceByName", query = "SELECT * FROM Services s where s.NAME= :name",resultClass=Services.class)
	
})
public class Services implements Serializable {
	 
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "ID", nullable = false)
	private int id;
	
	@Column(name = "NAME", nullable = false)
	private String name;
	
//	@Expose(serialize = false, deserialize = false)
	@Column(name = "TENANTID", nullable = false)
	private String tenantid;
		
	@Column(name = "DESCRIPTION", nullable = true)
	private String description;
	
	@Column(name = "CREATIONTIME", nullable = true)
	private Timestamp creationtime;

	public void setId(int id){
		this.id = id;
	}
	
	public int getId(){
		return this.id;
	}
	
	
	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setTenantID(String tenantID) {
		this.name = tenantID;
	}

	public String getTenantID() {
		return tenantid;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}
	
	
	public void setCreationtime(Timestamp creationtime) {
		this.creationtime = creationtime;
	}

	public Timestamp getCreationtime() {
		return creationtime;
	}
	
	public String toString(){
		return getId()+", "+getName()+", "+getDescription()+", "+getCreationtime();
	}
}
