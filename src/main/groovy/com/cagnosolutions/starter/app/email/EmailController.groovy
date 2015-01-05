package com.cagnosolutions.starter.app.email

import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RequestParam

@CompileStatic
@Controller
@RequestMapping(value = "/email")
class EmailController {

	@Autowired
	EmailService emailService

	@RequestMapping(method = RequestMethod.GET)
	String email() {
		"email/email"
	}

	@RequestMapping(method = RequestMethod.POST)
	String sendEmail(@RequestParam String from, @RequestParam String to,
					 	@RequestParam String subject, @RequestParam String text) {
		emailService.send from, to, subject, text
		"redirect:/email"
	}

}
