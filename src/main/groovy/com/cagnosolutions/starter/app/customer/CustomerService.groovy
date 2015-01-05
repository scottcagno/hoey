package com.cagnosolutions.starter.app.customer

import com.cagnosolutions.starter.app.validators.CustomerValidator
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
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

	Customer generateFromValidator(CustomerValidator customerValidator) {
		def customer = new Customer()
		mergeProperties customerValidator, customer
		customer
	}

	// helper method
	def mergeProperties(source, target) {
		source.properties.each { key, value ->
			if (target.hasProperty(key as String) && !(key in ['class', 'metaClass']) && value != null)
				target[key as String] = value
		}
	}

}

