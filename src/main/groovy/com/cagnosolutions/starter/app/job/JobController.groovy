package com.cagnosolutions.starter.app.job
import com.cagnosolutions.starter.app.company.CompanyService
import com.cagnosolutions.starter.app.company.CompanySession
import com.cagnosolutions.starter.app.customer.Customer
import com.cagnosolutions.starter.app.customer.CustomerService
import com.cagnosolutions.starter.app.email.EmailService
import com.cagnosolutions.starter.app.room.RoomService
import com.cagnosolutions.starter.app.validators.JobValidator
import com.cagnosolutions.starter.app.validators.ValidationWrapper
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.validation.BindingResult
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.mvc.support.RedirectAttributes

import javax.validation.Valid

@CompileStatic
@Controller
@RequestMapping(value = "/secure/customer/{customerId}/job")
class JobController {

	@Autowired
	CompanyService companyService

	@Autowired
	CustomerService customerService

	@Autowired
	JobService jobService

	@Autowired
	RoomService roomService

	@Autowired
	EmailService emailService

	@Autowired
	CompanySession companySession

	@Autowired
	ValidationWrapper validationWrapper

	// GET view job
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, @PathVariable Long customerId, Model model, RedirectAttributes attr) {
		if (!companySession.isComplete) {
			attr.addFlashAttribute("alertError", "The markup and labor rate field must be filled out")
			return "redirect:/secure/company"
		}
		def job = jobService.findOne id
		if(companySession.update) {
			companySession.update = false
			job.updateTotals(companyService.findOne().markup, companyService.findOne().laborRate)
			job = jobService.save job
			model.addAttribute "alertSuccess", "Job total has been updated!"
		}
		model.addAllAttributes([job: job, jobs: jobService.findAll(), customeID : customerId])
		"job/job"
	}

	// POST edit job
	@RequestMapping(method = RequestMethod.POST)
	String edit(@PathVariable Long customerId, @Valid JobValidator jobValidator, BindingResult bindingResult,
				RedirectAttributes attr) {
		if (bindingResult.hasErrors()) {
			attr.addFlashAttribute("alertError", "There is an error in the form")
			attr.addFlashAttribute "errors", validationWrapper.bindErrors(bindingResult)
			attr.addFlashAttribute("job", jobValidator)
			return "redirect:/secure/customer/${customerId}/job/${jobValidator.id}"
		}
		def newJob = jobService.generateFromValidator jobValidator
		def job = jobService.findOne newJob.id
		jobService.mergeProperties(newJob, job)
		jobService.save job
		if(!companySession.update) companySession.update = true
		"redirect:/secure/customer/${customerId}/job/${job.id}"
	}

	// POST add labor
	@RequestMapping(value = "/labor", method = RequestMethod.POST)
	String labor(@PathVariable Long customerId, Long id, Double laborHours, RedirectAttributes attr) {
		if (laborHours == null || laborHours == "") {
			attr.addFlashAttribute("alertError", "Labor hours cannot be empty")
			return "redirect:/secure/customer/${customerId}/job/${id}"
		}
		def job = jobService.findOne id
		job.laborHours = laborHours
		jobService.save job
		attr.addFlashAttribute("alertSuccess", "Successfully updated labor hours")
		if(!companySession.update) companySession.update = true
		"redirect:/secure/customer/${customerId}/job/${id}"
	}

	// POST delete room
	@RequestMapping(value = "/{jobId}/delroom/{roomId}", method = RequestMethod.POST)
	String delRoom(@PathVariable Long customerId, @PathVariable Long jobId, @PathVariable Long roomId,
				   RedirectAttributes attr) {
		roomService.delete roomId
		attr.addFlashAttribute("alertSuccess", "Successfully deleted room")
		if(!companySession.update) companySession.update = true
		"redirect:/secure/customer/${customerId}/job/${jobId}"
	}

	// POST mail to customer
	@RequestMapping(value = "/{jobId}/mail", method = RequestMethod.POST)
	String mail(@PathVariable Long customerId, @PathVariable Long jobId, RedirectAttributes attr) {
		def job = jobService.findOne jobId
		def map = [job : job, customer : customerService.findOne(customerId)]
		emailService.send("Shock & Awe Electric <noreply@shockaweelectric.com>", (map.customer as Customer).email as String,
				"Job Proposal", job.textProposal(), "mail/mail.ftl", map)
		job.status = 1
		jobService.save job
		attr.addFlashAttribute("alertSuccess", "Successfully emailed customer")
		"redirect:/secure/customer/${customerId}/job/${jobId}"
	}
}
