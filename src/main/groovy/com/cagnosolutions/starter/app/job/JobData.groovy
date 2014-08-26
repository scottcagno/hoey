package com.cagnosolutions.starter.app.job

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
@Service(value = "jobService")
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

}

@CompileStatic
@Repository
interface JobRepository extends JpaRepository<Job, Long> {

}
