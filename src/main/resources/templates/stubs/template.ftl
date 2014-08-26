<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Template</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">

		<#include "../stubs/navbar.ftl"/>

		<!-- content -->
		<div class="jumbotron">
			<div class="container">
                <span class="pull-left col-sm-8">
                    <img class="img-responsive logo" src="/static/img/logo.png"/>
                    <p class="text-muted">Custom engineered software solutions built specifically for you.</p>
                </span>
                <span class="pull-left">
                    The decision between bespoke or off-the-shelf software is quickly taking priority in
                    todays fast paced business environment.  The need to have better tools, to complete work
                    more efficiently, to avoid possible errors or pitfalls and ultimatly to outperform your
                    competion are what enable your business to succeed.
                </span>
			</div>
		</div>
		<!-- content -->

		<#include "../stubs/footer.ftl"/>

		<#include "../stubs/scripts.ftl"/>

	</body>
</html>
