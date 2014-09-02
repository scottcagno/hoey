package com.cagnosolutions.starter.app.material

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

@Controller(value = "materialController")
@RequestMapping(value = "/secure/material")
class MaterialController {

	@Autowired
	MaterialService materialService

	@RequestMapping(method = RequestMethod.GET)
	String viewAll(Model model, @RequestParam(required =false) String category, @RequestParam(required = false) String field) {
		def materials = []
		if(category == null)
			materials = materialService.findAll()
		else
			materials = materialService.findAllByCategory(category)
        if(field == null) {
            field = "id"
        }
        def sorted = materials.sort {
            it.getAt(field)
        }
		model.addAllAttributes ([materials : sorted, categories : materialService.getUniqueItemsByCategory()])
		"material/material"
	}

	@RequestMapping(method = RequestMethod.POST)
	String addOrEdit(Material material) {
		materialService.save(material)
		"redirect:/secure/material"
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	String view(@PathVariable Long id, Model model,  @RequestParam(required =false) String category, @RequestParam(required = false) String field) {
		def material = materialService.findOne id
		def materials = []
		if(category == null)
			materials = materialService.findAll()
		else
			materials = materialService.findAllByCategory(category)
        if(field == null) {
            field = "id"
        }
        def sorted = materials.sort {
            it.getAt(field)
        }
		model.addAllAttributes ([material: material, materials : sorted, categories : materialService.getUniqueItemsByCategory()])
		"material/material"
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	String delete(@PathVariable Long id) {
		materialService.delete id
		"redirect:/secure/material"
	}

}
