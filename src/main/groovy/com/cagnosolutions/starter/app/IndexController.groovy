package com.cagnosolutions.starter.app

import com.cagnosolutions.starter.app.company.CompanyService
import com.cagnosolutions.starter.app.company.CompanySession
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.mvc.support.RedirectAttributes

@CompileStatic
@Controller
class IndexController {

	@Autowired
	CompanyService companyService

	@Autowired
	CompanySession companySession

	@RequestMapping(value = "/", method = RequestMethod.GET)
	String index() {
		"index"
	}

	@RequestMapping(value = "/login")
	String login() {
		"login"
	}

	@RequestMapping(value = ["/home", "/index"], method = RequestMethod.GET)
	String indexRedirect() {
		"redirect:/"
	}

	@RequestMapping(value = "/login/success", method = RequestMethod.GET)
	String customLoginSuccessHandler(String redirect, RedirectAttributes attr) {
		companySession.update = false
		if (companyService.isComplete()) {
			companySession.isComplete = true
			return "redirect:${redirect}"
		}
		attr.addFlashAttribute("alertError", "The markup and labor rate field must be filled out")
		companySession.isComplete = false
		"redirect:/secure/company"
	}

}
