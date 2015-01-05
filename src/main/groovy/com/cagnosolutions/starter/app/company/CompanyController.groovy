package com.cagnosolutions.starter.app.company

import com.cagnosolutions.starter.app.job.JobService
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.mvc.support.RedirectAttributes

@CompileStatic
@Controller
@RequestMapping(value = "/secure/company")
class CompanyController {

    @Autowired
    CompanyService companyService

    @Autowired
    JobService jobService

    @Autowired
    CompanySession companySession

    @RequestMapping(method = RequestMethod.GET)
    String view(Model model) {
        model.addAllAttributes([company: companyService.findOne(), invoices: jobService.findAllInvoiced()])
        "company/company"
    }

    @RequestMapping(method = RequestMethod.POST)
    String edit(Company newCompany, RedirectAttributes attr) {
        def company = companyService.findOne()
		if (company == null) {
			companyService.save newCompany
		} else {
			companyService.mergeProperties(newCompany, company)
            if (company.password[0] != '$') {
                company.password = new BCryptPasswordEncoder().encode(company.password)
            }
			companyService.save company
		}
        companySession.isComplete = companyService.isComplete()
        attr.addFlashAttribute("alertSuccess", "Information has successfully been updated!")
        "redirect:/secure/company"
    }



}

