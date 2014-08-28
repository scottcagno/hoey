<div id="navbar" class="navbar navbar-default navbar-static-top navbar-inverse">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/"><i class="fa fa-home"></i> Home</a>
		</div>
		<div class="collapse navbar-collapse navbar-ex1-collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="/secure/login?forward=customer">All Customers</a></li>
				<li><a href="/secure/login?forward=job">All Jobs</a></li>
				<#if authenticated??>
					<li><a href="/logout"><i class="fa fa-unlock"></i> Logout (${authenticated})</a></li>
				<#else/>
					<li><a href="/secure/login?forward=user"><i class="fa fa-user"></i> Login</a></li>
				</#if>
			</ul>
		</div>
	</div>
</div>

<div class="container">
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