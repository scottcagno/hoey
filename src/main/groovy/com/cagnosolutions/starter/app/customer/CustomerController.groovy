package com.cagnosolutions.starter.app.customer

import com.cagnosolutions.starter.app.job.Job
import com.cagnosolutions.starter.app.job.JobService
import com.cagnosolutions.starter.app.mail.MailService
import com.cagnosolutions.starter.app.room.Room
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
	MailService mailService

	// GET view all customers
	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model, @RequestParam(required = false) Integer page, @RequestParam(required = false) String sort) {

		def customers = customerService.findAll(page? page-1 :0 , 20, sort?:"id")
		page = (page? page :1)
		def ub = (((customers.totalPages - page) >= 4)? page + 4 : customers.totalPages)
		if (page < 6) {
			ub = ((customers.totalPages > 10)? 10 : ((customers.totalPages > 0)? customers.totalPages : 1))
		}
		def lb = (((ub - 9) > 0)? ub-9: 1)
		model.addAllAttributes([customers: customers, lb: lb, ub : ub])
		"customer/allCustomers"

		/*model.addAttribute "customers", customerService.findAll()
		"customer/allCustomers"*/
	}

	// POST add/edit customer
	@RequestMapping(method = RequestMethod.POST)
	String addOrEdit(Customer customer) {
		customer.jobs =  new ArrayList<Job>()
		if (customer.id != null) {
			Customer existingCustomer = customerService.findOne(customer.id)
			customer.jobs = existingCustomer.jobs
			customerService.save(customer)
			return "redirect:/secure/customer/${customer.id}"
		}
		customerService.save(customer)
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
	@RequestMapping(value = "/{id}/addjob", method = RequestMethod.POST)
	String addJob(Job job, @PathVariable Long id) {
		Customer customer = customerService.findOne(id)
		customer.addJob(job)
		customerService.save(customer)
		"redirect:/secure/customer/${id}"
	}

	// POST delete job
	@RequestMapping(value = "/{customerId}/deljob/{jobId}", method = RequestMethod.POST)
	String delJob(@PathVariable Long customerId, @PathVariable Long jobId, RedirectAttributes attr) {
		jobService.delete(jobId)
		attr.addFlashAttribute("alertSuccess", "Successfully deleted job")
		"redirect:/secure/customer/{customerId}"
	}

	// GET mail to customer
	@RequestMapping(value = "/{customerId}/mail", method = RequestMethod.POST)
	String mail(@PathVariable Long customerId, @RequestParam Long jobId, RedirectAttributes attr) {
		// TODO: change emailer
		def customer = customerService.findOne(customerId)
		def map = new HashMap()
		def job = jobService.findOne(jobId)
		List<Room> rooms = job.rooms
		map.put("job", job)
		map.put("allRooms", rooms)
		mailService.test("test@noreplyhoey.com", "Job quote", "mail/mail.ftl", map, customer.email)
		attr.addFlashAttribute("alertSuccess", "Successfully emailed customer")
		"redirect:/secure/customer/${customerId}"
	}
}
