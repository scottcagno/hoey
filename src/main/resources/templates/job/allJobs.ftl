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
			<div class="row">
				<!-- view all -->
				<div class="col-lg-12 col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading col-lg-12 col-md-12">
							All Jobs
						</div>
						<div class="panel-body">
							<div id="pagenator" class="text-center">
								<#assign prev = ((jobs.firstPage) ? string('1', jobs.number))/>
								<#assign next = ((jobs.lastPage) ? string (jobs.number +1, jobs.number + 2)) />
								<ul class="pagination">
									<li ${(jobs.firstPage)?string('class="disabled"', '')}><a href="/secure/job?page=1&sort=${(RequestParameters.sort)!}">First</a></li>
									<li ${(jobs.firstPage)?string('class="disabled"', '')}><a href="/secure/job?page=${prev}&sort=${(RequestParameters.sort)!}">&laquo;</a></li>
									<li class="active"><a href="/secure/job?page=${jobs.number + 1}&sort=${(RequestParameters.sort)!}">${jobs.number + 1}</a></li>
									<li ${(jobs.lastPage)?string('class="disabled"', '')}><a href="/secure/job?page=${next}&sort=${(RequestParameters.sort)!}">&raquo;</a></li>
									<li ${(jobs.lastPage)?string('class="disabled"', '')}><a href="/secure/job?page=${jobs.totalPages}&sort=${(RequestParameters.sort)!}">Last</a></li>
								</ul>
							</div>
                        </div>
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th><a href="/secure/job?page=${(RequestParameters.page)!}&sort=name">Name</a></th>
                                <th><a href="/secure/job?page=${(RequestParameters.page)!}&sort=status">Status</a></th>
                                <th><a href="/secure/job?page=${(RequestParameters.page)!}&sort=total">Total</a></th>
                                <th class="text-primary">Edit</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list jobs.content as job>
                            <tr>
                                <td>${(job.name)!}</td>
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
                                    <a href="/secure/job/${(job.id)!}" class="btn btn-sm btn-primary">
                                        <i class="fa fa-pencil"></i>
                                    </a>
                                </td>
                            </tr>
                            </#list>
                            </tbody>
                        </table>
					</div>
				</div>
				<!-- view all -->
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
