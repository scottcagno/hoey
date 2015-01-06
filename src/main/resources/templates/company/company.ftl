<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Company Settings</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">
		<#include "../stubs/navbar.ftl"/>
		<!-- content -->
		<div id="content" class="container">
			<div class="row">
				<div class="col-lg-offset-4 col-md-offset-4 col-lg-4 col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading">Settings</div>
						<div class="panel-body">
							<form role="form" method="post" action="/secure/company" novalidate>
								<div class="form-group">
                            	    <label>
										*Globals for markup and labor rate
									</label>
                            	</div>
								<div class="form-group row">
									<div class="col-xs-6">
										<span class="text-error">${(errors.markup)!}</span>
										<label>Markup %</label>
										<input type="number" id="markup" name="markup" value="${(company.markup)!}" class="form-control" placeholder="Global Markup"/>
									</div>
									<div class="col-xs-6">
										<span class="text-error">${(errors.laborRate)!}</span>
										<label>Labor/hr</label>
										<input type="number" id="laborRate" name="laborRate" value="${(company.laborRate)!}" class="form-control" placeholder="Labor Rate"/>
									</div>
								</div>
								<hr/>
								<div class="text-center">
									<a data-toggle="collapse" data-parent="#accordion"
									   href="#changePassword" class="text-primary">
										Click to change password
									</a>
								</div>
								<br/>
								<div id="changePassword" class="panel-collapse collapse">
									<!-- toggle show password input -->
									<div class="form-group">
										<div class="input-group">
											<input type="password" id="toggle-pass" name="password" class="form-control"
												   placeholder="Password"/>
											<span class="input-group-btn">
												<button id="toggle-pass" type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right"
														title="Click to show/hide your password">
													<i class="fa fa-eye-slash"></i>
												</button>
											</span>
										</div>
									</div>
									<!-- toggle show password input -->
								</div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button class="btn btn-md btn-primary btn-block" type="submit">Save Settings</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<#include "../stubs/footer.ftl"/>

		</div>
		<div>
			<#include "../stubs/scripts.ftl"/>
			<script src="/static/js/company.js"></script>
		</div>
		<!-- content -->
	</body>
</html>
