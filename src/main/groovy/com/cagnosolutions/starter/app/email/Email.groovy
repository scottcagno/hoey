package com.cagnosolutions.starter.app.email

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
