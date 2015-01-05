package com.cagnosolutions.starter.app.validators

import groovy.transform.CompileStatic
import org.springframework.stereotype.Component
import org.springframework.validation.BindingResult
import org.springframework.validation.FieldError

@CompileStatic
@Component
class ValidationWrapper {

	Map<String,String> errors

	Map<String,String> bindErrors(BindingResult bindingResult) {
		errors = new HashMap<String,String>()
		for(FieldError error : bindingResult.getFieldErrors())
			errors[error.field] = error.defaultMessage
		errors
	}
}
