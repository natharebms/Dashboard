<%

'======================= FAS DLL Instance Creation===================================================	
		Set VScompAgencyFA		= Server.CreateObject ("RTCASHBOX.RTCASHBOXCLS")
		Set VScompUTAgencyFA	= VScompAgencyFA.RTUT
		Set VScompDBUTAgencyFA	= VScompAgencyFA.RTDBUT
		Set VScompDAAgencyFA	= VScompAgencyFA.RTDA
		VScompAgencyFA.Set_DB_Connection_String Session("strCONNECTION")
'===================================================================================================

sBaseCurrency = trim(vscompAgencyFA.get_default_base_currency)

If Trim(Session("strCONNECTION")) <> "" Then 
 
	strCtrlMstr = "SELECT INDIRECT_EXP_GROUP,DIRECT_INCOMES_GROUP,DIRECT_EXPENSES_GROUP FROM CONTROL_MASTER"	 
	Set rsCtrlMstr=VScompDAAgencyFA.Get_RecordSet(CStr(strCtrlMstr))
	If Not rsCtrlMstr.eof Then
		INDIRECT_EXP_GROUP		= rsCtrlMstr("INDIRECT_EXP_GROUP")  
		DIRECT_INCOMES_GROUP	= rsCtrlMstr("DIRECT_EXPENSES_GROUP")  
		DIRECT_EXPENSES_GROUP	= rsCtrlMstr("DIRECT_INCOMES_GROUP")  
	End If

	If Trim(INDIRECT_EXP_GROUP) <>"" Then 
		INDIRECT_EXP_GROUP= Replace(INDIRECT_EXP_GROUP,",","','")
	End If

	If Trim(DIRECT_INCOMES_GROUP) <>"" Then 
		DIRECT_INCOMES_GROUP= Replace(DIRECT_INCOMES_GROUP,",","','")
	End If

	If Trim(DIRECT_EXPENSES_GROUP) <>"" Then 
		DIRECT_EXPENSES_GROUP= Replace(DIRECT_EXPENSES_GROUP,",","','")
	End If

	rsCtrlMstr.close
	Set rsCtrlMstr = Nothing
End if

This is a test change


SUB CommonHeader%>

<!DOCTYPE html>
<html>
<head>
    <title>eBMS</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="lib/components-bootstrap/css/bootstrap.css" rel="stylesheet" />
	<link rel="stylesheet" href="lib/amcharts/dist/amcharts/plugins/export/export.css" type="text/css" media="all" />
	<link rel="stylesheet" href="plugin/datepicker/css/datepicker.css" />
	<link rel="stylesheet" href="plugin/jquery-sumoselect/css/sumoselect.css" />
	<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body>
    <script src="lib/jquery/dist/jquery.js"></script>
    <script src="lib/components-bootstrap/js/bootstrap.js"></script>
    <script src="lib/jsrender/jsrender.js"></script>	
	<script src="lib/amcharts/dist/amcharts/amcharts.js"></script>
	<script src="lib/amcharts/dist/amcharts/pie.js"></script>
	<script src="lib/amcharts/dist/amcharts/serial.js"></script>
	<script src="lib/amcharts/dist/amcharts/plugins/export/export.min.js"></script>
	<script src="lib/amcharts/dist/amcharts/themes/light.js"></script>
	<script src="lib/list.js/dist/list.min.js"></script>
	<script src="plugin/datepicker/js/datepicker.js"></script>
	<script src="plugin/jquery-sumoselect/js/jquery.sumoselect.js"></script>
	<script src="assets/js/main.js"></script>

	<div class="container-fluid" style="padding-left:0;padding-right:0;">
		<nav class="navbar navbar-default navbar-fixed-top">
		  <div class="container-fluid">
			<!--   Mobile Menu  &  Brand   -->
			<!--
			<div class="navbar-header">
			  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			  </button>
			  <a class="navbar-brand" href="#">Brand</a>
			</div>
			-->
			<div class="collapse navbar-collapse">
			  <ul class="nav navbar-nav">
				<li><a href="HHDashboard.asp"><i class="glyphicon glyphicon-home"></i> Home</a></li>
				<li class="dropdown">
				  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="glyphicon glyphicon-flash"></i> Expenses</a>
				  <ul class="dropdown-menu" role="menu">
					<li><a href="HHSubGroupWiseExpenses.asp">SubGroup Wise</a></li>
					<li><a href="HHMonthWiseOperatingExpenses.asp">Month Wise</a></li>
				  </ul>
				</li>
				<li class="dropdown">
				  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="glyphicon glyphicon-usd"></i> Revenue</a>
				  <ul class="dropdown-menu" role="menu">
					<li><a href="HHMonthWiseRevenues.asp">Month Wise</a></li>
				  </ul>
				</li>
				<li class="dropdown">
				  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="glyphicon glyphicon-stats"></i> Budget</a>
				  <ul class="dropdown-menu" role="menu">
					<li><a href=""></a></li>
				  </ul>
				</li>
				<li class="dropdown">
				  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="glyphicon glyphicon-thumbs-up"></i> Outstanding</a>
				  <ul class="dropdown-menu" role="menu">
					<li><a href="HHAgeingWiseOutstanding.asp">Ageing Wise</a></li>
					<li><a href="HHLocationWiseOutstanding.asp">Location Wise</a></li>
					<li><a href="HHDepartmentWiseOutstanding.asp">Department Wise</a></li>					
				  </ul>
				</li>
				
			  </ul>
			</div>
		  </div>
		</nav>

		<nav class="navbar navbar-default navbar-fixed-bottom">
		  <div class="container-fluid">
			<div class="collapse navbar-collapse">
			  <ul class="nav navbar-nav">
				<li><a href="#"><i class="glyphicon glyphicon-arrow-left"></i> Back</a></li>
			  </ul>
			   <ul class="nav navbar-nav navbar-right">
				<li><a href="HHDashboard.asp"> © 2017 eBMS All Rights Reserved.</a></li>
			  </ul>
			</div>
		  </div>
		</nav>
    </div>
   
</body>
</html>
    
<%End Sub%>