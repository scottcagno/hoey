package com.cagnosolutions.starter.app.user

import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
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
@Controller(value = "userController")
@RequestMapping(value = "/secure/user")
class UserController {

    @Autowired
    UserService userService

    @RequestMapping(method = RequestMethod.GET)
    String viewAll(Model model) {
        model.addAttribute "users", userService.findAll()
        "user/user"
    }

    @RequestMapping(method = RequestMethod.POST)
    String addOrEdit(User user, RedirectAttributes attr) {
        if(userService.canUpdate(user.id, user.username)) {
            if(user.id == null || user.password[0] != '$')
                user.password = new BCryptPasswordEncoder().encode(user.password)
            userService.save user
            attr.addFlashAttribute "alertSuccess", "Successfully saved user ${user.name}"
            return "redirect:/secure/user/${user.id}"
        }
        attr.addFlashAttribute "alertError", "Unable to save user ${user.name}"
        "redirect:/secure/user"
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    String view(@PathVariable Long id, Model model, @RequestParam(required = false) Boolean active) {
        def user = userService.findOne id
        if(active != null) {
            user.active = (active) ? 1 as short : 0 as short
            userService.save user
        }
        model.addAllAttributes([user: user, users: userService.findAll()])
        "user/user"
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    String delete(@PathVariable Long id) {
        userService.delete id
        "redirect:/secure/user"
    }

}
