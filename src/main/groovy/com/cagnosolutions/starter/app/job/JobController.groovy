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
import org.springframework.web.servlet.mvc.support.RedirectAttributes

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
	RoomService roomservice

	// GET view all jobs
	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model) {
		model.addAttribute "jobs", jobService.findAll()
		"job/allJobs"
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
	String view(@PathVariable Long id, Model model) {
		def job = jobService.findOne id
		model.addAllAttributes([job: job, jobs: jobService.findAll()])
		"job/job"
	}

	// POST delete job
	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	String delete(@PathVariable Long id, RedirectAttributes attr) {
		jobService.delete id
		attr.addFlashAttribute("alertSuccess", "Job deleted successfully")
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
	String delRoom(@PathVariable Long jobId, @PathVariable Long roomId, RedirectAttributes attr) {
		roomservice.delete(roomId)
		attr.addFlashAttribute("alertSuccess", "Successfully deleted room")
		"redirect:/secure/job/${jobId}"
	}


	// POST temp handler to calculate all totals from job down
	@RequestMapping(value = "/calc", method = RequestMethod.GET)
	String calcTotals(RedirectAttributes attr) {
		List<Job> jobs = jobService.findAll()
		jobs.collect { Job job ->
			job.calcTotal()
			jobService.save(job)

		}
		attr.addFlashAttribute("alertSuccess", "Totals Calculated")
		"redirect:/secure/job"
	}

}
