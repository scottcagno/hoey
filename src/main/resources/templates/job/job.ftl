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
			<!-- edit job-->
			<div class="col-lg-4">
				<div class="panel panel-default">
					<div class="panel-heading">Update Job</div>
					<div class="panel-body">
						<form role="form" method="post" action="/secure/job">
							<div class="form-group">
								<input type="text" id="name" name="name" class="form-control"
									   placeholder="Name" required="true" value="${(job.name)!}"/>
							</div>
							<input type="hidden" name="id" value="${(job.id)!}"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<button class="btn btn-md btn-primary btn-block" type="submit">Save</button>
						</form>
					</div>
				</div>
				<!-- add/edit room -->
				<div class="panel panel-default">
					<div class="panel-heading">Add or Update Room</div>
					<div class="panel-body">
						<form role="form" method="post" action="/secure/job/${job.id}/room">
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
			<!-- all rooms -->
			<div class="col-lg-8">
				<div class="panel panel-default">
					<div class="panel-heading col-lg-12">
						Job ${job.name}'s Rooms
					</div>
					<div class="table-responsive">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<th colspan="4">Room Name</th>
									<th class="text-right">Room Total</th>
									<th class="text-center" colspan="2">Room Options</th>
								</tr>
							</thead>
							<tbody>
								<!-- rooms table -->
								<#list job.rooms as room>
									<tr>
										<td colspan="4">
											<a href="#" data-toggle="collapse" id="${room.id}" data-target=".room_${room.id}"><i class="fa fa-plus"></i></a>
											${(room.name)!}
										</td>
										<td class="text-right">${(room.total?string.currency)!}</td>
										<td colspan="2" class="text-center">
											<a href="/secure/job/${job.id}/room/${(room.id)!}" class="btn btn-xs btn-primary">
												<i class="fa fa-pencil"></i>
											</a>
											<a href="#" class="btn btn-danger btn-xs" data-id="${(room.id)!}"
											   data-toggle="modal" data-target="#roomDeleteCheck">
												<i class="fa fa-trash-o"></i>
											</a>
											<a href="/secure/job/${job.id}/room/${room.id}/additem" class="btn btn-success btn-xs">
												Add Item
											</a>
										</td>
									</tr>
									<tr class="collapse room_${room.id}"><td colspan="7"></td></tr>
									<tr class="collapse room_${room.id}">
										<th></th>
										<th>Item Name</th>
										<th>Category</th>
										<th>Count</th>
										<th class="text-right">Item Total</th>
										<th class="text-center">Delete Item</th>
										<th></th>
									</tr>
									<!-- rooms' items rows -->
									<#list room.items as item>
										<tr class="collapse room_${room.id}">
											<td></td>
											<td>${item.material.name}</td>
											<td>${item.material.cat}</td>
											<td id="${item.id?c}" class="text-center col-lg-1 count">
												<form role="form" id="count_${item.id?c}" action="/secure/job/${job.id}/room/${room.id}/edititem" method="post">
													<input class="input-sm form-control" id="${item.id?c}" name="count" value="${item.count?c}" disabled="disabled">
													<input name="id" type="hidden" value="${item.id?c}">
                                                    <input type="hidden" name="materialId" value="${item.material.id?c}">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												</form>
											</td>
											<td class="text-right">${(item.total?string.currency)!}</td>
											<td class="text-center">
												<a href="#" class="btn btn-danger btn-xs" data-id="${(item.id?c)!}"
												   data-toggle="modal" data-target="#itemDeleteCheck">
													<i class="fa fa-trash-o"></i>
												</a>
											</td>
											<td></td>
										</tr>
									</#list>
									<tr class="collapse room_${room.id}">
										<td></td>
										<td colspan="4" class="text-right">Room Total: ${(room.total?string.currency)!}</td>
										<td></td>
										<td></td>
									</tr>
									<tr class="collapse room_${room.id}"><td colspan="7"></td></tr>
								</#list>
								<tr>
									<td colspan="5" class="text-right">Job Total: ${(job.total?string.currency)!}</td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="roomDeleteCheck" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Are you sure?</h4>
					</div>
					<div class="modal-body">
						Permanently remove room? This action cannot be undone.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-md pull-left" data-dismiss="modal">No, Cancel
						</button>
						<span id="roomDelete">
							<form role="form" method="post" action="/secure/job/${job.id}/delroom/{id}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" class="btn btn-primary btn-md">Yes, Remove Room</button>
							</form>
						</span>

					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="itemDeleteCheck" tabindex="-1" role="dialog" aria-hidden="true">
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
						<span id="itemDelete">
							<form role="form" method="post" action="/secure/job/${job.id}/room/delitem/{id}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" class="btn btn-primary btn-md">Yes, Remove Item</button>
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
					var form = $('.modal #roomDelete');
					form.html(form.html().replace('{id}',id));
				});

				// toggle safe delete modal popup
				$('a[data-toggle="modal"]').click(function(){
					var id = $(this).data('id');
					var form = $('.modal #itemDelete');
					form.html(form.html().replace('{id}',id));
				});


				/*
				*
				* change item count
				*
				*/

				// enable quantity field on td click
				$('td.count').click(function() {
					$('input[id="'+this.id+'"]').removeAttr('disabled');
					$('input[id="'+this.id+'"]').focus();
				});

				// register submit, disable, and focus actions on count fields
				$('input[name="count"]').focus(function() {
					this.onblur = function() {this.setAttribute('disabled', true)}
					this.onchange = function() {$('form[id="count_' + this.id + '"]').submit()}
				});
			});
		</script>

	</body>
</html>
