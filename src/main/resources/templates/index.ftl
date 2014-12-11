<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Shock & Awe</title>
        <#include "stubs/header.ftl"/>
	</head>
	<body>
        <!-- navbar -->
        <div id="navbar" class="navbar navbar-default navbar-static-top">
        	<div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
        	            <span class="icon-bar"></span>
        				<span class="icon-bar"></span>
        				<span class="icon-bar"></span>
        			</button>
        			<a class="navbar-brand" href="/">Welcome</a>
        		</div>
        		<div class="collapse navbar-collapse navbar-ex1-collapse">
        			<ul class="nav navbar-nav navbar-right">
        				<li><a href="/secure/customer">Secure Login</a></li>
        			</ul>
        		</div>
        	</div>
        </div>
        <!-- navbar -->

        <!-- content -->
        <div class="container">
			<div class="row">
				<div class="jumbotron">
					<div class="col-xs-12 col-md-2 col-lg-3">
						<img style="margin:auto;" src="/static/img/logo.jpg" class="img-responsive text-center"/>
					</div>
					<div class="col-xs-12 col-md-10 col-lg-9">
						<h1 class="cursive">
							Shock & Awe Electric
						</h1>
						<p class="cursive text-muted">
							Quality service with integrity
						</p>
						<h3>
							<a class="label label-primary" href="mailto:hoeyenterprises@yahoo.com?subject=Job Inquiry">
								Contact Shock & Awe Electric
							</a>
						</h3>
					</div>
				</div>
			</div>
			<br/><br/>
			<div class="row">
				<div class="col-lg-4 col-md-4">
					<h3>
						About Us <br/>
						<small>
							Shock & Awe Electric provides both Residential and Commercial Electrical Contracting.
                            Serving Lancaster County and surrounding areas with Quality Service at a fair price.
						</small>
					</h3>
				</div>
				<div class="col-lg-4 col-md-4">
					<h3>
						Our Mission <br/>
						<small>
							Serving within the electrical industry with quality and integrity. Giving the
							client excellence in job performance and results, at a fair price. Going the
							extra mile to ensure that the customer's needs and desires have been met.
						</small>
					</h3>
				</div>
                <div class="col-lg-4 col-md-4">
					<h3>
						Contact Us <br/>
						<small>
							Steve Hoey Owner/Electrician <br/>
							1515 Eden Road Lancaster, PA 17601 <br/>
							(717) 799-8041 <br/>
							<a href="mailto:hoeyenterprises@yahoo.com?subject=Job Inquiry">
								hoeyenterprises@yahoo.com
							</a>
						</small>
					</h3>
				</div>
			</div>
		</div>
	<#include "stubs/footer.ftl"/>
	<#include "stubs/scripts.ftl"/>
	</body>
</html>
