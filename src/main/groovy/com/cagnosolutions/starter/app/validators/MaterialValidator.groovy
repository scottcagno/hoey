package com.cagnosolutions.starter.app.validators

import groovy.transform.CompileStatic
import org.hibernate.validator.constraints.NotBlank

import javax.validation.constraints.NotNull

/**
 * Created by greg on 1/5/15.
 */

@CompileStatic
class MaterialValidator {

	Long id

	@NotBlank(message = "Required field")
	String cat

	@NotBlank(message = "Required field")
	String name

	@NotNull(message = "Required field")
	Double cost

	Boolean markup, taxed
}
