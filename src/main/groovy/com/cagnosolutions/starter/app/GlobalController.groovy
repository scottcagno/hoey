package com.cagnosolutions.starter.app

import groovy.transform.CompileStatic
import com.cagnosolutions.starter.app.user.UserService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RequestParam
import javax.servlet.http.HttpSession
import java.security.Principal

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@Controller(value = "indexController")
class IndexController {
    
    @RequestMapping(value = "/", method = RequestMethod.GET)
    String index() {
        "index"
    }
}

@CompileStatic
@Controller(value = "authController")
class Authentication {

    @Autowired
    UserService userService

    @RequestMapping(value = "/login")
    String login() {
        "login"
    }

    @RequestMapping(value = "/secure/login", method = RequestMethod.GET)
    String secureLogin(@RequestParam String forward, HttpSession session, Principal principal) {
        if(principal.name != "admin") {
            def user = userService.findOne principal.name
            user.lastSeen = System.currentTimeMillis()
            userService.save user
        }
        session.setAttribute "authenticated", principal.name
        "redirect:/secure/$forward"
    }
}

@CompileStatic
@Controller(value = "errorController")
class ErrorHandler {

    @ExceptionHandler(value = [Exception.class, RuntimeException.class])
    String errors(Exception e, Model model) {
        def stack = []
        for (frame in e.getStackTrace()) {
            stack << frame.toString()
        }
        model.addAllAttributes([message: e.getLocalizedMessage(), exception: stack.join('\n')])
        "error"
    }
}
