package com.cagnosolutions.starter.app.job

import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Controller(value = "jobController")
@RequestMapping(value = "/secure/job")
class JobController {

	@Autowired
	JobService jobService

	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model) {
		model.addAttribute "jobs", jobService.findAll()
		"job/job"
	}

	@RequestMapping(method = RequestMethod.POST)
	String addOrEdit(Job job) {
		// TODO: add guts to add or edit
		"redirect:/secure/job"
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, Model model) {
		def job = jobService.findOne id
		model.addAllAttributes([job: job, jobs: jobService.findAll()])
		"job/job"
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	String delete(@PathVariable Long id) {
		jobService.delete id
		"redirect:/secure/job"
	}

}
