package com.cagnosolutions.starter.app.job

import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.stereotype.Service

@CompileStatic
@Service
class JobService {

	@Autowired
	JobRepository repo

	List<Job> findAll() {
		repo.findAll()
	}

	Page<Job> findAll(int page, int size, String... fields) {
		repo.findAll(new PageRequest(page, size, Sort.Direction.ASC, fields))
	}

	Job findOne(Long id) {
		repo.findOne id
	}

	Job save(Job job) {
		repo.save job
	}

	def delete(Long id) {
		repo.delete id
	}

    List<Job> findAllInvoiced() {
        repo.findAllInvoiced()
    }

	Long findCustomerIdByJob(Long jobId) {
		repo.findCustomerIdByJob(jobId)
	}

	// helper method
	def mergeProperties(source, target) {
		source.properties.each { key, value ->
			if (target.hasProperty(key as String) && !(key in ['class', 'metaClass']) && value != null)
				target[key as String] = value
		}
	}
}

