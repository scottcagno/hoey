package com.cagnosolutions.starter.app.job

import com.cagnosolutions.starter.app.company.CompanySession
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.servlet.mvc.support.RedirectAttributes

/**
 * Created by greg on 1/5/15.
 */

@CompileStatic
@Controller
@RequestMapping("/secure/job")
class AllJobsController {

	@Autowired
	CompanySession companySession

	@Autowired
	JobService jobService

	// GET view all jobs
	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model, @RequestParam(required = false) Integer page,
				   @RequestParam(required = false) String sort, RedirectAttributes attr) {
		if (!companySession.isComplete) {
			attr.addFlashAttribute("alertError", "The markup and labor rate field must be filled out")
			return "redirect:/secure/company"
		}
		def jobs = jobService.findAll(page? page-1 :0 , 10, sort?:"id")
		model.addAllAttributes([jobs: jobs])
		"job/all-jobs"
	}

	// GET view job from all jobs
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String viewJob(@PathVariable Long id, RedirectAttributes attr) {
		if (!companySession.isComplete) {
			attr.addFlashAttribute("alertError", "The markup and labor rate field must be filled out")
			return "redirect:/secure/company"
		}
		def customerId = jobService.findCustomerIdByJob(id)
		"redirect:/secure/customer/${customerId}/job/${id}"
	}
}
