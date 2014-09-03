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
				<div class="panel-heading col-sm-12">
					<div class="pull-left">Materials</div>
					<div class="col-sm-2">
					<div class="dropdown">
						<button class="btn btn-xs btn-default btn-block dropdown-toggle" type="button" id="categoryFilter" data-toggle="dropdown">
							Filter By Category
							<span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu" aria-labelledby="categoryFilter">
							<#list categories as category>
								<li role="presentation">
									<a role="menuitem" tabindex="-1" href="/secure/job/${jobId}/room/${room.id}/additem?category=${category}">${category}</a>
								</li>
							</#list>
							<li role="presentation" class="divider"></li>
							<li role="presentation"><a role="menuitem" tabindex="-1" href="/secure/job/${jobId}/room/${room.id}/addItem">All Items</a></li>
						</ul>
					</div>
					</div>
					<a href="/secure/job/${jobId}" class="btn btn-xs btn-default pull-right">Back to job</a>
				</div>
				<div class="panel-body">
					<div id="materialTable" class="table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th><a href="/secure/job/${jobId}/room/${room.id}/additem?category=${(RequestParameters.category)!}&field=cat">Catergory</a></th>
									<th><a href="/secure/job/${jobId}/room/${room.id}/additem?category=${(RequestParameters.category)!}&field=name">Name</a></th>
									<th><a href="/secure/job/${jobId}/room/${room.id}/additem?category=${(RequestParameters.category)!}&field=cost">Cost</a></th>
									<th><a href="/secure/job/${jobId}/room/${room.id}/additem?category=${(RequestParameters.category)!}&field=price">Price</a></th>
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
											<form role="form" method="post" action="/secure/job/${jobId}/room/${room.id}/additem" class="pull-right">
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
