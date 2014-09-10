package com.cagnosolutions.starter.app.job

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

	@Autowired
	RoomService roomService

	// GET view all jobs
	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model, @RequestParam(required = false) Integer page,
				   @RequestParam(required = false) String sort) {

		def jobs = jobService.findAll(page? page-1 :0 , 20, sort?:"id")
		page = (page? page :1)
		def ub = (((jobs.totalPages - page) >= 4)? page + 4 : jobs.totalPages)
		if (page < 6) {
			ub = ((jobs.totalPages > 10)? 10 : ((jobs.totalPages > 0)? jobs.totalPages : 1))
		}
		def lb = (((ub - 9) > 0)? ub-9: 1)
		model.addAllAttributes([jobs: jobs, lb: lb, ub : ub])
		"job/allJobs"
	/*	model.addAttribute "jobs", jobService.findAll()
		"job/allJobs"*/
	}

	// POST edit job
	@RequestMapping(method = RequestMethod.POST)
	String edit(Job job) {
		job.rooms = new ArrayList<Room>()
		if (job.id !=null) {
			Job existingJob = jobService.findOne(job.id)
			job.rooms = existingJob.rooms
		}
		jobService.save job
		"redirect:/secure/job/${job.id}"
	}

	// GET view job
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(HttpSession session, @PathVariable Long id, Model model) {
		def job = jobService.findOne id
        if(session.getAttribute("update") != null) {
            session.removeAttribute("update")
            job.updateTotals()
            job = jobService.save job
            model.addAttribute "alertSuccess", "Job total has been updated!"
        }
		model.addAllAttributes([job: job, jobs: jobService.findAll()])
		"job/job"
	}

	// POST delete job
	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	String delete(@PathVariable Long id, RedirectAttributes attr) {
		jobService.delete id
		attr.addFlashAttribute "alertSuccess", "Job deleted successfully"
		"redirect:/secure/job"
	}

	// POST add room
	@RequestMapping(value = "/{id}/addroom", method = RequestMethod.POST)
	String addRoom(@PathVariable Long id, Room room) {
		Job job = jobService.findOne(id)
		job.addRoom(room)
		jobService.save(job)
		"redirect:/secure/job/${id}"
	}

	// POST delete room
	@RequestMapping(value = "/{jobId}/delroom/{roomId}", method = RequestMethod.POST)
	String delRoom(HttpSession session, @PathVariable Long jobId, @PathVariable Long roomId, RedirectAttributes attr) {
		roomService.delete(roomId)
		attr.addFlashAttribute("alertSuccess", "Successfully deleted room")
        if(session.getAttribute("update") == null) session.setAttribute "update", true
		"redirect:/secure/job/${jobId}"
	}

}
