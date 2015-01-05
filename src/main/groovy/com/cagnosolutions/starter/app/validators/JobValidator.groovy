package com.cagnosolutions.starter.app.validators

import groovy.transform.CompileStatic
import org.hibernate.validator.constraints.NotBlank

/**
 * Created by greg on 1/5/15.
 */

@CompileStatic
class JobValidator {

	Long id

	@NotBlank(message = "Required field")
	String name

	@NotBlank(message = "Required field")
	String notes
}
