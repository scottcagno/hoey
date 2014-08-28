package com.cagnosolutions.starter.app.room
import com.cagnosolutions.starter.app.item.Item
import com.cagnosolutions.starter.app.item.ItemService
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

	@Autowired
	ItemService itemService

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

	@RequestMapping(value = "/{id}/additem", method = RequestMethod.GET)
	String items(@PathVariable Long id, Model model) {
		model.addAllAttributes([room : roomService.findOne(id), materials : materialService.findAll()])
		"room/materials"
	}


	@RequestMapping(value = "/{id}/additem", method = RequestMethod.POST)
	String addItem(@PathVariable Long id, Item item, @RequestParam(required = false) Long materialId, RedirectAttributes attr) {
		if (item.id != null) {
			Item existingItem = itemService.findOne(item.id)
			item.material = existingItem.material
			itemService.save(item)
			attr.addFlashAttribute("alertSuccess", "Successfully updated item count")
			return "redirect:/secure/room/${id}"
		}
		Room room = roomService.findOne(id)
		item.material = materialService.findOne(materialId)
		item.total = item.count * item.material.price
		room.addItem(item)
		roomService.save(room)
		attr.addFlashAttribute("alertSuccess", "${item.count} ${item.material.name}(s) have been added to ${room.name}")
		"redirect:/secure/room/${id}/additem"
	}

	@RequestMapping(value = "/{roomId}/delitem/{itemId}", method = RequestMethod.POST)
	String delItem(@PathVariable Long roomId, @PathVariable Long itemId, RedirectAttributes attr) {
		itemService.delete(itemId)
		attr.addFlashAttribute("alertSuccess", "Successfully deleted item")
		"redirect:/secure/room/${roomId}"
	}

}
