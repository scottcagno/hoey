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
				<!-- add/edit owner info -->
				<div class="col-lg-4 col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading">Owner Details</div>
						<div class="panel-body">
							<form role="form" method="post" action="/secure/company">
								<div class="form-group">
									<input type="text" id="owner" name="owner" value="${(company.owner)!}" class="form-control" placeholder="Owner Name" required="true" autofocus="true" />
								</div>
								<div class="form-group">
									<input type="email" id="email" name="email" value="${(company.email)!}" class="form-control" placeholder="Email" required="true" />
								</div>
								<div class="form-group">
									<input type="tel" id="phone" name="phone" value="${(company.phone)!}" class="form-control" placeholder="Phone" required="true" />
								</div>
								<input type="hidden" name="id" value="1"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button class="btn btn-md btn-primary btn-block" type="submit">Update Owner</button>
							</form>
						</div>
					</div>
				</div>
				<!-- add/edit owner info -->

				<!-- add/edit company info -->
				<div class="col-lg-4 col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading">Company Details</div>
						<div class="panel-body">
							<form role="form" method="post" action="/secure/company">
								<div class="form-group">
									<input type="text" id="company" name="company" value="${(company.company)!}" class="form-control" placeholder="Company Name" required="true" />
								</div>
								<div class="form-group">
									<input type="text" id="street" name="street" value="${(company.street)!}" class="form-control" placeholder="Street" required="true" />
								</div>
								<div class="form-group row">
									<div class="col-lg-5 col-md-5">
										<input type="text" id="city" name="city" value="${(company.city)!}" class="form-control" placeholder="City" required="true" />
									</div>
									<div class="col-lg-3 col-md-3">
										<input type="text" id="state" name="state" value="${(company.state)!}" class="form-control" placeholder="St" required="true" />
									</div>
									<div class="col-lg-4 col-md-4">
										<input type="text" id="zip" name="zip" value="${(company.zip)!}" class="form-control" placeholder="Zip" required="true" />
									</div>
								</div>
								<input type="hidden" name="id" value="1"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button class="btn btn-md btn-primary btn-block" type="submit">Update Company</button>
							</form>
						</div>
					</div>
				</div>
				<!-- add/edit company info -->

				<!-- add/edit company extras -->
				<div class="col-lg-4 col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading">Company Extras</div>
						<div class="panel-body">
							<form role="form" method="post" action="/secure/company">
								<!--<div class="form-group">-->
								<!--<img src="${(company.logo??)?string((company.logo)!, '/static/img/logo.png')}" class="img-responsive">-->
								<!--</div>-->
								<div class="form-group">
									<input type="url" id="logo" name="logo" value="${(company.logo)!}" class="form-control" placeholder="Logo URL"/>
								</div>
								<div class="form-group row">
									<div class="col-xs-6">
										<input type="number" id="markup" name="markup" value="${(company.markup)!}" class="form-control" placeholder="Global Markup"/>
									</div>
									<div class="col-xs-6">
										<input type="number" id="laborRate" name="laborRate" value="${(company.laborRate)!}" class="form-control" placeholder="Labor Rate"/>
									</div>
								</div>
								<div class="form-group">
									<input type="number" id="terms" name="terms" value="${(company.terms)!}" class="form-control" placeholder="Payment Terms"/>
								</div>
								<input type="hidden" name="id" value="1"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button class="btn btn-md btn-primary btn-block" type="submit">Update Extras</button>
							</form>
						</div>
					</div>
				</div>
				<!-- add/edit company extras -->
			</div>
		</div>

		<div class="container">
			<!-- invoices -->
			<div class="panel panel-default">
				<div class="panel-heading">Outstanding Invoices</div>
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Id</th>
								<th>Customer</th>
								<th>Total</th>
								<th>Overdue</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							<#list invoices as invoice>
								<tr>
									<td>${(invoice.id)!}</td>
									<td>${(invoice.email)!}</td>
									<td>${(invoice.total)!}</td>
									<td>DUNNO YET</td>
									<td>
										<a href="#">Send Notice</a>
										<a href="#">Mark Paid</a>
									</td>
								</tr>
							</#list>
						</tbody>
					</table>
				</div>
			</div>
		</div>
			<!-- invoices -->
		</div>
		<!-- content -->

		<#include "../stubs/footer.ftl"/>

		<#include "../stubs/scripts.ftl"/>

	</body>
</html>
