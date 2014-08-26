package com.cagnosolutions.starter.app.job

import com.cagnosolutions.starter.app.room.Room

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
	String name, total
	@OneToMany
	@JoinColumn(name = "job_id")
	List<Room> rooms
}
