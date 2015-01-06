package com.cagnosolutions.starter.app.company

import com.cagnosolutions.starter.app.validators.CompanyValidator
import com.cagnosolutions.starter.app.validators.ValidationWrapper
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.validation.BindingResult
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.mvc.support.RedirectAttributes

import javax.validation.Valid

@CompileStatic
@Controller
@RequestMapping(value = "/secure/company")
class CompanyController {

    @Autowired
    CompanyService companyService

    @Autowired
    CompanySession companySession

    @Autowired
    ValidationWrapper validationWrapper

    @RequestMapping(method = RequestMethod.GET)
    String view(Model model) {
        if (!model.containsAttribute("company")) {
            model.addAllAttributes([company: companyService.findOne()])
        }
        "company/company"
    }

    @RequestMapping(method = RequestMethod.POST)
    String edit(@Valid CompanyValidator companyValidator, BindingResult bindingResult,RedirectAttributes attr) {
        if (bindingResult.hasErrors()) {
            attr.addFlashAttribute("alertError", "There is an error in the form")
            attr.addFlashAttribute "errors", validationWrapper.bindErrors(bindingResult)
            attr.addFlashAttribute("company", companyValidator)
            return "redirect:/secure/company"
        }
        def newCompany = companyService.generateFromValidator companyValidator
        def company = companyService.findOne()
		if (company == null) {
			companyService.save newCompany
		} else {
            newCompany.password = (newCompany.password == "") ? null : newCompany.password
			companyService.mergeProperties(newCompany, company)
            if (company.password[0] != '$') {
                company.password = new BCryptPasswordEncoder().encode company.password
            }
			companyService.save company
		}
        companySession.isComplete = companyService.isComplete()
        attr.addFlashAttribute("alertSuccess", "Information has successfully been updated!")
        "redirect:/secure/company"
    }
}

