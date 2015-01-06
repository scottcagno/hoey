package com.cagnosolutions.starter.app.room
import com.cagnosolutions.starter.app.company.CompanySession
import com.cagnosolutions.starter.app.item.Item
import com.cagnosolutions.starter.app.item.ItemService
import com.cagnosolutions.starter.app.job.Job
import com.cagnosolutions.starter.app.job.JobService
import com.cagnosolutions.starter.app.material.MaterialService
import com.cagnosolutions.starter.app.validators.RoomValidator
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
@RequestMapping(value = "/secure/customer/{customerId}/job/{jobId}/room")
class RoomController {

	@Autowired
	JobService jobService

	@Autowired
	RoomService roomService

	@Autowired
	MaterialService materialService

	@Autowired
	ItemService itemService

	@Autowired
	CompanySession companySession

	@Autowired
	ValidationWrapper validationWrapper

	// GET view room
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, @PathVariable Long jobId, @PathVariable Long customerId, Model model,
				RedirectAttributes attr) {
		if (!companySession.isComplete) {
			attr.addFlashAttribute("alertError", "The markup and labor rate field must be filled out")
			return "redirect:/secure/company"
		}
		def room = roomService.findOne id
		model.addAllAttributes([room: room, job : jobService.findOne(jobId), customerId : customerId])
		"job/job"
	}

	// POST add/edit room
	@RequestMapping(method = RequestMethod.POST)
	String edit(@PathVariable Long jobId, @PathVariable Long customerId, @Valid RoomValidator roomValidator,
				BindingResult bindingResult, RedirectAttributes attr) {
		if (bindingResult.hasErrors()) {
			attr.addFlashAttribute("alertError", "There is an error in the form")
			attr.addFlashAttribute("roomErrors", validationWrapper.bindErrors(bindingResult))
			attr.addFlashAttribute("room", roomValidator)
			return (roomValidator.id == null) ? "redirect:/secure/customer/${customerId}/job/${jobId}" :
					"redirect:/secure/customer/${customerId}/job/${jobId}/room/${roomValidator.id}"
		}
		def newRoom = roomService.generateFromValidator roomValidator
		if (newRoom.id != null) {
			def room = roomService.findOne newRoom.id
			roomService.mergeProperties(newRoom, room)
			roomService.save room
		} else {
			newRoom.items = new ArrayList<Item>()
			Job job = jobService.findOne jobId
			job.addRoom newRoom
			jobService.save job
		}
		"redirect:/secure/customer/${customerId}/job/${jobId}"
	}

	// GET add item
	@RequestMapping(value = "/{id}/additem", method = RequestMethod.GET)
	String items(@PathVariable Long id, @PathVariable Long jobId, @PathVariable Long customerId,
				 Model model, @RequestParam(required =false) String category,
				 @RequestParam(required = false) String field, RedirectAttributes attr) {
		if (!companySession.isComplete) {
			attr.addFlashAttribute("alertError", "The markup and labor rate field must be filled out")
			return "redirect:/secure/company"
		}
		def materials = []
		if(category == null || category == "") {
			materials = materialService.findAll()
		} else {
			materials = materialService.findAllByCategory category
		}
		if (field == null) { field = "id"}
		def sorted = materials.sort { it.getAt(field) }

		model.addAllAttributes([room : roomService.findOne(id), materials : sorted,
								categories : materialService.getUniqueItemsByCategory(),
								jobId : jobId, customerId : customerId])
		"room/materials"
	}

	// POST add item
	@RequestMapping(value = "/{roomId}/additem", method = RequestMethod.POST)
	String addItem(@PathVariable Long jobId, @PathVariable Long roomId, @PathVariable Long customerId,
				   Double count, Long materialId, RedirectAttributes attr) {
		if (count == null || count == 0 || count == "") {
			attr.addFlashAttribute("alertError", "Item count cannot be empty")
			return "redirect:/secure/customer/${customerId}/job/${jobId}/room/${roomId}/additem"
		}
		def room = roomService.findOne roomId
		def item = new Item([material: materialService.findOne(materialId), count: count])
		room.addItem item
		roomService.save room
		attr.addFlashAttribute "alertSuccess", "${item.count} ${item.material.name}(s) have been added to ${room.name}"
		if(!companySession.update) companySession.update = true
		"redirect:/secure/customer/${customerId}/job/${jobId}/room/${roomId}/additem"
	}

	// POST update item
	@RequestMapping(value = "/{roomId}/edititem", method = RequestMethod.POST)
	String editItem(@PathVariable Long jobId, @PathVariable Long roomId, @PathVariable Long customerId,
					Long materialId, Item newItem, RedirectAttributes attr) {
		if (newItem.id == null || newItem.count == null || newItem.count == 0 || newItem.count == "") {
            attr.addFlashAttribute "alertError", "Item count cannot be empty"
            return "redirect:/secure/customer/${customerId}/job/${jobId}/room/${roomId}"
		}
		def item = itemService.findOne newItem.id
		itemService.mergeProperties(newItem, item)
        itemService.save item
		if(!companySession.update) companySession.update = true
        "redirect:/secure/customer/${customerId}/job/${jobId}"
	}

	// POST delete item
	@RequestMapping(value = "/delitem/{itemId}", method = RequestMethod.POST)
	String delItem(@PathVariable Long jobId, @PathVariable Long itemId, @PathVariable Long customerId,
					 RedirectAttributes attr) {
		itemService.delete itemId
		attr.addFlashAttribute("alertSuccess", "Successfully deleted item")
		if(!companySession.update) companySession.update = true
        "redirect:/secure/customer/${customerId}/job/${jobId}"
	}

}
