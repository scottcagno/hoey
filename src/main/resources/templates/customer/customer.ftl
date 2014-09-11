<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Customer</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">

		<#include "../stubs/navbar.ftl"/>

		<div id="content" class="container">
			<!-- add/edit -->
			<div class="col-lg-4 col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">Update Customer</div>
					<div class="panel-body">
						<form role="form" method="post" action="/secure/customer">

							<div class="form-group">
								<input type="text" id="company" name="company" class="form-control"
									   placeholder="Company" required="true" value="${(customer.company)!}"/>
							</div>
							<div class="form-group">
								<input type="text" id="name" name="name" class="form-control"
									   placeholder="Name" required="true" value="${(customer.name)!}"/>
							</div>
							<div class="form-group">
								<input type="email" id="email" name="email" class="form-control"
									   placeholder="Email" required="true" value="${(customer.email)!}"/>
							</div>
							<div class="form-group">
								<input type="text" id="phone" name="phone" class="form-control"
									   placeholder="Phone number" required="true" value="${(customer.phone)!}"/>
							</div>

							<input type="hidden" name="id" value="${(customer.id)!}"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<button class="btn btn-md btn-primary btn-block" type="submit">Save</button>
						</form>
					</div>
				</div>
			</div>
			<div class="col-lg-8 col-md-8">
				<div class="panel panel-default">
					<div class="panel-heading col-lg-12 col-md-12">
						Jobs
						<form role="form" class="col-lg-5 col-md-5 pull-right" method="post" action="/secure/customer/${customer.id}/addjob">
							<div class="input-group">
								<input type="text" name="name" class="form-control input-sm" placeholder="Job Name" required="true"/>
								<span class="input-group-btn">
									<button class="btn btn-default btn-sm" type="submit">Save</button>
								</span>
							</div>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						</form>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>Name</th>
										<th>Created</th>
										<th>Status</th>
										<th>Total</th>
										<th></th>
										<th></th>
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
														Active
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
												<a href="/secure/customer/${customer.id}/job/${(job.id)!}" class="btn btn-md btn-primary">
													<i class="fa fa-pencil"></i>
												</a>
												<a href="#" class="btn btn-danger btn-md" data-id="${(job.id)!}"
												   data-toggle="modal" data-target="#deleteCheck">
													<i class="fa fa-trash-o"></i>
												</a>
											</td>
											<td>
												<form action="/secure/customer/${customer.id}/mail" method="post">
													<input type="hidden" name="jobId" value="${job.id}"/>
													<button class="btn btn-default btn-sm " type="submit">Send to customer</button>
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												</form>
											</td>
										</tr>
									</#list>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="deleteCheck" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Are you sure?</h4>
					</div>
					<div class="modal-body">
						Permantly remove job? This action cannot be undone.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-md pull-left" data-dismiss="modal">No, Cancel
						</button>
						<span id="delete">
							<form role="form" method="post" action="/secure/customer/${customer.id}/deljob/{id}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" class="btn btn-primary btn-md">Yes, Remove Job</button>
							</form>
						</span>
					</div>
				</div>
			</div>
		</div>


		<#include "../stubs/footer.ftl"/>

		<#include "../stubs/scripts.ftl"/>

		<script>
			$(document).ready(function() {

				// toggle safe delete modal popup
				$('a[data-toggle="modal"]').click(function(){
					var id = $(this).data('id');
					var form = $('.modal #delete');
					form.html(form.html().replace('{id}',id));
				});
			});

		</script>

	</body>
</html>
