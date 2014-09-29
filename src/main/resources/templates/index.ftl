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
        			<a class="navbar-brand" href="#">Shock & Awe Electric</a>
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
        <div class="container">
            <span class="pull-left col-lg-8 col-md-8">
                <img class="img-responsive img-thumbnail" src="/static/img/logo.jpg"/>
            </span>
            <span class="pull-right col-lg-4 col-md-4">
                <h2 class="cursive">
                    Shock & Awe Electric <br/>
                    <small>Quality Service with Integrity</small>
                </h2>
                <p class="lead">
                    Residential and Commercial Electrical Contracting. Serving Lancaster County and surrounding
                    areas with Quality Service at a fair price.
                </p>
            </span>
        </div>
        <br/><br/>

        <div class="container">
            <span class="col-lg-4">
                <blockquote>
                    <p class="lead">Our Mission</p>
                    <footer>
                        Serving within the electrical industry with quality and integrity. Giving the client
                        excellence in job performance and results, at a fair price. Going the extra mile to ensure
                        that the customer's needs and desires have been met.
                    </footer>
                </blockquote>
            </span>
            <span class="col-lg-4">
                <blockquote>
                    <p class="lead">Testimonials</p>
                    <footer>
                        Great work and super nice guy. Did a wonderful job wiring the new shed and installing a new
                        chandelier in the house. Reasonable, too. &nbsp; ~Thanks, Steve!
                    </footer>
                </blockquote>
            </span>
            <span class="col-lg-4">
                <blockquote>
                    <p class="lead">Contact</p>
                    <footer>
                        Hoey Enterprises, LLC <br/>
                        Steve Hoey Owner/Electrician <br/>
                        1515 Eden Road Lancaster, PA 17601 <br/>
                        (717) 799-8041 <br/>
                        <a href="mailto:hoeyenterprises@yahoo.com">hoeyenterprises@yahoo.com</a>
                    </footer>
                </blockquote>
            </span>
        </div>
        <!-- content -->

        <#include "stubs/footer.ftl">

        <#include "stubs/scripts.ftl">

	</body>
</html>
