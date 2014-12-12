package com.cagnosolutions.starter.app.email
import com.sun.jersey.api.client.Client
import com.sun.jersey.api.client.ClientResponse
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter
import com.sun.jersey.core.util.MultivaluedMapImpl
import groovy.transform.CompileStatic
import org.springframework.stereotype.Service

import javax.ws.rs.core.MediaType

@CompileStatic
@Service
class EmailService {

	static String AUTH_KEY = "key-173701b40541299bd3b7d40c3ac6fd43"
	static String BASE_URI = "https://api.mailgun.net/v2/sandbox73d66ccb60f948708fcaf2e2d1b3cd4c.mailgun.org"

	ClientResponse send(String from, String to, String subject, String text) {
		def client = Client.create()
		def resource = client.resource BASE_URI + "/messages"
		def data = new MultivaluedMapImpl()
		client.addFilter new HTTPBasicAuthFilter("api", AUTH_KEY)
		data.add "from", from
		data.add "to", to
		data.add "subject", subject
		data.add "text", text
		data.add "html", "<html><h1>HTML VERSION</h1><p>${text}</p></html>"
		resource.type(MediaType.APPLICATION_FORM_URLENCODED).post(data)
	}

}
