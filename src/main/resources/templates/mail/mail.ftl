<!doctype html>
<html lang="en-US" style="font-family: 'Noto Sans', sans-serif;font-size: 14px; color:#777;">
	<head>
		<meta charset="utf-8">
	</head>
	<body>
		<div style="margin: 25px;">
			<div style="width:600px;margin:0px auto;background-color:#f5f6f5;border:1px solid #dddddd;-moz-border-radius:3px;-webkit-border-radius:3px;">
				<div style="padding-left: 27px;padding-right: 27px;padding-bottom: 27px;">
                    <div id="heading" style="border:0px solid #999;margin-top:25px;padding:15px;">
                        <div style="float:left;width:49%;">
                            ${company.company!} <br/>
                            ${company.street!} <br/>
                            ${company.city!}, ${company.state!} ${company.zip!} <br/>
                            ${company.phone!}
                        </div>
                        <div style="text-align:right;">
                            Proposal For: <br/>
                            ${customer.name!} ${customer.company!} <br/>
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