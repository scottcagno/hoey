package com.cagnosolutions.starter.app.customer
import com.cagnosolutions.starter.app.job.Job

import javax.persistence.*

@Entity
class Customer {

	@Id
	@GeneratedValue
	Long id
	String company, name, email, phone
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "customer_id")
	List<Job> jobs

	def addJob(Job job) {
		jobs.add(job)
	}
}
