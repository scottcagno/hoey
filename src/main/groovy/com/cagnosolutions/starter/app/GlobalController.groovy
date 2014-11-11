package com.cagnosolutions.starter.app
import groovy.transform.CompileStatic
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod

@CompileStatic
@Controller(value = "indexController")
class IndexController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	String root() {
		"index"
	}

	@RequestMapping(value = ["/home", "/index"], method = RequestMethod.GET)
	String index() {
		"redirect:/"
	}

}

@CompileStatic
@Controller(value = "authController")
class Authentication {

	@RequestMapping(value = "/login")
	String login() {
		"login"
	}
}

@CompileStatic
@Controller(value = "errorController")
class ErrorHandler {

	@ExceptionHandler(value = [Exception.class, RuntimeException.class])
	String errors(Exception e, Model model) {
		def stack = []
		for (frame in e.getStackTrace()) {
			stack << frame.toString()
		}
		model.addAllAttributes([message: e.getLocalizedMessage(), exception: stack.join('\n')])
		"error"
	}
}
