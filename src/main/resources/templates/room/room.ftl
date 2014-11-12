<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Rooms</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">
		<#include "../stubs/navbar.ftl"/>
		<!-- content -->
		<div id="content" class="container">
			<div class="row`">
				<!-- add/edit -->
				<div class="col-lg-4">
					<div class="panel panel-default">
						<div class="panel-heading">Update Room</div>
						<div class="panel-body">
							<form role="form" method="post" action="/secure/room">
								<div class="form-group">
									<input type="text" id="name" name="name" class="form-control"
										   placeholder="Name" required="true" value="${(room.name)!}"/>
								</div>
								<input type="hidden" name="id" value="${(room.id)!}"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button class="btn btn-md btn-primary btn-block" type="submit">Save</button>
							</form>
						</div>
					</div>
				</div>
				<!-- add/edit -->
				<div class="col-lg-8">
					<div class="panel panel-default">
						<div class="panel-heading col-lg-12">
							Current Items
							<a href="/secure/room/${room.id}/additem" id="addItem" class="btn btn-default btn-sm pull-right">Add Item</a>
						</div>
						<div class="panel-body">
							<div class="table-responsive">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>Material</th>
											<th>Count</th>
											<th class="text-right">Total</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<#list room.items as item>
											<tr>
												<td>${(item.material.name)!}</td>
												<td id="${item.id}" class="text-center col-lg-1 count">
													<form role="form" id="count_${item.id}" action="/secure/room/${room.id}/additem" method="post">
														<input class="input-sm form-control" id="${item.id}" name="count" value="${item.count}" disabled="disabled">
														<input name="id" type="hidden" value="${item.id}">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
													</form>
												</td>
												<td class="text-right">${(item.total?string.currency)!}</td>
												<td>
													<a href="#" class="btn btn-danger btn-md" data-id="${(item.id)!}"
													   data-toggle="modal" data-target="#deleteCheck">
														<i class="fa fa-trash-o"></i>
													</a>
												</td>
											</tr>
										</#list>
										<tr>
											<td colspan="3" class="text-right">${(room.total?string.currency)!}</td>
										</tr>
									</tbody>
								</table>
							</div>
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
						Permanently remove item? This action cannot be undone.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-md pull-left" data-dismiss="modal">No, Cancel
						</button>
						<span id="delete">
							<form role="form" method="post" action="/secure/room/${room.id}/delitem/{id}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" class="btn btn-primary btn-md">Yes, Remove Item</button>
							</form>
						</span>
					</div>
				</div>
			</div>
			<!-- content -->
			<#include "../stubs/footer.ftl"/>
			<#include "../stubs/scripts.ftl"/>
			<script src="/static/js/room.js"></script>
		</div>
	</body>
</html>
