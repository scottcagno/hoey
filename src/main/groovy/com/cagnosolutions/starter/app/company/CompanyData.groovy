package com.cagnosolutions.starter.app.company

import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import org.springframework.stereotype.Service

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Service(value = "companyService")
class CompanyService  {

    @Autowired
    CompanyRepository repo

    Company findOne() {
        repo.findOne 1L
    }

    def save(Company company) {
        repo.save company
    }

}

@CompileStatic
@Repository
interface CompanyRepository extends JpaRepository<Company, Long> {

}
