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
		STRSQL = "SELECT MNTH_YEAR,MNTH_ORDER,NVL(SUM(BASE_CURR_AMOUNT)*-1,0) AS EXPENSES FROM FA_TXN_VIEW WHERE GROUP_ID IN ('"&DIRECT_EXPENSES_GROUP&"')"		
		If Trim(RevFrom) <>"" And Trim(RevTo) <> "" Then 
			STRSQL = STRSQL & " AND TXN_DATE >= TO_DATE('"& RevFrom &"','DD-MON-YYYY') AND TXN_DATE <= TO_DATE('"& RevTo &"','DD-MON-YYYY')"		
		End if
		STRSQL = STRSQL & " GROUP BY MNTH_YEAR,MNTH_ORDER ORDER BY MNTH_ORDER"		

		Set Rs = VScompDAAgencyFA.Get_RecordSet(CStr(STRSQL))
		Count = rs.recordcount
		XX=0  	

			while Not Rs.eof
	   
				MNTHYEAR	=	RS("MNTH_YEAR")
				Amount		=	RS("EXPENSES")

				If Trim(Amount) = "" Or isnull(Amount) Then Amount=0

				If TotString <> "" Then 
					If CDbl(Amount) <0 Then
						Amount1= CDbl(Amount)*-1 
						TotString = TotString &","& "{""date"": """&MNTHYEAR&""", ""negativeAmount"":"""&Amount1&"""}"
					else
						TotString = TotString &","& "{""date"": """&MNTHYEAR&""", ""positiveAmount"":"""&Amount&"""}"
					End if
				Else 
					If CDbl(Amount) <0 Then
						Amount1= CDbl(Amount)*-1 
						TotString = "{""date"": """&MNTHYEAR&""", ""negativeAmount"":"""&Amount1&"""}"
					Else
						TotString = "{""date"": """&MNTHYEAR&""", ""positiveAmount"":"""&Amount&"""}"
					End if
				End If

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
							Month Wise Operating Expenses
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
						  <li><div class="col-xs-6">Month</div><div class="col-xs-6">Amount in (Rs)</div></li>
						</ul>
						<ul class="list col-xs-12"></ul>
						<ul class="pagination col-xs-12"></ul>
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

		PassUrl	=	"<%=url%>?button=GetDataRev&RevFrom="+ $('#RevFrom').val() +"&RevTo="+ $('#RevTo').val();

		$.ajax({
			url: PassUrl, 
			success: function(result){			
				RevData	= eval("[" +  result +"]");

				$('#example ul.list').empty();
				$.each(RevData, function (key, value) {
					$('#example ul.list').append('<li><div class="month col-xs-6">'
					+ value.date 
					+'</div><div class="amount col-xs-6">'
					+( value.negativeAmount != undefined ? - value.negativeAmount : value.positiveAmount )
					+'</div></li>')
				});

				new List('example', {
				  valueNames: ['month', 'amount'],
				  page: 10,
				  pagination: true
				});

					var chart = AmCharts.makeChart("chartdiv", {
						"theme": "light",
						"type": "serial",
						"startDuration": 2,
						"legend": {
							"autoMargins": false,
							"borderAlpha": 0.2,
							"equalWidths": false,
							"horizontalGap": 10,
							"markerSize": 10,
							"useGraphSettings": true,
							"valueAlign": "left",
							"valueWidth": 0
						},
						"dataProvider": RevData,
						"valueAxes": [{
						  "stackType": "regular",
							"unit": " rs", // can change this values : effect's on view
							"position": "right",
							"title": "Revenue Amount", // can change this values : effect's on view
							"axisAlpha":0.1,
							"fillAlphas": 0.8,
							"lineAlpha": 0.1,
							"gridAlpha":0.1
						}],
						"graphs": [{
							"balloonText": "<b>[[title]]</b><br><span style='font-size:10px'>[[category]]: <b>Rs.[[value]]</b></span>",
							"colorField": "color",
							"fillAlphas": 0.85,
							"lineAlpha": 0.1,
						  "title": "Positive Amount",
							"type": "column",
							"topRadius":1,
							"valueField": "positiveAmount"
						},{
							"balloonText": "<b>[[title]]</b><br><span style='font-size:10px'>[[category]]: <b>Rs.(-[[value]])</b></span>",
							"colorField": "color",
							"fillAlphas": 0.85,
							"lineAlpha": 0.1,
						  "title": "Negative Amount",
							"type": "column",
							"topRadius":1,
							"valueField": "negativeAmount"
						}],
						"plotAreaFillAlphas": 0.1,
				   "depth3D": 20,
					"angle": 30,
						 "chartScrollbar": {
							"scrollbarHeight": 4,
							"backgroundAlpha": 0.1,
							"backgroundColor": "#868686",
							"selectedBackgroundColor": "#67b7dc",
							"selectedBackgroundAlpha": 1
						},
						"chartCursor": {
							"valueLineEnabled": true,
							"valueLineBalloonEnabled": false,
							"categoryBalloonEnabled": false
						},
						"categoryField": "date",
						"categoryAxis": {
							"gridPosition": "start",
							"axisAlpha":0,
							"gridAlpha":0

						},
						"export": {
							"enabled": false
						 }

					}, 0);



			}
		});
		
	}


jQuery('.chart-input').off().on('input change',function() {

	var property	= jQuery(this).data('property');
	var target		= chart;
	chart.startDuration = 0;

	if ( property == 'topRadius') {
		target = chart.graphs[0];
      	if ( this.value == 0 ) {
          this.value = undefined;
      	}
	}

	target[property] = this.value;
	chart.validateNow();
	
});
</script>
