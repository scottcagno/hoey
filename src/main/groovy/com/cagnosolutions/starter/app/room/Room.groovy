package com.cagnosolutions.starter.app.room

import com.cagnosolutions.starter.app.item.Item
import groovy.transform.CompileStatic

import javax.persistence.CascadeType
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.OneToMany

@CompileStatic
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
		this.total = (items.size() <=0)? 0D : ((items*.updateTotal(markup).sum() as Double))
	    this.total
    }
}
