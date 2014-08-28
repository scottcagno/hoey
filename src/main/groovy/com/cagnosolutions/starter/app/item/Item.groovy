package com.cagnosolutions.starter.app.item

import com.cagnosolutions.starter.app.material.Material

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@Entity
class Item {

	@Id
	@GeneratedValue
	Long id
	@OneToOne
	Material material
	Float count, total

	void calcTotal() {
		this.total = count * material.price
	}
}
