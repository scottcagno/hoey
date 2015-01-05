<!doctype html>
<html lang="en-US" style="font-family: 'Noto Sans', sans-serif;font-size: 14px; color:#777;">
	<head>
		<meta charset="utf-8">
	</head>
	<body>
		<div style="margin: 25px;">
			<div style="width:600px;margin:0 auto;background-color:#f5f6f5;border:1px solid #dddddd;border-radius:5px;-moz-border-radius:5px;-webkit-border-radius:5px;">
                <div style="padding-left:15px;padding-right:15px;">
                    <table cellpadding="10">
                        <tr>
                            <td colspan="3">
                                <h1>ESTIMATE</h1>
                            </td>
                        </tr>
						<tr>
							<td style="font-weight:700;" colspan="2">To:</td>
							<td>${customer.name!'John Doe'}: <a href="mailto:${customer.email!'user@example.com'}">${customer.email!'user@example.com'}</a></td>
						</tr>
						<tr>
							<td style="font-weight:700;" colspan="2">Re:</td>
							<td>${customer.street!'123 Example Street'}, ${customer.city!'Some City'} ${customer.state!'ST'}</td>
						</tr>
						<tr>
							<td style="font-weight:700;" colspan="2">From:</td>
							<td>Shock & Awe Electric, Steve Hoey</td>
						</tr>
						<tr>
							<td style="font-weight:700;" colspan="2">Date:</td>
							<td>${.now?date}</td>
						</tr>
                    </table>
					<hr style="width:97%;"/>


                    <div id="heading" style="padding:10px;">
                        <div style="float:left;width:49%;">
                            <strong>From:</strong> <br/>
                            ${company.company!} <br/>
                            ${company.street!} <br/>
                            ${company.city!}, ${company.state!} ${company.zip!} <br/>
                            ${company.phone!}
                        </div>
                        <div style="text-align:right;">
                            <strong>To:</strong> <br/>
                            ${customer.name!} <br/>
                            ${customer.company!} <br/>
                            ${customer.email!} <br/>
                            ${customer.phone!}
                        </div>
                    </div>
                    <h3 style="text-align:center;">Proposal ID: ${job.name!}</h3>
                    <p style="text-align:center;">
                        This proposal was send out on ${.now?string}. Details can be found below.
                    </p>
                    <table style="width:100%; border:1px solid #999; border-collapse:collapse; margin-top:25px;">
                        <thead style="background-color:#ddd;font-weight:700;">
                            <tr style="border-bottom:1px solid #999;">
                                <td style="border-left:1px solid #999;padding:5px;">Rooms</td>
                                <td style="border-left:1px solid #999;padding:5px;">Cost</td>
                            </tr>
                        </thead>
                        <tbody>
                            <#list job.rooms as room>
                                <tr style="border-bottom:1px solid #999;">
                                    <td style="border-left:1px solid #999;padding:5px;">
                                        ${room.name!}
                                    </td>
                                    <td style="border-left:1px solid #999;padding:5px;">
                                        $${room.total!c}
                                    </td>
                                </tr>
                            </#list>
                            <tr style="border-bottom: 1px solid #999;">
                                <td>&nbsp;</td>
                                <td style="border-left:1px solid #999;">&nbsp;</td>
                            </tr>
                            <thead style="background-color:#ddd;font-weight:700;">
                                <tr style="border-bottom:1px solid #999;">
                                    <td style="border-left:1px solid #999;padding:5px;">Room Count</td>
                                    <td style="border-left:1px solid #999;padding:5px;">Job Total</td>
                                </tr>
                            </thead>
                            <tr style="border-bottom:1px solid #999;">
                                <td style="border-left:1px solid #999;padding:5px;">
                                    ${job.rooms?size} ${(job.rooms?size > 1)?string('Rooms','Room')}
                                </td>
                                <td style="border-left:1px solid #999;padding:5px;">
                                    $${job.total!c}
                                </td>
                            </tr>
                        </tbody>
                    </table>
					<p style="text-align:center;font-weight:900;">
						This is a no reply address, please send all replies to
						<a href="mailto:hoeyenterprises@yahoo.com?subject=Re:Job Proposal ${job.name}">
							hoeyenterprises@yahoo.com
						</a>
					</p>
                    <p style="font-weight:100;font-size:11px;text-align:center;">
                        <em>
                            **All taxes and labor rates have been added where applicible and have been included
                            in the job total.
                        </em>
                    </p>
                    <p style="font-weight:100;font-size:11px;text-align:center;">
                        <em>
                            **If you received this email in error, please delete it;
                            we apologize for the inconvenience.
                        </em>
                    </p>
				</div>
			</div>
		</div>
	</body>
</html>