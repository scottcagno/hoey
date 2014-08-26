package com.cagnosolutions.starter.app.customer

import com.cagnosolutions.starter.app.job.Job

import javax.persistence.*

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@Entity
class Customer {

	@Id
	@GeneratedValue
	Long id
	String company, name, email, phone
	@OneToMany
	@JoinColumn(name = "customer_id")
	List<Job> jobs
}
