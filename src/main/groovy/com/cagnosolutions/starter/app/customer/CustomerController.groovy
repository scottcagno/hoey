package com.cagnosolutions.starter.app.customer

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
@Controller(value = "customerController")
@RequestMapping(value = "/secure/customer")
class CustomerController {

    @Autowired
    CustomerService customerService

    @RequestMapping(method = RequestMethod.GET)
    String viewAll(Model model) {
        model.addAttribute "customers", customerService.findAll()
        "customer/customer"
    }

    @RequestMapping(method = RequestMethod.POST)
    String addOrEdit(Customer customer) {
        // TODO: add guts to add or edit
        "redirect:/secure/customer"
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    String view(@PathVariable Long id, Model model) {
        def customer = customerService.findOne id
        model.addAllAttributes([customer: customer, customers: customerService.findAll()])
        "customer/customer"
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    String delete(@PathVariable Long id) {
        customerService.delete id
        "redirect:/secure/customer"
    }

}
