<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Login Page</title>
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
                <span class="pull-left col-xs-4">
                    ${(error)!}
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
                </span>
            </div>
        </div>
        <!-- content -->

        <#include "stubs/footer.ftl">

	</body>
</html>
