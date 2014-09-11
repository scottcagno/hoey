package com.cagnosolutions.starter.app.room

import com.cagnosolutions.starter.app.item.Item

import javax.persistence.CascadeType
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.OneToMany

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@Entity
class Room {

	@Id
	@GeneratedValue
	Long id
	String name, notes
	Double total = 0D
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "room_id")
	List<Item> items

	def addItem(Item item) {
		items << item
	}

	Double updateTotals(Double markup) {
		println markup
		this.total = (items.size() <=0)? 0D : ((items*.updateTotal().sum() as Double) * (1 + (markup / 100)))
	    this.total
    }
}
