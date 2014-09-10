<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Login Page</title>
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
                    <li><a href="/">Cancel</a></li>
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
    <div class="container">
        <div class=" col-lg-4 col-lg-offset-4">
            <div id="login" class="panel panel-default">
                <div class="panel-heading">
                    Please Login
                </div>
                <div class="panel-body">
                    <form role="form" method="post" action="/login">
                        <div class="form-group">
                        <span class="text-danger">
                        ${(RequestParameters.error??)?string('There has been an error logging you in.<br/><br/>','')}
                        </span>
                            <input type="text" name="username" class="form-control" placeholder="Username" autofocus="true" required="true"/>
                        </div>
                        <div class="form-group">
                            <input type="password" name="password" class="form-control" placeholder="Password" required="true"/>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button class="btn btn-md btn-block btn-primary" type="submit">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- content-->

    <#include "stubs/footer.ftl">

    <#include "stubs/scripts.ftl">

	</body>
</html>
