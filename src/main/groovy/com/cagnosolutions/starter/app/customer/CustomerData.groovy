package com.cagnosolutions.starter.app.customer

import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import org.springframework.stereotype.Service

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Service(value = "customerService")
class CustomerService {

	@Autowired
	CustomerRepository repo

	List<Customer> findAll() {
		repo.findAll()
	}

	Page<Customer> findAll(int page, int size, String... fields) {
		repo.findAll(new PageRequest(page, size, Sort.Direction.ASC, fields))
	}

	Customer findOne(Long id) {
		repo.findOne id
	}

	Customer save(Customer customer) {
		repo.save customer
	}

	def delete(Long id) {
		repo.delete id
	}

}

@CompileStatic
@Repository
interface CustomerRepository extends JpaRepository<Customer, Long> {
}
