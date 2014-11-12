<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Items</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">
		<#include "../stubs/navbar.ftl"/>
		<!-- content -->
		<div id="content" class="container">
			<div class="row">
				<!-- add/edit -->
				<div class="col-lg-4 col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading">Add or Update Item
							<span class="pull-right"><a href="/secure/item">Add New</a></span>
						</div>
						<div class="panel-body">
							<form role="form" method="post" action="/secure/item">
								<input type="hidden" name="id" value="${(item.id)!}"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button class="btn btn-md btn-primary btn-block" type="submit">Save</button>
							</form>
						</div>
					</div>
				</div>
				<!-- add/edit -->
				<!-- view all -->
				<div class="col-lg-8 col-md-8">
					<div class="panel panel-default">
						<div class="panel-heading">Current Items</div>
						<div class="panel-body">
							<div class="table-responsive">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>Material</th>
											<th>Count</th>
										</tr>
									</thead>
									<tbody>
										<#list items as item>
											<tr>
												<td>${(item.mid.desc)!}</td>
												<td>${(item.count)!}</td>
												<td>
													<a href="/secure/item/${(item.id)!}" class="btn btn-md btn-primary">
														<i class="fa fa-pencil"></i>
													</a>
													<a href="#" class="btn btn-danger btn-md" data-id="${(item.id)!}"
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
		</div>

		<!-- delete modal confirmation -->
		<div class="modal fade" id="deleteCheck" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Are you sure?</h4>
					</div>
					<div class="modal-body">
						Permantly remove item? This action cannot be undone.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-md pull-left" data-dismiss="modal">No, Cancel
						</button>
						<span id="delete">
							<form role="form" method="post" action="/secure/item/{id}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" class="btn btn-primary btn-md">Yes, Remove Item</button>
							</form>
						</span>
					</div>
				</div>
			</div>
			<!-- delete modal confirmation -->
			<!-- content -->
			<#include "../stubs/footer.ftl"/>
			<#include "../stubs/scripts.ftl"/>
			<script src="/static/js/delete-modal.js"></script>
		</div>
	</body>
</html>
