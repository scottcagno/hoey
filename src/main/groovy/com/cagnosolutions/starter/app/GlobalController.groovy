package com.cagnosolutions.starter.app

import com.cagnosolutions.starter.app.customer.CustomerService
import com.cagnosolutions.starter.app.user.UserService
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.*
import javax.servlet.http.HttpSession
import java.security.Principal

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Controller(value = "emailController")
class EmailController {

    @Autowired
    CustomerService customerService

    @RequestMapping(value = "/email/{id}", method = RequestMethod.GET)
    String mail(Model model, @PathVariable Long id) {
        def cust = customerService.findOne id
        model.addAllAttributes([customer: cust, job: cust.jobs.first()])
        "mail/mail"
    }

}

@CompileStatic
@Controller(value = "indexController")
class IndexController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	String index() {
		"index"
	}

    @RequestMapping(value = "/speech", method = RequestMethod.GET)
    String speech() {
        "asr-speech"
    }

}

@CompileStatic
@Controller(value = "authController")
class Authentication {

	@Autowired
	UserService userService

	@RequestMapping(value = "/login")
	String login() {
		"login"
	}

	@RequestMapping(value = "/secure/login", method = RequestMethod.GET)
	String secureLogin(@RequestParam String forward, HttpSession session, Principal principal) {
		if(principal.name != "admin") {
			def user = userService.findOne principal.name
			user.lastSeen = System.currentTimeMillis()
			userService.save user
		}
		session.setAttribute "authenticated", principal.name
		"redirect:/secure/$forward"
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
