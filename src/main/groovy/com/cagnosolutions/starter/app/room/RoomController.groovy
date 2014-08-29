package com.cagnosolutions.starter.app.room
import com.cagnosolutions.starter.app.item.Item
import com.cagnosolutions.starter.app.item.ItemService
import com.cagnosolutions.starter.app.job.Job
import com.cagnosolutions.starter.app.job.JobService
import com.cagnosolutions.starter.app.material.MaterialService
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
@Controller(value = "roomController")
@RequestMapping(value = "/secure/job/{jobId}/room")
class RoomController {

	@Autowired
	JobService jobService

	@Autowired
	RoomService roomService

	@Autowired
	MaterialService materialService

	@Autowired
	ItemService itemService

	// POST add/edit room
	@RequestMapping(method = RequestMethod.POST)
	String edit(@PathVariable Long jobId, Room room) {
		room.items = new ArrayList<Item>()
		if (room.id != null) {
			Room existingRoom = roomService.findOne(room.id)
			room.items = existingRoom.items
			room.total = existingRoom.total
			roomService.save(room)
		} else {
			Job job = jobService.findOne(jobId)
			job.addRoom(room)
			jobService.save(job)
		}
		"redirect:/secure/job/${jobId}"
	}

	// GET view room
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, @PathVariable Long jobId, Model model) {
		def room = roomService.findOne id
		model.addAllAttributes([room: room, job : jobService.findOne(jobId)])
		"job/job"
	}

	// GET add item
	@RequestMapping(value = "/{id}/additem", method = RequestMethod.GET)
	String items(@PathVariable Long id, @PathVariable Long jobId, Model model) {
		model.addAllAttributes([room : roomService.findOne(id), materials : materialService.findAll(), jobId : jobId])
		"room/materials"
	}

	// POST add/update item
	@RequestMapping(value = "/{roomId}/additem", method = RequestMethod.POST)
	String addItem(@PathVariable Long jobId, @PathVariable Long roomId, Item item, @RequestParam(required = false) Long materialId, RedirectAttributes attr) {
		if (item.id != null) {
			Item existingItem = itemService.findOne(item.id)
			item.material = existingItem.material
			itemService.save(item)
			attr.addFlashAttribute("alertSuccess", "Successfully updated item count")
			// TODO: change price update
			Job job = jobService.findOne(jobId)
			job.calcTotal()
			jobService.save(job)
			return "redirect:/secure/job/${jobId}/room/${roomId}"
		}
		Room room = roomService.findOne(roomId)
		item.material = materialService.findOne(materialId)
		item.total = item.count * item.material.price
		room.addItem(item)
		roomService.save(room)
		attr.addFlashAttribute("alertSuccess", "${item.count} ${item.material.name}(s) have been added to ${room.name}")
		// TODO: change price update
		Job job = jobService.findOne(jobId)
		job.calcTotal()
		jobService.save(job)
		"redirect:/secure/job/${jobId}/room/${roomId}/additem"
	}

	// POST delete item
	@RequestMapping(value = "/delitem/{itemId}", method = RequestMethod.POST)
	String delItem(@PathVariable Long jobId, @PathVariable Long itemId, RedirectAttributes attr) {
		itemService.delete(itemId)
		attr.addFlashAttribute("alertSuccess", "Successfully deleted item")
		"redirect:/secure/job/${jobId}"
	}

}
