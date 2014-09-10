package com.cagnosolutions.starter.app.company

import com.cagnosolutions.starter.app.job.JobService
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.mvc.support.RedirectAttributes

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Controller(value = "companyController")
@RequestMapping(value = "/secure/company")
class CompanyController {

    @Autowired
    CompanyService companyService

    @Autowired
    JobService jobService

    @RequestMapping(method = RequestMethod.GET)
    String view(Model model) {
        model.addAllAttributes([company: companyService.findOne(), invoices: jobService.findAllInvoiced()])
        "company/company"
    }

    @RequestMapping(method = RequestMethod.POST)
    String edit(Company company, RedirectAttributes attr) {
        def current = companyService.findOne()
        mergeProperties(company, current)
        companyService.save current
        attr.addFlashAttribute("alertSuccess", "Information has successfully been updated!")
        "redirect:/secure/company"
    }

    // helper method
    def mergeProperties(source, target) {
        source.properties.each { key, value ->
            if (target.hasProperty(key as String) && !(key in ['class', 'metaClass']) && value != null)
                target[key as String] = value
        }
    }

}

