package com.cagnosolutions.starter.app

import groovy.transform.CompileStatic
import org.springframework.security.core.Authentication
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.web.DefaultRedirectStrategy
import org.springframework.security.web.RedirectStrategy
import org.springframework.security.web.authentication.AuthenticationSuccessHandler

import javax.servlet.ServletException
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@CompileStatic
class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

	RedirectStrategy redirectStrategy = new DefaultRedirectStrategy()

	void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
								 	Authentication authentication) throws IOException, ServletException {

		def successUrl = "/login/success"

		authentication.authorities.each { authority ->
			switch ((authority as GrantedAuthority).authority) {
				case "ROLE_USER":
					successUrl += "?role=user"
					break
				case "ROLE_ADMIN":
					successUrl = "/admin"
					break
				case "ROLE_PRINT":
					successUrl = "/print"
			}
		}

		if (response.committed)
			return

		redirectStrategy.sendRedirect request, response, successUrl
	}
}
