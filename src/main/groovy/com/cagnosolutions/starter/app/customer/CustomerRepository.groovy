package com.cagnosolutions.starter.app.customer

import groovy.transform.CompileStatic
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository


/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Repository
interface CustomerRepository extends JpaRepository<Customer, Long> {
}
