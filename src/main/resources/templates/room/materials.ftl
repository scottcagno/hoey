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
			<div id="materialTablePanel" class="panel panel-default">
				<div class="panel-heading">Materials</div>
				<div class="panel-body">
					<div id="materialTable" class="table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Category</th>
									<th>Name</th>
									<th>Cost</th>
									<th>Price</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<#list materials as material>
									<tr>
										<td>${material.cat}</td>
										<td>${material.name}</td>
										<td>${material.cost}</td>
										<td>${material.price}</td>
										<td colspan="3">
											<form role="form" method="post" action="/secure/room/${room.id}/addItem" class="pull-right">
												<div class="input-group">
													<input type="text" class="form-control input-sm" name="count" placeholder="Quantity"/>
    												<span class="input-group-btn">
    													<button type="submit" class="btn btn-primary btn-sm">Add Item</button>
    												</span>
												</div>
												<input type="hidden" name="materialId" value="${material.id}"/>
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

		<#include "../stubs/footer.ftl"/>

		<#include "../stubs/scripts.ftl"/>

	</body>
</html>
