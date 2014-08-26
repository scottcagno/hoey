package com.cagnosolutions.starter.app.room

import com.cagnosolutions.starter.app.item.Item

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
	String name, total
	@OneToMany
	@JoinColumn(name = "room_id")
	List<Item> items
}
