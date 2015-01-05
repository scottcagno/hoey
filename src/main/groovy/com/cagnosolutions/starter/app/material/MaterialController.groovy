package com.cagnosolutions.starter.app.material

import com.cagnosolutions.starter.app.company.CompanySession
import com.cagnosolutions.starter.app.item.ItemService
import com.cagnosolutions.starter.app.validators.MaterialValidator
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
@RequestMapping(value = "/secure/material")
class MaterialController {

	@Autowired
	MaterialService materialService

	@Autowired
	ItemService itemService

	@Autowired
	CompanySession companySession

	@Autowired
	ValidationWrapper validationWrapper

	// GET view all materials
	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model, @RequestParam(required =false) String category,
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

		model.addAllAttributes ([materials : sorted, categories : materialService.getUniqueItemsByCategory()])
		"material/material"
	}

	// GET view material
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, Model model,  @RequestParam(required =false) String category,
				@RequestParam(required = false) String field, RedirectAttributes attr) {
		if (!companySession.isComplete) {
			attr.addFlashAttribute("alertError", "The markup and labor rate field must be filled out")
			return "redirect:/secure/company"
		}
		def material = materialService.findOne id
		def materials = []
		if(category == null) {
			materials = materialService.findAll()
		} else {
			materials = materialService.findAllByCategory category
		}
		if (field == null) { field = "id"}
		def sorted = materials.sort { it.getAt(field) }
		model.addAllAttributes ([material: material, materials : sorted, categories : materialService.getUniqueItemsByCategory()])
		"material/material"
	}

	// POST add/edit material
	@RequestMapping(method = RequestMethod.POST)
	String addOrEdit(@Valid MaterialValidator materialValidator, BindingResult bindingResult, RedirectAttributes attr) {
		if (bindingResult.hasErrors()) {
			attr.addFlashAttribute("alertError", "There is an error in the form")
			attr.addFlashAttribute "errors", validationWrapper.bindErrors(bindingResult)
			attr.addFlashAttribute("material", materialValidator)
			return (materialValidator.id == null) ? "redirect:/secure/material" :
					"redirect:/secure/material/${materialValidator.id}"
		}
		def material = materialService.generateFromValidator materialValidator
		material.markup = material.markup == null ? false : material.markup
		material.taxed = material.taxed == null ? false : material.taxed
		materialService.save material
		attr.addFlashAttribute("alertSuccess", "Material Updated successfully")
		"redirect:/secure/material"
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
