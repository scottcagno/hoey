package com.cagnosolutions.starter.app.mail

/**
 * Created by greg on 9/3/14.
 */

import freemarker.template.Configuration
import freemarker.template.Template
import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.mail.SimpleMailMessage
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.mail.javamail.MimeMessageHelper
import org.springframework.stereotype.Service
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils

import javax.mail.internet.MimeMessage

@CompileStatic
@Service(value = "mailService")
class MailService {

	@Autowired
	JavaMailSender mailSender

	@Autowired
	Configuration freeMarkerConfiguration

	def sendSimpleEmail(String from, String subject, String body, String... to) {
		Thread.start {
			def email = new SimpleMailMessage()
			email.from = from
			email.replyTo = from
			email.subject = subject
			email.text = body
			email.to = to
			mailSender.send(email)
		}
	}

	def sendMimeMail(String from, String subject, String template, Map map, String... to) {
		Thread.start {
			MimeMessage email = mailSender.createMimeMessage()
			MimeMessageHelper helper = new MimeMessageHelper(email, true)
			helper.setTo(to)
			helper.setFrom(from)
			helper.setReplyTo(from)
			helper.setSubject(subject)
			Template temp = freeMarkerConfiguration.getTemplate(template)
			String text = FreeMarkerTemplateUtils.processTemplateIntoString(temp, map)
			helper.setText(text, true)
			mailSender.send(email)
		}
	}

	def test(String from, String subject, String template, Map map, String... to) {
			MimeMessage email = mailSender.createMimeMessage()
			MimeMessageHelper helper = new MimeMessageHelper(email, true)
			helper.setTo(to)
			helper.setFrom(from)
			helper.setReplyTo(from)
			helper.setSubject(subject)
			Template temp = freeMarkerConfiguration.getTemplate(template)
			String text = FreeMarkerTemplateUtils.processTemplateIntoString(temp, map)
			helper.setText(text, true)
			mailSender.send(email)
	}
}
