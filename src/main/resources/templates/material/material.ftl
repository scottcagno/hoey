<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Materials</title>
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
									<span class="text-error">${(errors.cat)!}</span>
									<input type="text" id="cat" name="cat" class="form-control"
									       placeholder="Category" required="true" value="${(material.cat)!}"/>
								</div>
								<div class="form-group">
									<span class="text-error">${(errors.name)!}</span>
									<input type="text" id="name" name="name" class="form-control"
									       placeholder="Name" required="true" value="${(material.name)!}"/>
								</div>
								<div class="form-group">
									<span class="text-error">${(errors.cost)!}</span>
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
								<input type="hidden" name="id" value="${(material.id?c)!}"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button class="btn btn-md btn-primary btn-block" type="submit">Save Material</button>
								<#if material?? && material.id??>
									<hr/>
									<!-- delete material trigger -->
									<a href="#delete-item-confirm" id="delete-item" data-id="/secure/material/${material.id?c}"
									   class="btn btn-md btn-danger btn-block" style="cursor:pointer;">
										<i class="fa fa-trash-o"></i> Delete
									</a>
									<!-- delete material trigger -->
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
						<div class="hidden-xs hidden-sm">
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
													<a href="/secure/material/${(material.id?c)!}" class="btn btn-sm btn-primary">
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
						<div class="visible-xs-block visible-sm-block">
							<div class="panel-body">
								<br/>
								<div class="list-group">
									<#list materials as material>
										<a href="/secure/material/${(material.id?c)!}" class="list-group-item">
											<strong>${(material.cat)!} : ${(material.name)!}</strong> <br/>
											Cost: ${(material.cost?string.currency)!} <br/>
											Markup/Taxed: ${(material.markup)?string('Yes', 'No')} / ${(material.taxed)?string('Yes', 'No')} <br/>
										</a>
									</#list>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		<!-- view all -->
		</div>
		<!-- content -->
		<#include "../stubs/footer.ftl"/>
		<#include "../stubs/scripts.ftl"/>
		<script src="/static/js/delete-item.js"></script>
	</body>
</html>
