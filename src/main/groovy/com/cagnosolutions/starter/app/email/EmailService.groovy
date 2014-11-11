package com.cagnosolutions.starter.app.email

import freemarker.template.Configuration
import freemarker.template.Template
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.mail.javamail.MimeMessageHelper
import org.springframework.stereotype.Service
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils

import javax.mail.internet.MimeMessage
/**
 * Created by greg on 9/8/14.
 */

@CompileStatic
@Service(value = "emailService")
class EmailService {

	@Autowired
	JavaMailSender mailSender

	@Autowired
	Configuration freeMarkerConfiguration

	Email CreateEmail(String template, Map data) {
		Email email = new Email()
		Template temp = freeMarkerConfiguration.getTemplate(template)
		email.body = FreeMarkerTemplateUtils.processTemplateIntoString(temp, data)
		email
	}

	def sendEmail(Email email) {
		Thread.start {
			MimeMessage mimeEmail = mailSender.createMimeMessage()
			MimeMessageHelper helper = new MimeMessageHelper(mimeEmail, true)
			helper.setTo(email.to)
			helper.setFrom(email.from)
			helper.setReplyTo(email.from)
			helper.setSubject(email.subject)
			helper.setText(email.body, true)
			mailSender.send(mimeEmail)
		}
	}

}
