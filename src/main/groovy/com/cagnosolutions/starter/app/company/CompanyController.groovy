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
    String edit(Company company, RedirectAttributes attr) {
        def current = companyService.findOne()
		if (current == null) {
			companyService.save company
		} else {
			mergeProperties(company, current)
            if (current.password[0] != '$') {
                current.password = new BCryptPasswordEncoder().encode(current.password)
            }
			companyService.save current
		}
        companySession.isComplete = companyService.isComplete()
        attr.addFlashAttribute("alertSuccess", "Information has successfully been updated!")
        "redirect:/secure/company"
    }

    // helper method
    def mergeProperties(source, target) {
        source.properties.each { key, value ->
            if (target.hasProperty(key as String) && !(key in ['class', 'metaClass']) && value != null && value != ""   )
                target[key as String] = value
        }
    }

}

