package com.cagnosolutions.starter.app.email

import com.sun.jersey.api.client.Client
import com.sun.jersey.api.client.ClientResponse
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter
import com.sun.jersey.core.util.MultivaluedMapImpl
import freemarker.template.Configuration
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils
import javax.ws.rs.core.MediaType

@CompileStatic
@Service
class EmailService {

	static String AUTH_KEY = "key-173701b40541299bd3b7d40c3ac6fd43"
	static String BASE_URI = "https://api.mailgun.net/v2/mg.cagnosolutions.com"

	static ClientResponse send(String from, String to, String subject, String text, String html) {
		def client = Client.create()
		def resource = client.resource BASE_URI + "/messages"
		def data = new MultivaluedMapImpl()
		client.addFilter new HTTPBasicAuthFilter("api", AUTH_KEY)
		data.add "from", from
		data.add "to", to
		data.add "subject", subject
		data.add "text", text
		data.add "html", html
		resource.type(MediaType.APPLICATION_FORM_URLENCODED).post(data)
	}

	ClientResponse send(String from, String to, String subject, String text) {
		send from, to, subject, text, text
	}

	/** FREEMARKER TEMPLATE SUPPORT **/

	@Autowired
	Configuration config // template configuation class

	ClientResponse send(String from, String to, String subject, String text, String template, Map data) {
		def body = FreeMarkerTemplateUtils.processTemplateIntoString config.getTemplate(template), data
		send from, to, subject, text, body
	}

	/** FREEMARKER TEMPLATE SUPPORT **/
}