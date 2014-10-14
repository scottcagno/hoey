package com.cagnosolutions.starter.app.item

import com.cagnosolutions.starter.app.material.Material

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@Entity
class Item {

	@Id
	@GeneratedValue
	Long id
	@ManyToOne
	Material material
	Double count, total

	Double updateTotal(Double markup) {
		this.total = (material.markup? (count * material.cost * (1 + (markup / 100))) : (count * material.cost)) as Double
        this.total
	}
}
