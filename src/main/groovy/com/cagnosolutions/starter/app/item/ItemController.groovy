package com.cagnosolutions.starter.app.item

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
@Controller(value = "itemController")
@RequestMapping(value = "/secure/item")
class ItemController {

    @Autowired
    ItemService itemService

    @RequestMapping(method = RequestMethod.GET)
    String viewAll(Model model) {
        model.addAttribute "items", itemService.findAll()
        "item/item"
    }

    @RequestMapping(method = RequestMethod.POST)
    String addOrEdit(Item item) {
        // TODO: add guts to add or edit
        "redirect:/secure/item"
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    String view(@PathVariable Long id, Model model) {
        def item = itemService.findOne id
        model.addAllAttributes([item: item, items: itemService.findAll()])
        "item/item"
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    String delete(@PathVariable Long id) {
        itemService.delete id
        "redirect:/secure/item"
    }

}
