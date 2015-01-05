package com.cagnosolutions.starter.app.company
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@CompileStatic
@Service
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
