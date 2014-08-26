package com.cagnosolutions.starter.app.customer

import com.cagnosolutions.starter.app.job.Job

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@Entity
class Customer {

    @Id
    @GeneratedValue
    Long id
    String company, name, email, phone
    @OneToMany
    Job jobs
}
