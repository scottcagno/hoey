<!doctype html>
<html lang="en-US" style="font-family: 'Noto Sans', sans-serif;font-size: 14px; color:#777;">
	<head>
		<meta charset="utf-8">
	</head>
	<body>
		<div style="margin: 25px;">
			<div style="width:600px;margin:0 auto;background-color:#f5f6f5;border:1px solid #dddddd;border-radius:5px;-moz-border-radius:5px;-webkit-border-radius:5px;">
                <div style="padding-left:15px;padding-right:15px;">
                    <table cellpadding="10" border="0" style="width:100%;">
                        <tr>
                            <td colspan="3">
                                <h1>ESTIMATE</h1>
                            </td>
                        </tr>
						<tr>
							<td style="font-weight:700;" colspan="2">To:</td>
							<td>${customer.name!}: <a href="mailto:${customer.email!}">${customer.email!}</a></td>
						</tr>
						<tr>
							<td style="font-weight:700;" colspan="2">Re:</td>
							<td>${job.name!}</td>
						</tr>
						<tr>
							<td style="font-weight:700;" colspan="2">From:</td>
							<td>Shock & Awe Electric, Steve Hoey</td>
						</tr>
						<tr>
							<td style="font-weight:700;" colspan="2">Date:</td>
							<td>${.now?date}</td>
						</tr>
                        <tr>
                            <td colspan="3">
								<hr/>
                            </td>
                        </tr>
						<tr>
							<td colspan="3" style="font-weight:700;">
								Shock & Awe Electric proposes to provide the following services:
							</td>
						</tr>
                        <tr>
							<td style="font-weight:700;text-align:right;" colspan="2">-</td>
							<td>${job.notes!}</td>
                        </tr>
						<tr>
							<td style="font-weight:700;text-align:right;" colspan="2">-</td>
							<td>Procure all necessary permits and inspections as required by Boro</td>
						</tr>
						<tr>
							<td style="font-weight:700;text-align:right;" colspan="2">-</td>
							<td>Do all work according to National Electric Code</td>
						</tr>
						<tr>
							<td colspan="3">
								<hr/>
							</td>
						</tr>
						<tr>
							<td colspan="3" style="font-weight:700;text-align:center;">
                                Total Estimate Labor and Material <br/>
                                <span style="font-size:larger;">$${job.total!}</span>
                            </td>
						</tr>
						<tr>
							<td colspan="3" style="text-align:center;">
								<em>
                                    **All work performed by Shock & Awe Electric is guaranteed for one year.
                                </em>
							</td>
						</tr>
                        <tr>
                            <td colspan="3" style="text-align:center;">
								This is a no reply address, please send all replies to
								<a href="mailto:hoeyenterprises@yahoo.com?subject=Re: ${job.name!}">
									hoeyenterprises@yahoo.com
								</a>
                            </td>
                        </tr>
                    </table>
					<br/>
					<br/>
				</div>
			</div>
		</div>
	</body>
</html>