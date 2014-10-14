package com.cagnosolutions.starter.app.job

import com.cagnosolutions.starter.app.room.Room

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
class Job {

	@Id
	@GeneratedValue
	Long id

    String name, notes
	Double laborHours
	Double laborTotal
	Double total
    Integer status // status codes: 0 - quote, 1 - active, 2 - invoiced, 3 - paid
    Date created, invoiced

	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "job_id")
	List<Room> rooms

	def addRoom(Room room) {
        rooms << room
	}

	def updateTotals(Double markup, Double laborRate) {
		this.laborTotal = (laborHours == null) ? 0D : laborRate * laborHours as Double
        this.total = ((rooms.size() <= 0)? 0D : (laborTotal + (rooms*.updateTotals(markup).sum() as Double)))
    }
}
