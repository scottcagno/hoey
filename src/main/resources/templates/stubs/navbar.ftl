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
				<li><a href="/secure/customer">All Customers</a></li>
				<li><a href="/secure/job">All Jobs</a></li>
				<li><a href="/secure/material">Materials</a></li>
				<li><a href="/secure/company">Settings</a></li>
                <li><a href="/logout">Logout</a></li>
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