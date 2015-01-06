package com.cagnosolutions.starter.app.company

import javax.persistence.Entity
import javax.persistence.Id

@Entity
class Company {

    @Id
    Long id = 1L
    String username = "hoeyenterprises@yahoo.com"
    String password, role = "ROLE_ADMIN"
    Double markup
	Double laborRate
    Short active = 1

}