<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Landing Page</title>
        <#include "stubs/header.ftl">
	</head>
	<body id="body">

		<#include "stubs/navbar.ftl">

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
        <div class="container">
            <div class="col-sm-4 text-center">
                <h4><i class="fa fa-code fa-5x"></i></h4><br/>
                <div class="panel panel-default">
                    <div class="panel-body">
                        <p>
                            The real challange in developing bespoke software is to combine the 'instant turnaround' you get
                            with an off-the-shelf solution with the obvious tailored nature that custom software offers.
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-sm-4 text-center">
                <h4><i class="fa fa-cogs fa-5x"></i></h4><br/>
                <div class="panel panel-default">
                    <div class="panel-body">
                        <p>
                            Most off-the-shelf software simply echos a successful bespoke design pattern in mass quantity.
                            The only way to accomplish this is to generalize the solution in order for it to 'fit' a wider range
                            of users.
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-sm-4 text-center">
                <h4><i class="fa fa-check-circle-o fa-5x"></i></h4><br/>
                <div class="panel panel-default">
                	<div class="panel-body">
                        <p>
                            Taking a pre-existing software design and generalizing it to fit a wider userbase comes with the same
                            interesting caveat as a 'one size fits all' glove has.  The question is does it really fit?
                        </p>
                	</div>
                </div>
            </div>
        </div>
        <!-- content -->

        <#include "stubs/footer.ftl">

	</body>
</html>
