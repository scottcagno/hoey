package com.cagnosolutions.starter.app.material

import com.cagnosolutions.starter.app.item.ItemService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.servlet.mvc.support.RedirectAttributes

@Controller
@RequestMapping(value = "/secure/material")
class MaterialController {

	@Autowired
	MaterialService materialService

	@Autowired
	ItemService itemService

	// GET view all materials
	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model, @RequestParam(required =false) String category, @RequestParam(required = false) String field) {
		def materials = []
		if(category == null || category == "") {
			materials = materialService.findAll()
		} else {
			materials = materialService.findAllByCategory(category)
		}
		if (field == null) { field = "id"}
		def sorted = materials.sort { it.getAt(field) }

		model.addAllAttributes ([materials : sorted, categories : materialService.getUniqueItemsByCategory()])
		"material/material"
	}

	// POST add/edit material
	@RequestMapping(method = RequestMethod.POST)
	String addOrEdit(Material material, RedirectAttributes attr) {
		material.markup = material.markup == null ? false : material.markup
		material.taxed = material.taxed == null ? false : material.taxed
		materialService.save(material)
		attr.addFlashAttribute("alertSuccess", "Material Updated successfully")
		"redirect:/secure/material"
	}

	// GET view material
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, Model model,  @RequestParam(required =false) String category, @RequestParam(required = false) String field) {
		def material = materialService.findOne id
		def materials = []
		if(category == null) {
			materials = materialService.findAll()
		} else {
			materials = materialService.findAllByCategory(category)
		}
		if (field == null) { field = "id"}
		def sorted = materials.sort { it.getAt(field) }
		model.addAllAttributes ([material: material, materials : sorted, categories : materialService.getUniqueItemsByCategory()])
		"material/material"
	}

	// POST delete material
	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	String delete(@PathVariable Long id, RedirectAttributes attr) {
		if (itemService.exists(id)) {
			attr.addFlashAttribute("alertError", "Material is still in use by an item and cannot be removed")
		} else {
			materialService.delete id
			attr.addFlashAttribute("alertSuccess", "Deleted material successfully")
		}
		"redirect:/secure/material"
	}

}
