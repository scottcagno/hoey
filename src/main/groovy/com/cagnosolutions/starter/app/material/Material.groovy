package com.cagnosolutions.starter.app.material

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@Entity
class Material {

	@Id
	@GeneratedValue
	Long id
	String cat, name
	Double cost, price
	Boolean markup, taxed
}
