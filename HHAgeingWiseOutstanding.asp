<%@ Enablesessionstate=true%>
<% language="VBScript" %>
<% Response.Expires=0%>
<!--#include file = "HHCommon.asp"-->
<%
dim buttonAct,RevFrom,RevTo,url,DataString

buttonAct	=	request("button")
RevFrom		=	request("RevFrom")
RevTo		=	request("RevTo")
YearSel	=	year(date)

If RevFrom <> "" And RevTo <> "" Then 
Else
	RevFrom	=	"01-JAN-"&YearSel&"" 
	RevTo	=	"31-DEC-"&YearSel&""
End If 

If buttonAct = "GetDataRev" Then
		
		TotString=""	
		
		STRSQL ="SELECT SUM (OS_AMOUNT_15) AS OS_AMOUNT_15, SUM (OS_AMOUNT_30) AS OS_AMOUNT_30, SUM (OS_AMOUNT_60) AS OS_AMOUNT_60, SUM (OS_AMOUNT_90) AS OS_AMOUNT_90, SUM (OS_AMOUNT_120) AS OS_AMOUNT_120, SUM (OS_AMOUNT_ABOVE_120) AS OS_AMOUNT_ABOVE_120, SUM (UNMATCHED_CREDIT) AS UNMATCHED_CREDIT FROM (SELECT CASE WHEN OS_DATE <= 15 THEN SUM (UNMATCHED_DEBIT) / 100 ELSE 0 END AS OS_AMOUNT_15, CASE WHEN OS_DATE > 15 AND OS_DATE <= 30 THEN SUM (UNMATCHED_DEBIT) / 100 ELSE 0 END AS OS_AMOUNT_30, CASE WHEN OS_DATE > 30 AND OS_DATE <= 60 THEN SUM (UNMATCHED_DEBIT) / 100 ELSE 0 END AS OS_AMOUNT_60, CASE WHEN OS_DATE > 60 AND OS_DATE <= 90 THEN SUM (UNMATCHED_DEBIT) / 100 ELSE 0 END AS OS_AMOUNT_90, CASE WHEN OS_DATE > 90 AND OS_DATE <= 120 THEN SUM (UNMATCHED_DEBIT) / 100 ELSE 0 END AS OS_AMOUNT_120, CASE WHEN OS_DATE > 120 THEN SUM (UNMATCHED_DEBIT) / 100 ELSE 0 END AS OS_AMOUNT_ABOVE_120, SUM (UNMATCHED_CREDIT) / 100 AS UNMATCHED_CREDIT FROM (SELECT FAM.DESCRIPTION, FM.ACCOUNTING_YEAR_ID, FD.ACCOUNT_HEAD_ID, FM.LOCATION_ID, FM.TXN_ID, FM.TXN_TYPE_ID, FM.DOCUMENT_REF_NO AS VOUCHER_NO, TO_CHAR (FM.TXN_DATE, 'DD-MON-YYYY' ) AS REFERENCE_DATE, NVL ((SUM (ABS (AMOUNT) - AMOUNT) / 2), 0 ) AS INVOICE_AMT, NVL (( SUM ( ABS (UNMATCHED_AMOUNT) - UNMATCHED_AMOUNT ) / 2 ), 0 ) AS OUTSTANDING_AMT, NVL (SUM ( ( ABS (UNMATCHED_AMOUNT) - UNMATCHED_AMOUNT ) / 2 ), 0 ) AS UNMATCHED_DEBIT, NVL (SUM ( ( ABS (UNMATCHED_AMOUNT) + (UNMATCHED_AMOUNT) ) / 2 ), 0 ) AS UNMATCHED_CREDIT, NVL (SUM ((ABS (AMOUNT) - AMOUNT) / 2), 0 ) AS ORIGINAL_DEBIT, NVL (SUM ((ABS (AMOUNT) + (AMOUNT)) / 2), 0 ) AS ORIGINAL_CREDIT, BL_NUMBER, INVOICE_NUMBER, FOD.OPRTR_CODE, VOYAGE_ID, FAM.SUB_GROUP_ID, ( (TRUNC (SYSDATE) - TRUNC (TXN_DATE)) - NVL((SELECT CREDIT_DAYS FROM FAS_CUSTOMER_CREDIT_LIMIT CL WHERE CL.ACCOUNT_HEAD_ID = FD.ACCOUNT_HEAD_ID),0) ) AS OS_DATE FROM FA_TXN_MASTER FM, FA_TXN_DETAIL FD, (SELECT ACCOUNTING_YEAR_ID, TXN_TYPE_ID, LOCATION_ID, TXN_ID, ACCOUNT_HEAD_ID, SERIAL_NO, SUM (UNMATCHED_AMOUNT) AS UNMATCHED_AMOUNT FROM (SELECT FABMI.ACCOUNTING_YEAR_ID, FABMI.TXN_TYPE_ID, FABMI.LOCATION_ID, FABMI.TXN_ID, FABMI.ACCOUNT_HEAD_ID, FABMI.SERIAL_NO, FATD.AMOUNT AS UNMATCHED_AMOUNT FROM FA_BILL_MATCHING_INDEX FABMI, FA_TXN_DETAIL FATD, FA_TXN_MASTER FATM WHERE FABMI.ACCOUNTING_YEAR_ID = FATD.ACCOUNTING_YEAR_ID AND FABMI.TXN_TYPE_ID = FATD.TXN_TYPE_ID AND FABMI.LOCATION_ID = FATD.LOCATION_ID AND FABMI.TXN_ID = FATD.TXN_ID AND FABMI.ACCOUNT_HEAD_ID = FATD.ACCOUNT_HEAD_ID AND FABMI.SERIAL_NO = FATD.SERIAL_NO AND FATD.ACCOUNTING_YEAR_ID = FATM.ACCOUNTING_YEAR_ID AND FATD.TXN_TYPE_ID = FATM.TXN_TYPE_ID AND FATD.LOCATION_ID = FATM.LOCATION_ID AND FATD.TXN_ID = FATM.TXN_ID AND FATM.TXN_DATE <= TO_DATE ('25-MAY-2017 0:0:0', 'DD-MON-YYYY HH24:MI:SS' ) UNION ALL SELECT FABMD.CR_ACCOUNTING_YEAR_ID, FABMD.CR_TXN_TYPE_ID, FABMD.CR_LOCATION_ID, FABMD.CR_TXN_ID, FABMD.ACCOUNT_HEAD_ID, FABMD.CR_SERIAL_NO, (AMOUNT) * -1 AS MATCH_AMOUNT FROM FA_BILL_MATCHING_DETAIL FABMD, FA_TXN_MASTER FTMC, FA_TXN_MASTER FTMD WHERE FABMD.CR_ACCOUNTING_YEAR_ID = FTMC.ACCOUNTING_YEAR_ID AND FABMD.CR_TXN_TYPE_ID = FTMC.TXN_TYPE_ID AND FABMD.CR_LOCATION_ID = FTMC.LOCATION_ID AND FABMD.CR_TXN_ID = FTMC.TXN_ID AND FABMD.DB_ACCOUNTING_YEAR_ID = FTMD.ACCOUNTING_YEAR_ID AND FABMD.DB_TXN_TYPE_ID = FTMD.TXN_TYPE_ID AND FABMD.DB_LOCATION_ID = FTMD.LOCATION_ID AND FABMD.DB_TXN_ID = FTMD.TXN_ID AND FTMC.TXN_DATE <= TO_DATE ('25-MAY-2017 0:0:0', 'DD-MON-YYYY HH24:MI:SS' ) AND FTMD.TXN_DATE <= TO_DATE ('25-MAY-2017 0:0:0', 'DD-MON-YYYY HH24:MI:SS' ) UNION ALL SELECT FABMD.DB_ACCOUNTING_YEAR_ID, FABMD.DB_TXN_TYPE_ID, FABMD.DB_LOCATION_ID, FABMD.DB_TXN_ID, FABMD.ACCOUNT_HEAD_ID, FABMD.DB_SERIAL_NO, (AMOUNT) AS MATCH_AMOUNT FROM FA_BILL_MATCHING_DETAIL FABMD, FA_TXN_MASTER FTMC, FA_TXN_MASTER FTMD WHERE FABMD.CR_ACCOUNTING_YEAR_ID = FTMC.ACCOUNTING_YEAR_ID AND FABMD.CR_TXN_TYPE_ID = FTMC.TXN_TYPE_ID AND FABMD.CR_LOCATION_ID = FTMC.LOCATION_ID AND FABMD.CR_TXN_ID = FTMC.TXN_ID AND FABMD.DB_ACCOUNTING_YEAR_ID = FTMD.ACCOUNTING_YEAR_ID AND FABMD.DB_TXN_TYPE_ID = FTMD.TXN_TYPE_ID AND FABMD.DB_LOCATION_ID = FTMD.LOCATION_ID AND FABMD.DB_TXN_ID = FTMD.TXN_ID AND FTMC.TXN_DATE <= TO_DATE ('25-MAY-2017 0:0:0', 'DD-MON-YYYY HH24:MI:SS' ) AND FTMD.TXN_DATE <= TO_DATE ('25-MAY-2017 0:0:0', 'DD-MON-YYYY HH24:MI:SS' )) GROUP BY ACCOUNTING_YEAR_ID, TXN_TYPE_ID, LOCATION_ID, TXN_ID, ACCOUNT_HEAD_ID, SERIAL_NO) FBI, FA_TXN_OPS_DETAIL FOD, FA_ACCOUNT_HEAD_MASTER FAM WHERE FM.ACCOUNTING_YEAR_ID = FD.ACCOUNTING_YEAR_ID AND FM.TXN_ID = FD.TXN_ID AND FM.TXN_TYPE_ID = FD.TXN_TYPE_ID AND FM.LOCATION_ID = FD.LOCATION_ID AND FD.ACCOUNT_HEAD_ID = FOD.ACCOUNT_HEAD_ID(+) AND FD.ACCOUNTING_YEAR_ID = FOD.ACCOUNTING_YEAR_ID(+) AND FD.TXN_ID = FOD.TXN_ID(+) AND FD.TXN_TYPE_ID = FOD.TXN_TYPE_ID(+) AND FD.LOCATION_ID = FOD.LOCATION_ID(+) AND FD.SERIAL_NO = FOD.SERIAL_NO(+) AND FD.ACCOUNT_HEAD_ID = FBI.ACCOUNT_HEAD_ID AND FD.TXN_ID = FBI.TXN_ID AND FD.TXN_TYPE_ID = FBI.TXN_TYPE_ID AND FD.ACCOUNTING_YEAR_ID = FBI.ACCOUNTING_YEAR_ID AND FD.LOCATION_ID = FBI.LOCATION_ID AND FAM.SUB_GROUP_ID IN ('85') AND FD.SERIAL_NO = FBI.SERIAL_NO AND FD.ACCOUNT_HEAD_ID = FAM.ACCOUNT_HEAD_ID AND FBI.UNMATCHED_AMOUNT <> 0 AND FM.TXN_DATE BETWEEN TO_DATE ('01-JAN-1900', 'DD-MON-YYYY' ) AND TO_DATE ('26-MAY-2017', 'DD-MON-YYYY' ) AND FD.LOCATION_ID IN ('MHO') GROUP BY FAM.DESCRIPTION, FM.ACCOUNTING_YEAR_ID, FM.TXN_ID, FM.TXN_TYPE_ID, FM.TXN_DATE, FD.ACCOUNT_HEAD_ID, BL_NUMBER, INVOICE_NUMBER, FM.DOCUMENT_REF_NO, FOD.OPRTR_CODE, VOYAGE_ID, FM.LOCATION_ID, FAM.SUB_GROUP_ID ORDER BY FAM.DESCRIPTION, FM.TXN_DATE, FM.LOCATION_ID, FM.TXN_ID, FM.TXN_TYPE_ID, FM.DOCUMENT_REF_NO, FD.ACCOUNT_HEAD_ID, FAM.SUB_GROUP_ID) WHERE 1 = 1 GROUP BY OS_DATE) FAS_DATA WHERE 1 = 1" 



	Set Rs = VScompDAAgencyFA.Get_RecordSet(CStr(STRSQL))
		Count = rs.recordcount
		XX=0  	
		
	  
			while Not Rs.eof
	   
				Os_15Days	=	RS("OS_AMOUNT_15")
				Os_30Days	=	RS("OS_AMOUNT_30")
				Os_60Days	=	RS("OS_AMOUNT_60")
				Os_90Days	=	RS("OS_AMOUNT_90")
				Os_120Days	=	RS("OS_AMOUNT_120")
				Above_Os_120Days	=	RS("OS_AMOUNT_ABOVE_120")
				
