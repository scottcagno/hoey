<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Jobs</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">
		<#include "../stubs/navbar.ftl"/>

		<!-- delete item alert -->
		<div class="container">
			<div id="delete-item-confirm" class="hide alert alert-danger alert-dismissible wow fadeIn" role="alert">
				<form role="form" method="post" class="form-inline" action="">
					<div class="form-group">
						<button class="btn btn-sm btn-danger" type="submit">Yes, I'm sure</button>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<div class="form-group">
						<button id="delete-item-confirm-cancel" type="button" class="btn btn-default">No, cancel</button>
					</div>
					<div class="form-group pull-right">
						<p class="text-danger">
							Are you sure you want to permanently remove this?
						</p>
					</div>
				</form>
			</div>
		</div>
		<!-- delete item alert -->

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
					    	    					  style="resize:none;" placeholder="Notes" required="true">${(job.notes)!}</textarea>
					    	    		</div>
					    	    		<input type="hidden" name="id" value="${(job.id?c)!}"/>
					    	    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					    	    		<button class="btn btn-md btn-primary btn-block" type="submit">Update Job</button>
                                        <hr/>
										<!-- delete job trigger -->
										<a href="#delete-item-confirm" id="delete-item" data-id="/secure/customer/${customerId}/deljob/${job.id?c}"
											  class="btn btn-md btn-danger btn-block" style="cursor:pointer;">
											<i class="fa fa-trash-o"></i> Delete
										</a>
										<!-- delete job trigger -->
					    	    	</form>
					    	    </div>
                            </div>
					    </div>
                    </div>
					<!-- add/edit room -->
					<div class="panel panel-default">
						<div class="panel-heading">Add or Update Room</div>
						<div class="panel-body">
							<form role="form" method="post" action="/secure/customer/${customerId}/job/${job.id?c}/room" >
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
								<input type="hidden" name="id" value="${(room.id?c)!}"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button class="btn btn-md btn-primary btn-block" type="submit">Save Room</button>
							</form>
							<#if room?? && room.id??>
								<hr/>
								<!-- delete room trigger -->
								<a href="#delete-item-confirm" id="delete-item" data-id="/secure/customer/${customerId}/job/${job.id?c}/delroom/${room.id?c}"
									  class="btn btn-md btn-danger btn-block" style="cursor:pointer;">
									<i class="fa fa-trash-o"></i> Delete
								</a>
								<!-- delete room trigger -->
							</#if>
						</div>
					</div>
				</div>
				<!-- all rooms -->
				<div class="col-md-8">
					<div class="panel panel-default">
						<div class="panel-heading col-xs-12">
							<form action="/secure/customer/${customerId}/job/${job.id?c}/mail" class="col-xs-12 col-sm-6 pull-right" method="post">
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
													<a href="#" data-toggle="collapse" data-target="tr#room_${room.id?c}" class="btn btn-default"><i id="room_${room.id?c}" class="fa fa-chevron-right"></i></a>
												</td>
												<td colspan="3">
												${(room.name)!}
												</td>
												<td class="text-right">
													<label>Room Total: </label>
												${(room.total?string.currency)!}
												</td>
												<td colspan="2" class="text-center">
													<a href="/secure/customer/${customerId}/job/${job.id?c}/room/${(room.id?c)!}" class="btn btn-md btn-primary">
														<i class="fa fa-pencil"></i>
													</a>
													<a href="/secure/customer/${customerId}/job/${job.id?c}/room/${room.id?c}/additem" class="btn btn-success btn-md">
														Add Item
													</a>
												</td>
											</tr>
											<tr id="room_${room.id?c}" class="collapse room_${room.id?c}"><td colspan="7"></td></tr>
											<tr id="room_${room.id?c}" class="collapse room_${room.id?c} header">
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
												<tr id="room_${room.id?c}" class="collapse">
													<td></td>
													<td>${item.material.name}</td>
													<td>${item.material.cat}</td>
													<td id="${item.id?c}" class="text-center col-lg-1 col-md-1 count">
														<form role="form" id="count_${item.id?c}" action="/secure/customer/${customerId}/job/${job.id?c}/room/${room.id?c}/edititem" method="post">
															<input class="input-sm form-control" id="${item.id?c}" name="count" value="${item.count?c}" disabled="disabled" required="true">
															<input name="id" type="hidden" value="${item.id?c}">
															<input type="hidden" name="materialId" value="${item.material.id?c}">
															<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
														</form>
													</td>
													<td class="text-right">${(item.total?string.currency)!}</td>
													<td class="text-center">
														<!-- delete item trigger -->
														<a href="#delete-item-confirm" id="delete-item" data-id="/secure/customer/${customerId}/job/${job.id?c}/room/delitem/${item.id?c}"
															  class="btn btn-danger btn-md" style="cursor:pointer;">
															<i class="fa fa-trash-o"></i>
														</a>
														<!-- delete item trigger -->
													</td>
													<td></td>
												</tr>
											</#list>
											<tr class="collapse room_${room.id?c}">
												<td></td>
												<td colspan="4" class="text-right">
													<label>Room Total: </label>
													${(room.total?string.currency)!}
												</td>
												<td></td>
												<td></td>
											</tr>
											<tr class="collapse room_${room.id?c}"><td colspan="7"></td></tr>
										</#list>
										<tr>
											<td colspan="4" id="laborHours">
												<form id="laborForm" class="form-horizontal" role="form" method="post" action="/secure/customer/${customerId}/job/labor">
													<label class="col-xs-offset-3 col-xs-5 control-label">Labor Hours:</label>
													<div class="col-xs-4">
														<input type="number" id="laborHours" name="laborHours" class="form-control input-sm"
															   placeholder="Labor Hours" value="${(job.laborHours)!}" disabled="true"/>
													</div>
													<input type="hidden" name="id" value="${job.id?c}"/>
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
											<a href="/secure/customer/${customerId}/job/${job.id?c}/room/${(room.id?c)!}"
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
		<!-- content -->
		<#include "../stubs/footer.ftl"/>
		<#include "../stubs/scripts.ftl"/>
		<script src="/static/js/delete-item.js"></script>
		<script src="/static/js/job.js"></script>
	</body>
</html>
