package com.cagnosolutions.starter.app.customer
import com.cagnosolutions.starter.app.company.CompanyService
import com.cagnosolutions.starter.app.company.CompanySession
import com.cagnosolutions.starter.app.email.EmailService
import com.cagnosolutions.starter.app.job.Job
import com.cagnosolutions.starter.app.job.JobService
import com.cagnosolutions.starter.app.validators.CustomerValidator
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
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.servlet.mvc.support.RedirectAttributes

import javax.validation.Valid

@CompileStatic
@Controller
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

	@Autowired
	CompanySession companySession

	@Autowired
	ValidationWrapper validationWrapper

	// GET view all customers
	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model, @RequestParam(required = false) Integer page,
				   @RequestParam(required = false) String sort, RedirectAttributes attr) {
		if (!companySession.isComplete) {
			attr.addFlashAttribute("alertError", "The markup and labor rate field must be filled out")
			return "redirect:/secure/company"
		}
		def customers = customerService.findAll(page? page-1 :0 , 10, sort?:"id")
		model.addAllAttributes([customers: customers])
		"customer/all-customers"
	}

	// POST add/edit customer
	@RequestMapping(method = RequestMethod.POST)
	String addOrEdit(@Valid CustomerValidator customerValidator, BindingResult bindingResult,RedirectAttributes attr) {
		if (bindingResult.hasErrors()) {
			attr.addFlashAttribute("alertError", "There is an error in the form")
			attr.addFlashAttribute "errors", validationWrapper.bindErrors(bindingResult)
			attr.addFlashAttribute("customer", customerValidator)
			return (customerValidator.id == null) ? "redirect:/secure/customer" : "redirect:/secure/customer/${customerValidator.id}"
		}
		def newCustomer = customerService.generateFromValidator customerValidator
		newCustomer.company = newCustomer.company == "" ? "N/A" : newCustomer.company
		if (newCustomer.id != null) {
			Customer customer = customerService.findOne newCustomer.id
			customerService.mergeProperties(newCustomer, customer)
			customerService.save customer
			attr.addFlashAttribute("alertSuccess", "Successfully updated customer")
			return "redirect:/secure/customer/${customer.id}"
		}
		newCustomer.jobs = new ArrayList<Job>()
		customerService.save newCustomer
		attr.addFlashAttribute("alertSuccess", "Successfully added customer")
		"redirect:/secure/customer"
	}

	// GET view customer
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, Model model, RedirectAttributes attr) {
		if (!companySession.isComplete) {
			attr.addFlashAttribute("alertError", "The markup and labor rate field must be filled out")
			return "redirect:/secure/company"
		}
		model.addAllAttributes([customer: customerService.findOne(id)])
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
	String addJob(@Valid JobValidator jobValidator, BindingResult bindingResult,@PathVariable Long customerId, RedirectAttributes attr) {
		if (bindingResult.hasErrors()) {
			attr.addFlashAttribute("alertError", "There is an error in the form")
			attr.addFlashAttribute "jobErrors", validationWrapper.bindErrors(bindingResult)
			attr.addFlashAttribute("job", jobValidator)
			return "redirect:/secure/customer/${customerId}"
		}
		def customer = customerService.findOne customerId
		def job = jobService.generateFromValidator jobValidator
		job.created =  new Date()
		job.status = 0
		job.laborHours = 0D
		job.laborTotal = 0D
		job.total =  0D
		customer.addJob job
		customerService.save customer
		"redirect:/secure/customer/${customerId}"
	}

	// POST delete job
	@RequestMapping(value = "/{customerId}/deljob/{jobId}", method = RequestMethod.POST)
	String delJob(@PathVariable Long customerId, @PathVariable Long jobId, RedirectAttributes attr) {
		jobService.delete jobId
		attr.addFlashAttribute("alertSuccess", "Successfully deleted job")
		"redirect:/secure/customer/${customerId}"
	}

	// POST mail to customer
	@RequestMapping(value = "/{customerId}/mail", method = RequestMethod.POST)
	String mail(@PathVariable Long customerId, @RequestParam Long jobId, RedirectAttributes attr) {
		def job = jobService.findOne jobId
		def map = [job : job, customer : customerService.findOne(customerId)]
		emailService.send("Shock & Awe Electric <noreply@shockaweelectric.com>", (map.customer as Customer).email as String,
				"Job Proposal", job.textProposal(), "mail/mail.ftl", map)
		job.status = 1
		jobService.save job
		attr.addFlashAttribute("alertSuccess", "Successfully emailed customer")
		"redirect:/secure/customer/${customerId}"
	}
}
