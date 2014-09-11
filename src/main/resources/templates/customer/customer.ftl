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
                        <div id="toggle" class="panel-collapse collapse">
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
						        	<button class="btn btn-md btn-primary btn-block" type="submit">Update Customer</button>
                                    <#if customer??>
                                        <hr/>
                                        <a href="#" class="btn btn-danger btn-block" data-id="${(customer.id)!}"
                                           data-toggle="modal" data-target="#deleteCheck">
                                            Delete Customer
                                        </a>
                                    </#if>
                                </form>
					        </div>
				        </div>
                    </div>
                </div>
				<div class="panel panel-default">
					<div class="panel-heading">Add Job</div>
					<div class="panel-body">
						<form id="" role="form" method="post" action="/secure/customer/${customer.id}/addjob">
							<div class="form-group">
								<input type="text" id="name" name="name" class="form-control"
									   placeholder="Job Name" required=""true />
							</div>
							<div class="form-group">
								<textarea id="notes" name="notes" class="form-control" rows="5"
										  style="resize:none;" placeholder="Notes"></textarea>
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
                                </td>
                                <td>
                                    <form action="/secure/customer/${customer.id}/mail" method="post">
                                        <input type="hidden" name="jobId" value="${job.id}"/>
                                        <button class="btn btn-default btn-md" type="submit">Send to customer</button>
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

		<div class="modal fade" id="deleteCheck" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Are you sure?</h4>
					</div>
					<div class="modal-body">
						Permanently remove customer? This action cannot be undone.
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
