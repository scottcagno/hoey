<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Rooms</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">
		<div id="navbar" class="navbar navbar-default navbar-static-top navbar-inverse">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="/">Hoey Enterprises</a>
				</div>
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="/secure/customer/${customerId}/job/${jobId}" class="navbar-brand">Back to job</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="container">
			<!-- login error -->
			<#if RequestParameters.error??>
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					Invalid username or password. Please try again.
				</div>
			</#if>
			<!-- login expired -->
			<#if RequestParameters.expired??>
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					Your session has expired due to inactivity. Please login.
				</div>
			</#if>
			<#if RequestParameters.invalid??>
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					Your session is invalid, maybe you're logged in from another location?
				</div>
			</#if>
			<#if RequestParameters.formError??>
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					${RequestParameters.formError}
				</div>
			</#if>
			<#if alert??>
				<div class="alert alert-info alert-dismissable text-center">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					${alert}
				</div>
				<#elseif alertError??/>
				<div class="alert alert-danger alert-dismissable text-center">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					${alertError}
				</div>
				<#elseif alertSuccess??/>
				<div class="alert alert-success alert-dismissable text-center">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					${alertSuccess}
				</div>
			</#if>
		</div>

		<!-- content -->
		<div id="content" class="container">
			<div class="row">
				<div class="col-lg-12">
					<legend>Materials</legend>
				</div>
				<div class="col-lg-12">
					<div id="materialTablePanel" class="panel panel-default">
						<div class="panel-heading col-xs-12">
							<div class="pull-left"></div>
							<div class="col-lg-2 col-md-2">
								<div class="dropdown">
									<button class="btn btn-md btn-default btn-block dropdown-toggle" type="button" id="categoryFilter" data-toggle="dropdown">
										Filter By Category
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu" role="menu" aria-labelledby="categoryFilter">
										<#list categories as category>
											<li role="presentation">
												<a role="menuitem" tabindex="-1" href="/secure/customer/${customerId}/job/${jobId}/room/${room.id?c}/additem?category=${category}">${category}</a>
											</li>
										</#list>
										<li role="presentation" class="divider"></li>
										<li role="presentation"><a role="menuitem" tabindex="-1" href="/secure/customer/${customerId}/job/${jobId}/room/${room.id?c}/addItem">All Items</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div id="materialTable" class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th><a href="/secure/customer/${customerId}/job/${jobId}/room/${room.id?c}/additem?category=${(RequestParameters.category)!}&field=cat">Catergory</a></th>
										<th><a href="/secure/customer/${customerId}/job/${jobId}/room/${room.id?c}/additem?category=${(RequestParameters.category)!}&field=name">Name</a></th>
										<th><a href="/secure/customer/${customerId}/job/${jobId}/room/${room.id?c}/additem?category=${(RequestParameters.category)!}&field=cost">Cost</a></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<#list materials as material>
										<tr>
											<td>${material.cat}</td>
											<td>${material.name}</td>
											<td>${material.cost}</td>
											<td colspan="5">
												<form role="form" method="post" action="/secure/customer/${customerId}/job/${jobId}/room/${room.id?c}/additem" class="pull-right">
													<div class="input-group">
														<input type="text" class="form-control input-sm" name="count" placeholder="Quantity" required="true"/>
    		    										<span class="input-group-btn">
    		    											<button type="submit" class="btn btn-primary btn-sm">Add Item</button>
    		    										</span>
													</div>
													<input type="hidden" name="materialId" value="${material.id?c}"/>
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
		</div>
		<#include "../stubs/footer.ftl"/>
		<#include "../stubs/scripts.ftl"/>
	</body>
</html>
