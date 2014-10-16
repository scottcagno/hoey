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
			<div class="row">
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
									<input type="number" step="any" id="cost" name="cost" class="form-control"
									       placeholder="Cost" required="true" value="${(material.cost?c)!}"/>
								</div>
								<div class="checkbox row">
									<div class="col-xs-6">
										<label>
											<input name="markup" value="true" type="checkbox"
											${(material??)?string((material?? && material.markup == true)?string('checked', ''),'checked')}
											> Add global markup
										</label>
									</div>
									<div class="col-xs-6">
										<label>
											<input name="taxed" value="true" type="checkbox"
											${(material??)?string((material?? && material.taxed == true)?string('checked', ''),'checked')}
											> Taxed
										</label>
									</div>
								</div>
								<input type="hidden" name="id" value="${(material.id)!}"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button class="btn btn-md btn-primary btn-block" type="submit">Add Material</button>
								<#if material?? >
									<hr/>
									<a href="#" class="btn btn-danger btn-block" data-id="${(material.id)!}" data-toggle="modal" data-target="#deleteCheck">
										Delete
									</a>
								</#if>
							</form>
						</div>
					</div>
				</div>
				<!-- add/edit -->

				<!-- view all -->
				<div class="col-lg-8 col-md-8">
					<div class="panel panel-default">
						<div class="panel-heading col-xs-12">
							<span class="hidden-xs">Current Materials</span>
							<div class="dropdown pull-right col-xs-12 col-sm-4">
								<button class="btn btn-default btn-block dropdown-toggle" type="button" id="categoryFilter" data-toggle="dropdown">
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
						<div class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th><a href="/secure/material?category=${(RequestParameters.category)!}&field=cat">Category</a></th>
										<th><a href="/secure/material?category=${(RequestParameters.category)!}&field=name">Name</a></th>
										<th><a href="/secure/material?category=${(RequestParameters.category)!}&field=cost">Cost</a></th>
										<th>Global Markup</th>
										<th>Taxed</th>
										<th class="text-primary">Edit</th>
									</tr>
								</thead>
								<tbody>
									<#list materials as material>
										<tr>
											<td>${(material.cat)!}</td>
											<td>${(material.name)!}</td>
											<td>${(material.cost?string.currency)!}</td>
											<td>${(material.markup)?string('Yes', 'No')}</td>
											<td>${(material.taxed)?string('Yes', 'No')}</td>
											<td>
												<a href="/secure/material/${(material.id)!}" class="btn btn-sm btn-primary">
													<i class="fa fa-pencil"></i>
												</a>
											</td>
										</tr>
										</a>
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
