package com.cagnosolutions.starter.app.material

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Entity
class Material {

	@Id
	@GeneratedValue
	Long id
	String cat, name
	Double cost
	Boolean markup, taxed
}
