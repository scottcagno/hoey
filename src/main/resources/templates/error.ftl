<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Error Page</title>
        <#include "stubs/header.ftl"/>
	</head>
	<body id="body">

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
                        <li><a href="/">Home</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- content -->
        <div id="content" class="container">
            <div class="col-lg-10 col-lg-offset-1 col-md-10 col-md-offset-1">
            <h2>${(error)!} <span class="text-danger">${(message)!}</span></h2>
            </div>

            <!-- content -->

            <#include "stubs/scripts.ftl"/>

        </div>
    <#include "stubs/footer.ftl"/>
	</body>
</html>
