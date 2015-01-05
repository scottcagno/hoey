package com.cagnosolutions.starter.app.validators

import org.hibernate.validator.constraints.NotBlank

/**
 * Created by greg on 1/5/15.
 */
class RoomValidator {

	Long id

	@NotBlank(message = "Required field")
	String name

	@NotBlank(message = "Required field")
	String notes
}
