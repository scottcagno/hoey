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

    Boolean isComplete() {
        def company = repo.findOne 1L
        return (company != null && company.markup != null && company.laborRate != null && company.laborRate != "")
    }

    // helper method
    def mergeProperties(source, target) {
        source.properties.each { key, value ->
            if (target.hasProperty(key as String) && !(key in ['class', 'metaClass']) && value != null && value != ""   )
                target[key as String] = value
        }
    }

}