'				Os_30Days="65800.00"
'				Os_60Days="54000.00"
'				Os_90Days="29000.00"
'				Os_120Days="45604.00"
'				Above_Os_120Days="45824.00"
				
					TotString =  "{""days"": ""15 Days"",""amount"": """&Os_15Days&"""},{""days"": ""30 Days"",""amount"": """&Os_30Days&"""},{""days"": ""60 Days"",""amount"": """&Os_60Days&"""},{""days"": ""90 Days"",""amount"": """&Os_90Days&"""},{""days"": ""120 Days"",""amount"": """&Os_120Days&"""},{""days"": ""Above 120 Days"",""amount"": """&Above_Os_120Days&"""}"

		XX=CDbl(XX)+1
	
			Rs.Movenext
				wend
				Rs.close
	Set Rs = Nothing
	response.write TotString
	response.end	

End If				
%>
    <!-- Page Loder Start -->
    <script>document.onreadystatechange = function () { var state = document.readyState; if (state == 'complete') { setTimeout(function () { document.getElementById('interactive'); document.getElementById('load').style.visibility = "hidden"; document.getElementById('contents').style.visibility = "visible"; }, 1200); } }</script>
    <style>
        #load {
            width: 100%;
            height: 100%;
			overflow:hidden;
            z-index: 11111;
            position: fixed;
            background: url("assets/img/cube.gif") no-repeat center center rgb(255, 255, 255);
			background-size: 460px;
			
        }
    </style>
    <!-- Page Loder End -->
    <div id="load"></div><div id="contents" style="visibility:hidden;">
<% Call CommonHeader%> 

<div class="container" style="margin-top:45px;">

		<div class="col-md-12">
			<div class="panel-group">
				<div class="panel panel-default">
					<div class="panel-heading panelopen">
						<a role="button" data-toggle="collapse" href="#MonthWiseForm" aria-expanded="true" aria-controls="Input">
							Ageing Wise Outstanding
						</a>
					</div>
					<div id="MonthWiseForm" class="panel-body panel-collapse collapse in">
						<form class="form-horizontal" name="frm" method="post">
							<div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
								<div class="form-group">
									<label class="control-label col-xs-5" for="NormalInput">Input</label>
									<div class="col-xs-7">
										<input type="text" class="form-control" id="NormalInput" />
									</div>
								</div>
							</div>
							<div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
								<div class="form-group">
									<label class="control-label col-xs-5" for="RevFrom">Revenue From</label>
									<div class="col-xs-7">
										<input type="text" class="form-control datepicker" name="RevFrom" id="RevFrom" value="<%=RevFrom%>" />
									</div>
								</div>
							</div>
							<div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
								<div class="form-group">
									<label class="control-label col-xs-5" for="RevTo">Revenue To</label>
									<div class="col-xs-7">
										<input type="text" class="form-control datepicker" name="RevTo" id="RevTo" value="<%=RevTo%>" />
									</div>
								</div>
							</div>
							<div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
								<div class="form-group">
									<label class="control-label col-xs-5" for="NormalInput">Input</label>
									<div class="col-xs-7">
										<input type="text" class="form-control" id="NormalInput" />
									</div>
								</div>
							</div>
							<div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
								<div class="form-group">
									<label class="control-label col-xs-5" for="NormalInput">Input</label>
									<div class="col-xs-7">
										<input type="text" class="form-control" id="NormalInput" />
									</div>
								</div>
							</div>
							<div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
								<div class="form-group">
									<label class="control-label col-xs-5" for="SingleSelect">Single Select</label>
									<div class="col-xs-7">
										<select class="single-select" id="SingleSelect" onchange="alert('Selected value is : '+$(this).val())">
											<option value="Option A">Option A</option>
											<option value="Option B">Option B</option>
											<option value="Option C">Option C</option>
											<option value="Option D">Option D</option>
											<option value="Option E">Option E</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
								<div class="form-group">
									<label class="control-label col-xs-5" for="MultiSelect">Multi Select</label>
									<div class="col-xs-7">
										<select class="multi-select" multiple="multiple" id="MultiSelect" placeholder="Select multiple option" onchange="alert('Selected values are : '+$(this).val())">
											<option value="Option A">Option A</option>
											<option value="Option B">Option B</option>
											<option value="Option C">Option C</option>
											<option value="Option D">Option D</option>
											<option value="Option E">Option E</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-lg-3 col-md-4 col-sm-4 col-xs-6 text-right">
								<button type="button" onclick="RevModeWise()">Go</button>
							</div>
						</form>	
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-8">
			<div class="panel-group">
				<div class="panel panel-default" style="height:420px;">
					<div class="panel-heading panelopen">
						<a role="button" data-toggle="collapse" href="#MonthWiseGraph" aria-expanded="true" aria-controls="Input">
							Overview
						</a>
					</div>
					<div id="MonthWiseGraph" class="panel-body panel-collapse collapse in">
						<div id="chartdiv" style="height:330px;"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="panel-group">
				<div class="panel panel-default" style="height:420px;">
					<div class="panel-heading panelopen">
						<a role="button" data-toggle="collapse" href="#MonthWiseDetail" aria-expanded="true" aria-controls="Input">
							Detailed
						</a>
					</div>
					<div id="MonthWiseDetail" class="panel-body panel-collapse collapse in">
					
					  <div id="example" class="list-table">	
							<form class="form-horizontal">
								<div class="col-xs-12">
									<div class="form-group">
										<label class="control-label col-xs-5" for="search">Search</label>
										<div class="col-xs-7">
											<input type="text" class="form-control search" id="search" />
										</div>
									</div>
								</div>
							</form>							
						<ul class="list-head col-xs-12">
						  <li><div class="col-xs-6">Ageing</div><div class="col-xs-6">Amount in (Rs)</div></li>
						</ul>
						<ul class="list col-xs-12"></ul>
						<ul class="pagination 	col-xs-12"></ul>
					  </div>
					  
					</div>
				</div>
			</div>
		</div>
			
</div>
</div> 
 <script type="text/javascript">		
	

	RevModeWise();
	
	function RevModeWise() {

		PassUrl	=	"<%=url%>?button=GetDataRev&RevFrom="+ $('#RevFrom').val() +"&RevTo="+ $('#RevTo').val() +"&Location=Mumbai";

		$.ajax({
			url: PassUrl, 
			success: function(result){			
				RevData	= eval("[" +  result +"]");

				$('#example ul.list').empty();
				$.each(RevData, function (key, value) {
					$('#example ul.list').append('<li><div class="month col-xs-6">'
					+ value.days 
					+'</div><div class="amount col-xs-6">'
					+( value.amount )
					+'</div></li>')
				});

				new List('example', {
				  valueNames: ['days', 'amount'],
				  page: 10,
				  pagination: true
				});
				
						
				var chart = AmCharts.makeChart( "chartdiv", {
				  "type": "pie",
				  "theme": "light",
				  "dataProvider": RevData,
				  "valueField": "amount",
				  "titleField": "days",
				  "outlineAlpha": 0.1,
				  "depth3D": 12,
				  "balloonText": "[[title]]<br><span style='font-size:10px'><b>Rs.[[amount]]</b></span>",
				  "angle": 40,
				  "export": {
					"enabled": false
				  }
				});


						

			}
		});
		
	}

</script>