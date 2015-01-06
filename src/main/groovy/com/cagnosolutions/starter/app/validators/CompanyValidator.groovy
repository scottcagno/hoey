package com.cagnosolutions.starter.app.validators
import groovy.transform.CompileStatic

import javax.validation.constraints.NotNull
/**
 * Created by greg on 1/5/15.
 */

@CompileStatic
class CompanyValidator {

	@NotNull(message = "Required field")
	Double markup

	@NotNull(message = "Required field")
	Double laborRate

	String password
}
