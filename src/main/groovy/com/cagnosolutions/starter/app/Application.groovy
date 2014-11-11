package com.cagnosolutions.starter.app

import groovy.transform.CompileStatic
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.EnableAutoConfiguration
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.ComponentScan
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.PropertySource
import org.springframework.core.env.Environment
import org.springframework.data.jpa.repository.config.EnableJpaRepositories
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.mail.javamail.JavaMailSenderImpl
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.security.web.util.matcher.AntPathRequestMatcher
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter

import javax.sql.DataSource

/**
 * Created by Scott Cagno.
 * Copyright Cagno Solutions. All rights reserved.
 */

@CompileStatic
@ComponentScan
@EnableJpaRepositories
@EnableAutoConfiguration
class Application {
	static void main(String... args) {
		SpringApplication.run Application, args
	}
}

@CompileStatic
@Configuration
class StaticMapping extends WebMvcConfigurerAdapter {
	void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
	}
}

@CompileStatic
@Configuration
@EnableWebMvcSecurity
class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	DataSource dataSource;

	@Autowired
	void configAuthentication(AuthenticationManagerBuilder auth) throws Exception {
		auth.inMemoryAuthentication().withUser("admin").password("admin").roles("ADMIN")
		auth.jdbcAuthentication().dataSource(dataSource).passwordEncoder(new BCryptPasswordEncoder())
				.usersByUsernameQuery("SELECT username, password, active FROM company WHERE username=?")
				.authoritiesByUsernameQuery("SELECT username, role FROM company WHERE username=?")
	}

	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests().antMatchers("/secure/**").hasAnyRole("ADMIN")
		http.formLogin().loginPage("/login")
		//http.sessionManagement().maximumSessions(1).expiredUrl("/login?expired").maxSessionsPreventsLogin(false)
		http.logout().logoutSuccessUrl("/").logoutRequestMatcher(new AntPathRequestMatcher("/logout", "GET"))
	}
}

@Configuration
@PropertySource("classpath:application.yml")
public class MailConfig {

	@Autowired
	private Environment env;

	@Bean(name = "mailSender")
	public JavaMailSender javaMailSender() {
		JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
		javaMailSender.setHost(env.getProperty("mail.host"));
		javaMailSender.setPort(Integer.parseInt(env.getProperty("mail.port")));
		javaMailSender.setUsername(env.getProperty("mail.user"));
		javaMailSender.setPassword(env.getProperty("mail.pass"));
		javaMailSender.setJavaMailProperties(getMailProperties());
		return javaMailSender;
	}

	private Properties getMailProperties() {
		Properties properties = new Properties();
		properties.setProperty("mail.transport.protocol", "smtp");
		properties.setProperty("mail.smtp.auth", "true");
		properties.setProperty("mail.smtp.starttls.enable", "true");
		properties.setProperty("mail.debug", "true");
		return properties;
	}
}
