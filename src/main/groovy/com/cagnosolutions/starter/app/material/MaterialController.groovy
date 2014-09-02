package com.cagnosolutions.starter.app.material

import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RequestParam

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Controller(value = "materialController")
@RequestMapping(value = "/secure/material")
class MaterialController {

	@Autowired
	MaterialService materialService

	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model, @RequestParam String category, @RequestParam String sort) {
		if(category == null) {
			model.addAttribute("items", materialService.findAll());
		} else {
			model.addAttribute("items", materialService.findAllByCategory(category, sort));
		}
		model.addAllAttributes ([materials : materialService.findAll(), categories : materialService.getUniqueItemsByCategory()])
		"material/material"
	}

	@RequestMapping(method = RequestMethod.POST)
	String addOrEdit(Material material) {
		materialService.save(material)
		"redirect:/secure/material"
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, Model model) {
		def material = materialService.findOne id
		model.addAllAttributes([material: material, materials: materialService.findAll()])
		"material/material"
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	String delete(@PathVariable Long id) {
		materialService.delete id
		"redirect:/secure/material"
	}

}
