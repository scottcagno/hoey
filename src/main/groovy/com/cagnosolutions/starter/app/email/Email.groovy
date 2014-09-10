package com.cagnosolutions.starter.app.email

/**
 * Created by greg on 9/8/14.
 */
class Email {

	String[] to
	String from
	String subject
	String body

	def setAll(String from, String subject, String... to) {
		this.to = to
		this.from = from
		this.subject = subject
	}
}
