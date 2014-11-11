package com.cagnosolutions.starter.app.customer

import com.cagnosolutions.starter.app.company.CompanyService
import com.cagnosolutions.starter.app.email.Email
import com.cagnosolutions.starter.app.email.EmailService
import com.cagnosolutions.starter.app.job.Job
import com.cagnosolutions.starter.app.job.JobService
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
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Controller(value = "customerController")
@RequestMapping(value = "/secure/customer")
class CustomerController {

	@Autowired
	CustomerService customerService

	@Autowired
	JobService jobService

	@Autowired
	EmailService emailService

    @Autowired
    CompanyService companyService

	// GET view all customers
	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model, @RequestParam(required = false) Integer page, @RequestParam(required = false) String sort) {
		def customers = customerService.findAll(page? page-1 :0 , 10, sort?:"id")
		model.addAllAttributes([customers: customers])
		"customer/allCustomers"
	}

	// POST add/edit customer
	@RequestMapping(method = RequestMethod.POST)
	String addOrEdit(Customer customer, RedirectAttributes attr) {
		customer.company = customer.company == "" ? "N/A" : customer.company
		if (customer.id != null) {
			Customer existingCustomer = customerService.findOne(customer.id)
			customer.jobs = existingCustomer.jobs
			customerService.save(customer)
			attr.addFlashAttribute("alertSuccess", "Successfully updated customer")
			return "redirect:/secure/customer/${customer.id}"
		} else {
			customer.jobs = new ArrayList<Job>()
		}
		customerService.save(customer)
		attr.addFlashAttribute("alertSuccess", "Successfully added customer")
		"redirect:/secure/customer"
	}

	// GET view customer
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, Model model) {
		def customer = customerService.findOne id
		model.addAllAttributes([customer: customer])
		"customer/customer"
	}

	// POST delete customer
	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	String delete(@PathVariable Long id, RedirectAttributes attr) {
		customerService.delete id
		attr.addFlashAttribute("alertSuccess", "Successfully deleted customer")
		"redirect:/secure/customer"
	}

	// POST add job
	@RequestMapping(value = "/{customerId}/addjob", method = RequestMethod.POST)
	String addJob(Job job, @PathVariable Long customerId) {
		Customer customer = customerService.findOne customerId
		job.created =  new Date()
		job.status = 0
		job.laborHours = 0D
		job.laborTotal = 0D
		job.total =  0D
		customer.addJob(job)
		if (job.name == "" || job.name == null) {
			job.name = "${customer.name}'s Job # ${customer.jobs.indexOf(job) + 1}"
		}
		customerService.save customer
		"redirect:/secure/customer/${customerId}"
	}

	// POST delete job
	@RequestMapping(value = "/{customerId}/deljob/{jobId}", method = RequestMethod.POST)
	String delJob(@PathVariable Long customerId, @PathVariable Long jobId, RedirectAttributes attr) {
		jobService.delete(jobId)
		attr.addFlashAttribute("alertSuccess", "Successfully deleted job")
		"redirect:/secure/customer/${customerId}"
	}

	// POST mail to customer
	@RequestMapping(value = "/{customerId}/mail", method = RequestMethod.POST)
	String mail(@PathVariable Long customerId, @RequestParam Long jobId, RedirectAttributes attr) {
		def job = jobService.findOne(jobId)
		def map = [job : job, customer : customerService.findOne(customerId), company: companyService.findOne()]
		Email email = emailService.CreateEmail("mail/mail.ftl", map)
		email.setAll("noreply@hoeynoreply.com", "Job Proposal", ((map.customer as Customer).email as String))
		emailService.sendEmailThreaded(email)
		job.status = 1
		jobService.save job
		attr.addFlashAttribute("alertSuccess", "Successfully emailed customer")
		"redirect:/secure/customer/${customerId}"
	}
}
