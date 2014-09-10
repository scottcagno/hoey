<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Hoey Enterprises</title>
        <#include "stubs/header.ftl">
	</head>
	<body id="body">

        <!-- navbar -->		
        <div id="navbar" class="navbar navbar-default navbar-static-top navbar-inverse">
        	<div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
        	            <span class="icon-bar"></span>
        				<span class="icon-bar"></span>
        				<span class="icon-bar"></span>
        			</button>
        			<a class="navbar-brand" href="#">Hoey Enterprises</a>
        		</div>
        		<div class="collapse navbar-collapse navbar-ex1-collapse">
        			<ul class="nav navbar-nav navbar-right">
        				<li><a href="/secure/customer">Login</a></li>
        			</ul>
        		</div>
        	</div>
        </div>
        <!-- navbar -->

        <!-- errors -->
        <div class="container">
            <#if alert??>
                <div class="alert alert-info alert-dismissable text-center">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${alert}
                </div>
            <#elseif alertError??>
                <div class="alert alert-danger alert-dismissable text-center">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${alertError}
                </div>
            <#elseif alertSuccess??>
                <div class="alert alert-success alert-dismissable text-center">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${alertSuccess}
                </div>
            </#if>
        </div>
        <!-- errors -->

        <!-- content -->
        <div class="jumbotron">
            <div class="container">
                <span class="pull-left col-lg-7">
                    <img class="img-responsive logo" src="/static/img/logo.png"/>
                </span>
                <span class="pull-right col-lg-4">
                    <p class="lead">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                        labore et dolore magna aliqua.
                    </p>
                </span>
                <br/><br/><br/>
                <span class="col-lg-12">
                    <p class="text-muted">
                        <small>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                            labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
                            laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
                            voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
                            cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        </small>
                    </p>
                </span>
            </div>
        </div>
        <!-- content -->

        <#include "stubs/footer.ftl">

        <#include "stubs/scripts.ftl">

	</body>
</html>
