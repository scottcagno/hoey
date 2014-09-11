<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Materials</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">

		<#include "../stubs/navbar.ftl"/>

		<!-- content -->
		<div id="content" class="container">
			<!-- add/edit -->
			<div class="col-lg-4 col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						Add/Edit Material
						<span class="pull-right"><a href="/secure/material">Clear</a></span>
					</div>
					<div class="panel-body">
						<form role="form" method="post" action="/secure/material">

							<div class="form-group">
								<input type="text" id="cat" name="cat" class="form-control"
									   placeholder="Category" required="true" value="${(material.cat)!}"/>
							</div>
							<div class="form-group">
								<input type="text" id="name" name="name" class="form-control"
									   placeholder="Name" required="true" value="${(material.name)!}"/>
							</div>
							<div class="form-group">
								<input type="number" id="cost" name="cost" class="form-control"
									   placeholder="Cost" required="true" value="${(material.cost)!}"/>
							</div>
							<div class="form-group">
								<input type="number" id="price" name="price" class="form-control"
									   placeholder="Price" required="true" value="${(material.price)!}"/>
							</div>
							

							<input type="hidden" name="id" value="${(material.id)!}"/>
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
					<div class="panel-heading col-lg-12 col-md-12">
						Current Materials
						<div class="dropdown pull-right">
							<button class="btn btn-default btn-sm dropdown-toggle" type="button" id="categoryFilter" data-toggle="dropdown">
								Filter By Category
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu" aria-labelledby="categoryFilter">
								<#list categories as category>
									<li role="presentation">
										<a role="menuitem" tabindex="-1" href="/secure/material?category=${category}">${category}</a>
									</li>
								</#list>
								<li role="presentation" class="divider"></li>
								<li role="presentation"><a role="menuitem" tabindex="-1" href="/secure/material">All Items</a></li>
							</ul>
						</div>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th><a href="/secure/material?category=${(RequestParameters.category)!}&field=cat">Catergory</a></th>
										<th><a href="/secure/material?category=${(RequestParameters.category)!}&field=name">Name</a></th>
										<th><a href="/secure/material?category=${(RequestParameters.category)!}&field=cost">Cost</a></th>
										<th><a href="/secure/material?category=${(RequestParameters.category)!}&field=price">Price</a></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<#list materials as material>
										<tr>

											<td>${(material.cat)!}</td>
											<td>${(material.name)!}</td>
											<td>${(material.cost)!}</td>
											<td>${(material.price)!}</td>

											<td>
												<a href="/secure/material/${(material.id)!}"
												   class="btn btn-xs btn-primary">
													<i class="fa fa-pencil"></i>
												</a>
												<a href="#" class="btn btn-danger btn-xs" data-id="${(material.id)!}"
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

		<div class="modal fade" id="deleteCheck" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Are you sure?</h4>
					</div>
					<div class="modal-body">
						Permantly remove material? This action cannot be undone.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-md pull-left" data-dismiss="modal">No, Cancel
						</button>
						<span id="delete">
							<form role="form" method="post" action="/secure/material/{id}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" class="btn btn-primary btn-md">Yes, Remove Material</button>
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
