<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Jobs</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">

		<#include "../stubs/navbar.ftl"/>

		<!-- content -->
		<div id="content" class="container">
			<!-- view all -->
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading col-lg-12">
						All Jobs
					</div>
					<div class="panel-body">
						<div id="pagenator" class="text-center">
							<#assign prev = ((jobs.firstPage) ? string('1', jobs.number))/>
							<#assign next = ((jobs.lastPage) ? string (jobs.number +1, jobs.number + 2)) />
							<ul class="pagination">
								<li ${(jobs.firstPage)?string('class="disabled"', '')}><a href="/secure/job?page=1&sort=${(RequestParameters.sort)!}">First</a></li>
								<li ${(jobs.firstPage)?string('class="disabled"', '')}><a href="/secure/job?page=${prev}&sort=${(RequestParameters.sort)!}">&laquo;</a></li>
								<#list lb..ub as n>
									<li ${(n == jobs.number + 1)?string('class="active"', '')}><a href="/secure/job?page=${n}&sort=${(RequestParameters.sort)!}">${n}</a></li>
								</#list>
								<li ${(jobs.lastPage)?string('class="disabled"', '')}><a href="/secure/job?page=${next}&sort=${(RequestParameters.sort)!}">&raquo;</a></li>
								<li ${(jobs.lastPage)?string('class="disabled"', '')}><a href="/secure/job?page=${jobs.totalPages}&sort=${(RequestParameters.sort)!}">Last</a></li>
							</ul>
						</div>
						<div class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th><a href="/secure/job?page=${(RequestParameters.page)!}&sort=name">Name</a></th>
										<th><a href="/secure/job?page=${(RequestParameters.page)!}&sort=total">Total</a></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<#list jobs.content as job>
										<tr>
											<td>${(job.name)!}</td>
											<td>${(job.total?string.currency)!}</td>
											<td>
												<a href="#" class="btn btn-danger btn-xs" data-id="${(job.id)!}"
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
						Permantly remove job? This action cannot be undone.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-md pull-left" data-dismiss="modal">No, Cancel
						</button>
						<span id="delete">
							<form role="form" method="post" action="/secure/job/{id}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" class="btn btn-primary btn-md">Yes, Remove Job</button>
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
