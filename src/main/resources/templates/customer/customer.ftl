<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Customer</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">

		<#include "../stubs/navbar.ftl"/>

		<!-- delete item alert -->
		<div class="container">
			<div id="delete-item-confirm" class="hide alert alert-danger alert-dismissible wow fadeIn" role="alert">
				<form role="form" method="post" class="form-inline" action="">
					<div class="form-group">
						<button class="btn btn-sm btn-danger" type="submit">Yes, I'm sure</button>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<div class="form-group">
						<button id="delete-item-confirm-cancel" type="button" class="btn btn-default">No, cancel</button>
					</div>
					<div class="form-group pull-right">
						<p class="text-danger">
							Are you sure you want to permanently remove this?
						</p>
					</div>
				</form>
			</div>
		</div>
		<!-- delete item alert -->

		<div id="content" class="container">
			<div class="row">
				<div class="col-lg-12">
					<legend>Customer Details</legend>
				</div>
				<!-- add/edit -->
				<div class="col-md-4">
					<div class="panel-group" id="accordion">
						<div id="customer" class="panel panel-default">
							<div class="panel-heading">
								${(customer.name)!}
								<a data-toggle="collapse" data-target="#toggle"
								   href="#toggle" class="pull-right">
									Details
								</a>
							</div>
							<div id="toggle" class="panel-collapse collapse ${(errors??)?string('in', '')}">
								<div class="panel-body">
									<form role="form" method="post" action="/secure/customer" >
										<div class="form-group">
											<input type="text" id="company" name="company" class="form-control"
											       placeholder="Company" value="${(customer.company)!}"/>
										</div>
										<div class="form-group">
											<span class="text-error">${(errors.name)!}</span>
											<input type="text" id="name" name="name" class="form-control"
											       placeholder="Name" required="true" value="${(customer.name)!}"/>
										</div>
										<div class="form-group">
											<span class="text-error">${(errors.email)!}</span>
											<input type="email" id="email" name="email" class="form-control"
											       placeholder="Email" required="true" value="${(customer.email)!}"/>
										</div>
										<div class="form-group">
											<span class="text-error">${(errors.phone)!}</span>
											<input type="text" id="phone" name="phone" class="form-control"
											       placeholder="Phone number" required="true" value="${(customer.phone)!}"/>
										</div>
										<input type="hidden" name="id" value="${(customer.id?c)!}"/>
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
										<button class="btn btn-md btn-primary btn-block" type="submit">Update Customer</button>
										<hr/>
										<!-- delete job trigger -->
										<a href="#delete-item-confirm" id="delete-item" data-id="/secure/customer/${customer.id?c}"
										   class="btn btn-md btn-danger btn-block" style="cursor:pointer;">
											<i class="fa fa-trash-o"></i> Delete
										</a>
										<!-- delete job trigger -->
									</form>
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">Add Job</div>
						<div class="panel-body">
							<form id="" role="form" method="post" action="/secure/customer/${customer.id?c}/addjob" >
								<div class="form-group">
									<span class="text-error">${(jobErrors.name)!}</span>
									<input type="text" id="name" name="name" class="form-control"
									       placeholder="Job Name" value="${(job.name)!}" required="true"/>
								</div>
								<div class="form-group">
									<span class="text-error">${(jobErrors.notes)!}</span>
									<textarea id="notes" name="notes" class="form-control" rows="5" required="true"
									          style="resize:none;" placeholder="Notes">${(job.notes)!}</textarea>
								</div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button class="btn btn-md btn-primary btn-block" type="submit">Add</button>
							</form>
						</div>
					</div>
				</div>
				<div class="col-lg-8 col-md-8">
					<div class="panel panel-default">
						<div class="panel-heading col-xs-12">
							Jobs
						</div>
						<div class="hidden-xs hidden-sm">
							<div class="table-responsive">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>Name</th>
											<th>Created</th>
											<th>Status</th>
											<th>Total</th>
											<th>Edit</th>
											<th>Quote</th>
										</tr>
									</thead>
									<tbody>
										<#list customer.jobs as job>
											<tr>
												<td>${(job.name)!}</td>
												<td>${job.created?string.short}</td>
												<td>
													<#switch job.status>
														<#case 0>
															Quote
															<#break>
														<#case 1>
															Sent
															<#break>
														<#case 2>
															Invoiced
															<#break>
														<#case 3>
															Paid
															<#break>
													</#switch>
												</td>
												<td>${(job.total?string.currency)!}</td>
												<td>
													<a href="/secure/customer/${customer.id?c}/job/${(job.id?c)!}" class="btn btn-md btn-primary">
														<i class="fa fa-pencil"></i>
													</a>
												</td>
												<td>
													<form action="/secure/customer/${customer.id?c}/mail" method="post">
														<input type="hidden" name="jobId" value="${job.id?c}"/>
														<button class="btn btn-default btn-md" type="submit">${(job.status == 0)?string('Email', 'Re-Email')} to customer</button>
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
													</form>
												</td>
											</tr>
										</#list>
									</tbody>
								</table>
							</div>
						</div>
						<div class="visible-xs-block visible-sm-block">
							<div class="panel-body">
								<br/>
								<div class="list-group panel-group">
									<#list customer.jobs as job>
										<a href="/secure/customer/${customer.id?c!}/job/${job.id?c!}" class="list-group-item">
											<strong>${job.name!}</strong> <br/>
											${job.created?string.short} <br/>
												<#switch job.status>
													<#case 0>
														Status: Quote
														<#break>
													<#case 1>
														Status: Sent
														<#break>
													<#case 2>
														Status: Invoiced
														<#break>
													<#case 3>
														Status: Paid
														<#break>
												</#switch>
												<br/>
											${(job.total?string.currency)!}
										</a>
									</#list>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<#include "../stubs/footer.ftl"/>
		<#include "../stubs/scripts.ftl"/>
		<script src="/static/js/delete-item.js"></script>
	</body>
</html>
