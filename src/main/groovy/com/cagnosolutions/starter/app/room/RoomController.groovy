package com.cagnosolutions.starter.app.room
import com.cagnosolutions.starter.app.item.Item
import com.cagnosolutions.starter.app.item.ItemService
import com.cagnosolutions.starter.app.job.Job
import com.cagnosolutions.starter.app.job.JobService
import com.cagnosolutions.starter.app.material.MaterialService
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

	// GET view room
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, @PathVariable Long jobId, Model model) {
		def room = roomService.findOne id
		model.addAllAttributes([room: room, job : jobService.findOne(jobId)])
		"job/job"
	}

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

	// GET add item
	@RequestMapping(value = "/{id}/additem", method = RequestMethod.GET)
	String items(@PathVariable Long id, @PathVariable Long jobId,
				 Model model, @RequestParam(required =false) String category,
				 @RequestParam(required = false) String field) {
		def materials = []
		if(category == null || category == "") {
			materials = materialService.findAll()
		} else {
			materials = materialService.findAllByCategory(category)
		}
		if (field == null) { field = "id"}
		def sorted = materials.sort { it.getAt(field) }

		model.addAllAttributes([room : roomService.findOne(id), materials : sorted,
								categories : materialService.getUniqueItemsByCategory(), jobId : jobId])
		"room/materials"
	}

	// POST update item
	@RequestMapping(value = "/{roomId}/edititem", method = RequestMethod.POST)
	String editItem(HttpSession session, @PathVariable Long jobId, @PathVariable Long roomId, Long materialId, Item item, RedirectAttributes attr) {
		if (item.id == null) {
            attr.addFlashAttribute "alertError", "Could not update item count"
            return "redirect:/secure/job/${jobId}/room/${roomId}"
		}
        item.material = materialService.findOne materialId
        item.updateTotal()
        itemService.save item
        if(session.getAttribute("update") == null) session.setAttribute "update", true
        "redirect:/secure/job/${jobId}"
	}

    // POST add item
    @RequestMapping(value = "/{roomId}/additem", method = RequestMethod.POST)
    String addItem(HttpSession session, @PathVariable Long jobId, @PathVariable Long roomId, Double count, Long materialId, RedirectAttributes attr) {
        def room = roomService.findOne(roomId)
        def item = new Item([material: materialService.findOne(materialId), count: count])
        item.updateTotal()
        room.addItem item
        roomService.save room
        attr.addFlashAttribute "alertSuccess", "${item.count} ${item.material.name}(s) have been added to ${room.name}"
        if(session.getAttribute("update") == null) session.setAttribute "update", true
        "redirect:/secure/job/${jobId}/room/${roomId}/additem"
    }

	// POST delete item
	@RequestMapping(value = "/delitem/{itemId}", method = RequestMethod.POST)
	String delItem(HttpSession session, @PathVariable Long jobId, @PathVariable Long itemId, RedirectAttributes attr) {
		itemService.delete(itemId)
		attr.addFlashAttribute("alertSuccess", "Successfully deleted item")
        if(session.getAttribute("update") == null) session.setAttribute "update", true
        "redirect:/secure/job/${jobId}"
	}

}
