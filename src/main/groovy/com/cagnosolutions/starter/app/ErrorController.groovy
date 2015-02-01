package com.cagnosolutions.starter.app

import groovy.transform.CompileStatic
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.ExceptionHandler

@CompileStatic
@Controller
class ErrorController {

	@ExceptionHandler(value = [Exception.class, RuntimeException.class])
	static String errors(Exception e, Model model) {
		def stack = []
		for (frame in e.getStackTrace()) {
			stack << frame.toString()
		}
		model.addAllAttributes([message: e.getLocalizedMessage(), exception: stack.join('\n')])
		"error"
	}
}
