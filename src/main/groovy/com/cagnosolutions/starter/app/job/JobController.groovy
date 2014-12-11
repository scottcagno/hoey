package com.cagnosolutions.starter.app.job

import com.cagnosolutions.starter.app.company.CompanyService
import com.cagnosolutions.starter.app.customer.Customer
import com.cagnosolutions.starter.app.customer.CustomerService
import com.cagnosolutions.starter.app.email.Email
import com.cagnosolutions.starter.app.email.EmailService
import com.cagnosolutions.starter.app.room.Room
import com.cagnosolutions.starter.app.room.RoomService
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.servlet.mvc.support.RedirectAttributes

import javax.servlet.http.HttpSession

@CompileStatic
@Controller
@RequestMapping(value = "/secure")
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

	// GET view all jobs
	@RequestMapping(value = "/job", method = RequestMethod.GET)
	String viewAll(Model model, @RequestParam(required = false) Integer page,
				   @RequestParam(required = false) String sort) {

		def jobs = jobService.findAll(page? page-1 :0 , 10, sort?:"id")
		model.addAllAttributes([jobs: jobs])
		"job/all-jobs"
	}

	// POST edit job
	@RequestMapping(value = "/customer/{customerId}/job", method = RequestMethod.POST)
	String edit(@PathVariable Long customerId, Job job, HttpSession session) {
		job.name = job.name == "" ? null : job.name
		if (job.id != null) {
			Job existingJob = jobService.findOne(job.id)
			jobService.mergeProperties(job, existingJob)
			jobService.save existingJob
			if(session.getAttribute("update") == null) session.setAttribute "update", true
		}
		"redirect:/secure/customer/${customerId}/job/${job.id}"
	}

	// GET view job
	@RequestMapping(value = "/customer/{customerId}/job/{id}", method = RequestMethod.GET)
	String view(HttpSession session, @PathVariable Long id, @PathVariable Long customerId, Model model) {
		def job = jobService.findOne id
        if(session.getAttribute("update") != null) {
            session.removeAttribute("update")
            job.updateTotals(companyService.findOne().markup, companyService.findOne().laborRate)
            job = jobService.save job
            model.addAttribute "alertSuccess", "Job total has been updated!"
        }
		model.addAllAttributes([job: job, jobs: jobService.findAll(), customeID : customerId])
		"job/job"
	}

	// GET view job from all jobs
	@RequestMapping(value = "/job/{id}", method = RequestMethod.GET)
	String viewJob(@PathVariable Long id) {
		def customerId = jobService.findCustomerIdByJob(id)
		"redirect:/secure/customer/${customerId}/job/${id}"
	}

	// POST delete job
	@RequestMapping(value = "/job/{id}", method = RequestMethod.POST)
	String delete(@PathVariable Long id, RedirectAttributes attr) {
		jobService.delete id
		attr.addFlashAttribute "alertSuccess", "Job deleted successfully"
		"redirect:/secure/job"
	}

	// POST add room
	@RequestMapping(value = "/customer/{customerId}/job/{jobId}/addroom", method = RequestMethod.POST)
	String addRoom(@PathVariable Long jobId, @PathVariable Long customerId, Room room) {
		Job job = jobService.findOne(jobId)
		job.addRoom(room)
		jobService.save(job)
		"redirect:/secure/customer/${customerId}/job/${jobId}"
	}

	// POST delete room
	@RequestMapping(value = "/customer/{customerId}/job/{jobId}/delroom/{roomId}", method = RequestMethod.POST)
	String delRoom(@PathVariable Long jobId, @PathVariable Long roomId, @PathVariable Long customerId,
				   HttpSession session, RedirectAttributes attr) {
		roomService.delete(roomId)
		attr.addFlashAttribute("alertSuccess", "Successfully deleted room")
        if(session.getAttribute("update") == null) session.setAttribute "update", true
		"redirect:/secure/customer/${customerId}/job/${jobId}"
	}

	// POST mail to customer
	@RequestMapping(value = "/customer/{customerId}/job/{jobId}/mail", method = RequestMethod.POST)
	String mail(@PathVariable Long customerId, @PathVariable Long jobId, RedirectAttributes attr) {
		def job = jobService.findOne(jobId)
		def map = [job : job, customer : customerService.findOne(customerId), company: companyService.findOne()]
		Email email = emailService.CreateEmail("mail/mail.ftl", map)
		email.setAll("noreply@hoeynoreply.com", "Job Quote", ((map.customer as Customer).email as String))
		emailService.sendEmail(email)
		job.status = 1
		jobService.save job
		attr.addFlashAttribute("alertSuccess", "Successfully emailed customer")
		"redirect:/secure/customer/${customerId}/job/${jobId}"
	}
}
