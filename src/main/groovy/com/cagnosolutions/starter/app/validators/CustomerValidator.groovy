package com.cagnosolutions.starter.app.validators
import groovy.transform.CompileStatic
import org.hibernate.validator.constraints.NotBlank

import javax.validation.constraints.Pattern

/**
 * Created by greg on 1/5/15.
 */

@CompileStatic
class CustomerValidator {

	Long id

	String company

	@NotBlank(message = "Required field")
	String name

	@NotBlank(message = "Required field")
	String email

	@NotBlank(message = "Required field")
	@Pattern(regexp = "\\d{10}|\\s?", message = "Must be a 10 digit number with no symbols/spaces")
	String phone
}
