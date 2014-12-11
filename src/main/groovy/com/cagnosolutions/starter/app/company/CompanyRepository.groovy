package com.cagnosolutions.starter.app.company

import groovy.transform.CompileStatic
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository


/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Repository
interface CompanyRepository extends JpaRepository<Company, Long> {

}
