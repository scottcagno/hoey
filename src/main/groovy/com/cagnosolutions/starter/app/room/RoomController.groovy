package com.cagnosolutions.starter.app.room

import com.cagnosolutions.starter.app.item.Item
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
@Controller(value = "roomController")
@RequestMapping(value = "/secure/room")
class RoomController {

	@Autowired
	RoomService roomService

	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model) {
		model.addAttribute "rooms", roomService.findAll()
		"room/room"
	}

	@RequestMapping(method = RequestMethod.POST)
	String addOrEdit(Room room) {
		room.items = new ArrayList<Item>()
		if (room.id != null) {
			Room existingRoom = roomService.findOne(room.id)
			room.items = existingRoom.items
		}
		roomService.save(room)
		"redirect:/secure/room"
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

}
