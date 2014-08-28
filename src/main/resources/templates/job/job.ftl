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
			<!-- add/edit -->
			<div class="col-sm-4">
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
			</div>

			<div class="col-sm-8">
				<div class="panel panel-default">
					<div class="panel-heading col-sm-12">
						Job ${job.name}'s Rooms
						<form role="form" method="post" action="/secure/job/${job.id}/addroom" class="col-sm-5 pull-right">
							<div class="input-group">
								<input type="text" class="form-control input-sm" name="name" placeholder="Room Name"/>
    							<span class="input-group-btn">
    								<button type="submit" class="btn btn-default btn-sm">Add Room</button>
    							</span>
							</div>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						</form>
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
									<#list job.rooms as room>
										<tr class="clickable" data-toggle="collapse" id="${room.id}" data-target=".room_${room.id}">
											<td colspan="4">${(room.name)!}</td>
											<td class="text-right">${(room.total?string.currency)!}</td>
											<td colspan="2" class="text-center">
												<a href="/secure/room/${(room.id)!}" class="btn btn-xs btn-primary">
													<i class="fa fa-pencil"></i>
												</a>
												<a href="#" class="btn btn-danger btn-xs" data-id="${(room.id)!}"
												   data-toggle="modal" data-target="#deleteCheck">
													<i class="fa fa-trash-o"></i>
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
										<#list room.items as item>
											<tr class="collapse room_${room.id}">
												<td></td>
												<td>${item.material.name}</td>
												<td>${item.material.cat}</td>
												<td>${item.count}</td>
												<td class="text-right">${item.total?string.currency}</td>
												<td class="text-center">
													<a href="#" class="btn btn-danger btn-xs">
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

		<div class="modal fade" id="deleteCheck" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Are you sure?</h4>
					</div>
					<div class="modal-body">
						Permantly remove room? This action cannot be undone.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-md pull-left" data-dismiss="modal">No, Cancel
						</button>
						<span id="delete">
							<form role="form" method="post" action="/secure/job/${job.id}/delroom/{id}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" class="btn btn-primary btn-md">Yes, Remove Room</button>
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
