<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Customers</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">

		<#include "../stubs/navbar.ftl"/>

		<!-- content -->
		<div id="content" class="container">
			<!-- add/edit -->
			<div class="col-sm-4">
				<div class="panel panel-default">
					<div class="panel-heading">Add Customer</div>
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
			<!-- add/edit -->
			<!-- view all -->
			<div class="col-sm-8">
				<div class="panel panel-default">
					<div class="panel-heading">All Customers</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>

										<th>Company</th>
										<th>Name</th>
										<th>Email</th>
										<th>Phone</th>

									</tr>
								</thead>
								<tbody>
									<#list customers as customer>
										<tr>

											<td>${(customer.company)!}</td>
											<td>${(customer.name)!}</td>
											<td>${(customer.email)!}</td>
											<td>${(customer.phone)!}</td>

											<td>
												<a href="/secure/customer/${(customer.id)!}"
												   class="btn btn-xs btn-primary">
													<i class="fa fa-pencil"></i>
												</a>
												<a href="#" class="btn btn-danger btn-xs" data-id="${(customer.id)!}"
												   data-toggle="modal" data-target="#deleteCheck">
													<i class="fa fa-trash-o"></i>
												</a>
											</td>
										</tr>
									</#list>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- view all -->
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
						Permantly remove customer? This action cannot be undone.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-md pull-left" data-dismiss="modal">No, Cancel
						</button>
						<span id="delete">
							<form role="form" method="post" action="/secure/customer/{id}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" class="btn btn-primary btn-md">Yes, Remove Customer</button>
							</form>
						</span>

					</div>
				</div>
			</div>
		</div>

		<!-- content -->

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