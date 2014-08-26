package com.cagnosolutions.starter.app.user

import groovy.transform.CompileStatic
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Table

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Entity
@Table(name = "user")
class User {

    @Id
    @GeneratedValue
    Long id
    String name, email, username, password, role = "ROLE_USER"
    Long creation, lastSeen
    Short active = 1

    // 0% (no markup by default)
    Float markup = 1.0
}
