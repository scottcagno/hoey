package com.cagnosolutions.starter.app.company

import javax.persistence.Entity
import javax.persistence.Id

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@Entity
class Company {

    @Id
    Long id = 1L
    String logo, company, street, city, state, zip
    String owner, username, phone, password, role = "ROLE_ADMIN"
    Double markup
	Integer terms
	Double laborRate
    Short active = 1

    String toString(){
        "${company}\n${street} ${city}, ${state} ${zip}\n${phone}\n${email}"
    }

}