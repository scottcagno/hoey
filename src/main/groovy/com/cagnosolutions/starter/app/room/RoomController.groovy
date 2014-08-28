package com.cagnosolutions.starter.app.room
import com.cagnosolutions.starter.app.item.Item
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
@RequestMapping(value = "/secure/room")
class RoomController {

	@Autowired
	RoomService roomService

	@Autowired
	MaterialService materialService

	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model) {
		model.addAttribute "rooms", roomService.findAll()
		"room/room"
	}

	@RequestMapping(method = RequestMethod.POST)
	String edit(Room room) {
		room.items = new ArrayList<Item>()
		if (room.id != null) {
			Room existingRoom = roomService.findOne(room.id)
			room.items = existingRoom.items
		}
		roomService.save(room)
		"redirect:/secure/room/${room.id}"
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, Model model) {
		def room = roomService.findOne id
		model.addAllAttributes([room: room, rooms: roomService.findAll()])
		"room/room"
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	String delete(@PathVariable Long id) {
		roomService.delete id
		"redirect:/secure/room"
	}

	@RequestMapping(value = "/{id}/addItem", method = RequestMethod.GET)
	String items(@PathVariable Long id, Model model) {
		model.addAllAttributes([room : roomService.findOne(id), materials : materialService.findAll()])
		"room/materials"
	}


	@RequestMapping(value = "/{id}/addItem", method = RequestMethod.POST)
	String addItem(@PathVariable Long id, Item item, @RequestParam Long materialId, RedirectAttributes attr) {
		Room room = roomService.findOne(id)
		item.material = materialService.findOne(materialId)
		item.total = item.count * item.material.price
		room.addItem(item)
		roomService.save(room)
		attr.addFlashAttribute("alertSuccess", "${item.count} ${item.material.name}(s) have been added to ${room.name}")
		"redirect:/secure/room/${id}/addItem"
	}

}
