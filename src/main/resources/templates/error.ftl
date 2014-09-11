<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Error Page</title>
        <#include "stubs/header.ftl">
	</head>
	<body id="body">

        <#include "stubs/navbar.ftl">

        <!-- content -->
        <div id="content" class="container">
            <div class="col-lg-10 col-lg-offset-1 col-md-10 col-md-offset-1">
            <legend>${(error)!} <span class="text-danger">${(message)!}</span></legend>
            <pre>${(exception)!'An unknown error has occoured. That really sucks.'}</pre>
            </div>
        </div>
        <!-- content -->

        <#include "stubs/footer.ftl">

	</body>
</html>
