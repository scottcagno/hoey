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
				<div class="col-lg-12">
					<legend>Job Details</legend>
				</div>
				<!-- edit job-->
				<div class="col-lg-4 col-md-4">
                    <div class="panel-group" id="accordion">
					    <div class="panel panel-default">
					    	<div class="panel-heading">
                                ${(job.name)!}
                                <a data-toggle="collapse" data-target="#toggle"
                                   href="#toggle" class="pull-right">
                                    Details
                                </a>
					    	</div>
                            <div id="toggle" class="panel-collapse collapse ${(errors??)?string('in', '')}">
					    	    <div class="panel-body">
					    	    	<form role="form" method="post" action="/secure/customer/${customerId}/job">
					    	    		<div class="form-group">
											<span class="text-error">${(errors.name)!}</span>
					    	    			<input type="text" id="name" name="name" class="form-control"
					    	    				   placeholder="Job Name" value="${(job.name)!}"/>
					    	    		</div>
					    	    		<div class="form-group">
											<span class="text-error">${(errors.notes)!}</span>
					    	    			<textarea id="notes" name="notes" class="form-control" rows="5"
					    	    					  style="resize:none;" placeholder="Notes">${(job.notes)!}</textarea>
					    	    		</div>
					    	    		<input type="hidden" name="id" value="${(job.id)!}"/>
					    	    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					    	    		<button class="btn btn-md btn-primary btn-block" type="submit">Update Job</button>
                                        <hr/>
                                        <a href="#" class="btn btn-danger btn-block" data-id="${(job.id)!}"
                                           data-toggle="modal" data-target="#jobDeleteCheck">
                                            Delete Job
                                        </a>
					    	    	</form>
					    	    </div>
                            </div>
					    </div>
                    </div>
					<!-- add/edit room -->
					<div class="panel panel-default">
						<div class="panel-heading">Add or Update Room</div>
						<div class="panel-body">
							<form role="form" method="post" action="/secure/customer/${customerId}/job/${job.id}/room">
								<div class="form-group">
									<span class="text-error">${(roomErrors.name)!}</span>
									<input type="text" id="name" name="name" class="form-control"
										   placeholder="Name" required="true" value="${(room.name)!}"/>
								</div>
								<div class="form-group">
									<span class="text-error">${(roomErrors.notes)!}</span>
									<textarea id="notes" name="notes" class="form-control" rows="5"
											  style="resize:none;" placeholder="Notes">${(room.notes)!}</textarea>
								</div>

								<input type="hidden" name="id" value="${(room.id)!}"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button class="btn btn-md btn-primary btn-block" type="submit">Save Room</button>
							</form>
							<#if room?? && room.id??>
								<hr/>
								<a href="#" class="btn btn-danger btn-block" data-id="${(room.id)!}"
								   data-toggle="modal" data-target="#roomDeleteCheck">
									Delete Room
								</a>
							</#if>
						</div>
					</div>
				</div>
				<!-- all rooms -->
				<div class="col-md-8">
					<div class="panel panel-default">
						<div class="panel-heading col-xs-12">
							<form action="/secure/customer/${customerId}/job/${job.id}/mail" class="col-xs-12 col-sm-6 pull-right" method="post">
								<div class="btn-group">
									<a href="/secure/customer/${customerId}" class="btn btn-default"><i class="fa fa-reply"></i> Customer</a>
									<button class="btn btn-default" type="submit">${(job.status == 0)?string('Email', 'Re-Email')} Quote</button>
								</div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							</form>
						</div>
						<div class="hidden-xs hidden-sm">
							<div class="table-responsive">
								<table class="table table-bordered table-hover">
									<thead>
										<tr>
											<th colspan="4">Room Name</th>
											<th class="text-right">Total</th>
											<th class="text-center" colspan="2">Room Options</th>
										</tr>
									</thead>
									<tbody>
										<!-- rooms table -->
									<#list job.rooms as room>
										<tr>
											<td>
												<a href="#" data-toggle="collapse" data-target="tr#room_${room.id}" class="btn btn-default"><i id="room_${room.id}" class="fa fa-chevron-right"></i></a>
											</td>
											<td colspan="3">
											${(room.name)!}
											</td>
											<td class="text-right">
												<label>Room Total: </label>
											${(room.total?string.currency)!}
											</td>
											<td colspan="2" class="text-center">
												<a href="/secure/customer/${customerId}/job/${job.id}/room/${(room.id)!}" class="btn btn-md btn-primary">
													<i class="fa fa-pencil"></i>
												</a>
												<a href="/secure/customer/${customerId}/job/${job.id}/room/${room.id}/additem" class="btn btn-success btn-md">
													Add Item
												</a>
											</td>
										</tr>
										<tr id="room_${room.id}" class="collapse room_${room.id}"><td colspan="7"></td></tr>
										<tr id="room_${room.id}" class="collapse room_${room.id} header">
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
											<tr id="room_${room.id}" class="collapse">
												<td></td>
												<td>${item.material.name}</td>
												<td>${item.material.cat}</td>
												<td id="${item.id?c}" class="text-center col-lg-1 col-md-1 count">
													<form role="form" id="count_${item.id?c}" action="/secure/customer/${customerId}/job/${job.id}/room/${room.id}/edititem" method="post">
														<input class="input-sm form-control" id="${item.id?c}" name="count" value="${item.count?c}" disabled="disabled" required="true">
														<input name="id" type="hidden" value="${item.id?c}">
														<input type="hidden" name="materialId" value="${item.material.id?c}">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
													</form>
												</td>
												<td class="text-right">${(item.total?string.currency)!}</td>
												<td class="text-center">
													<a href="#" class="btn btn-danger btn-md" data-id="${(item.id?c)!}"
													   data-toggle="modal" data-target="#itemDeleteCheck">
														<i class="fa fa-trash-o"></i>
													</a>
												</td>
												<td></td>
											</tr>
										</#list>
										<tr class="collapse room_${room.id}">
											<td></td>
											<td colspan="4" class="text-right">
												<label>Room Total: </label>
												${(room.total?string.currency)!}
											</td>
											<td></td>
											<td></td>
										</tr>
										<tr class="collapse room_${room.id}"><td colspan="7"></td></tr>
									</#list>
										<tr>
											<td colspan="4" id="laborHours">
												<form id="laborForm" class="form-horizontal" role="form" method="post" action="/secure/customer/${customerId}/job/labor">
													<label class="col-xs-offset-3 col-xs-5 control-label">Labor Hours:</label>
													<div class="col-xs-4">
														<input type="number" id="laborHours" name="laborHours" class="form-control input-sm"
															   placeholder="Labor Hours" value="${(job.laborHours)!}" disabled="true"/>
													</div>
													<input type="hidden" name="id" value="${job.id}"/>
													<input type="hidden" name="${_csrf.parameterName}"
														   value="${_csrf.token}"/>
												</form>
											</td>
											<td class="text-right">
												<label>Labor Total: </label>
											${(job.laborTotal?string.currency)!}
											</td>
											<td colspan="2"></td>
										</tr>
										<tr>
											<td colspan="5" class="text-right">
												<label>Job Total: </label>
											${(job.total?string.currency)!}
											</td>
											<td colspan="2"></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="visible-xs-block visible-sm-block">
							<div class="panel-body">
								<br/>
								<div class="list-group">
									<#list job.rooms as room>
										<span class="list-group-item">
											<strong>${room.name!}</strong> <br/>
											Contains ${room.items?size} items <br/>
											${room.name!} Total: ${(room.total?string.currency)!} <br/><br/>
											<a href="/secure/customer/${customerId}/job/${job.id}/room/${(room.id)!}"
											   class="btn btn-sm btn-primary btn-block">
												<i class="fa fa-plus"></i>&nbsp; Add Notes For Room
											</a>
										</span>
									</#list>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="jobDeleteCheck" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Are you sure?</h4>
					</div>
					<div class="modal-body">
						Permanently remove job? This action cannot be undone.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-md pull-left" data-dismiss="modal">No, Cancel
						</button>
						<span id="jobDelete">
							<form role="form" method="post" action="/secure/customer/${customerId}/deljob/{id}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" class="btn btn-primary btn-md">Yes, Remove Job</button>
							</form>
						</span>
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
							<form role="form" method="post" action="/secure/customer/${customerId}/job/${job.id}/delroom/{id}">
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
							<form role="form" method="post" action="/secure/customer/${customerId}/job/${job.id}/room/delitem/{id}">
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
			<script src="/static/js/job.js"></script>
	</body>
</html>
