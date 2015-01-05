package com.cagnosolutions.starter.app.email

import com.cagnosolutions.starter.app.company.CompanyService
import com.cagnosolutions.starter.app.customer.CustomerService
import com.cagnosolutions.starter.app.job.JobService
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RequestParam

@CompileStatic
@Controller
@RequestMapping(value = "/email")
class EmailController {

	@Autowired
	EmailService emailService

	@Autowired
	CompanyService companyService

	@Autowired
	CustomerService customerService

	@Autowired
	JobService jobService

	@RequestMapping(method = RequestMethod.GET)
	String showEmail(Model model) {
		model.addAllAttributes([company:companyService.findOne(),customer:customerService.findOne(11L),job:jobService.findOne(51L)])
		"mail/mail"
	}

	@RequestMapping(method = RequestMethod.POST)
	String sendEmail(@RequestParam String from, @RequestParam String to,
					 	@RequestParam String subject, @RequestParam String text) {
		emailService.send from, to, subject, text
		"redirect:/email"
	}

}
