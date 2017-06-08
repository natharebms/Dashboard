<%@ Enablesessionstate=true%>
<% language="VBScript" %>
<% Response.Expires=0%>

<%
		UserID=Session("UserID")
		if IsNull(UserID) or UserID="" then
%>	    
		<script language="JavaScript">
		<!--
			parent.location.href="HHLogin.asp"
		//-->
		</script>		
<%
		response.end
		end If
%>

<head>
<style>
	*{
		margin:0;
		padding:0;
	}
	body{
		font-family:"Segoe UI", sans-serif;
		background:#fff url(assets/img/bg.png) no-repeat top left;
		-webkit-background-size: cover;
		-moz-background-size: cover;
		-o-background-size: cover;
		background-size: cover;
		overflow: hidden;
		top: 0;
		left: 0;
	}
  
  
	}
	#content{
		margin:0 auto;
	}

	.navigation{
		margin: 0px auto;
		font-family: "Segoe UI", sans-serif;
		font-size: 18px;
		font-style: normal;
		font-weight: bold;
		letter-spacing: 1px;
	}
	.navigation .item{
		position:absolute;
	}
	.user{
		top:125px;
		left:110px;
	}
	.home{
	   top:50px;
	   left:360px;
	}
	.shop{
	   top:90px;
	   left:625px;
	}
	.camera{
	   top:230px;
	   left:835px;
	}
	.fav{
	   top:420px;
	   left:950px;
	}
	a.icon{
		width:52px;
		height:52px;
		position:absolute;
		top:0px;
		left:0px;
		cursor:pointer;
	}
	.user a.icon{
		background:transparent url(assets/img/user.png) no-repeat 0px 0px;
	}
	.home a.icon{
		background:transparent url(assets/img/home.png) no-repeat 0px 0px;
	}
	.shop a.icon{
		background:transparent url(assets/img/ic_expenses.png) no-repeat 0px 0px;
	}
	.camera a.icon{
		background:transparent url(assets/img/ic_revenue.png) no-repeat 0px 0px;
	}
	.fav a.icon{
		background:transparent url(assets/img/ic_budget.png) no-repeat 0px 0px;
	}
	.navigation .item a.active{
		background-position:0px -52px;
	}
	.item img.circle{
		position:absolute;
		top:0px;
		left:0px;
		width:52px;
		height:52px;
		opacity:0.1;
	}
	.item h2{
		position:absolute;
		width:147px;
		height:52px;
		color:#222;
		font-size:18px;
		top:0px;
		left:52px;
		text-indent:10px;
		line-height:52px;
		text-shadow:1px 1px 1px #fff;
		text-transform:uppercase;
	}
	.item h2.active{
		color:#fff;
		text-shadow:1px 0px 1px #555;
	}
	.item ul{
		list-style:none;
		position:absolute;
		top:60px;
		left:0px;
		display:none;
	}
	.item ul li a{
		font-size:10px;
		text-align:center;
		text-decoration:none;
		letter-spacing:0.5px;
		color:#fff;
		padding:3px;
		float:left;
		clear:both;
		width:160px;
	}
	.item ul li a:hover{
		font-size:11px;
	}
</style>
</head>

<body>
	<div id="content">
		<div class="navigation" id="nav">
			<div class="item user">
				<img src="assets/img/bg_user.png" alt="" width="199" height="199" class="circle"/>
				<a href="#" class="icon"></a>
				<h2>User</h2>
				<ul>
					<li><a href="#">test1</a></li>
					<li><a href="#">test2</a></li>
					<li><a href="#">test3</a></li>
				</ul>
			</div>
			<div class="item home">
				<img src="assets/img/bg_home.png" alt="" width="199" height="199" class="circle"/>
				<a href="" class="icon"></a>
				<h2>Home</h2>
				<ul>
					<li><a href="#">test1</a></li>
					<li><a href="#">test2</a></li>
					<li><a href="#">test3</a></li>
				</ul>
			</div>
			<div class="item shop">
				<img src="assets/img/bg_shop.png" alt="" width="199" height="199" class="circle"/>
				<a href="#" class="icon"></a>
				<h2>Expenses</h2>
				<ul>
					<li><a href="HHSubGroupWiseExpenses.asp">Indirect - SubGroup Wise</a></li>
					<li><a href="HHMonthWiseOperatingExpenses.asp">Operating - Month Wise</a></li>
				</ul>
			</div>
			<div class="item camera">
				<img src="assets/img/bg_camera.png" alt="" width="199" height="199" class="circle"/>
				<a href="#" class="icon"></a>
				<h2>Revenue</h2>
				<ul>
					<li><a href="HHMonthWiseRevenues.asp">Month Wise</a></li>
				</ul>
			</div>
			<div class="item fav">
				<img src="assets/img/bg_fav.png" alt="" width="199" height="199" class="circle"/>
				<a href="#" class="icon"></a>
				<h2>Budget</h2>
				<ul>
					<li><a href="#">test1</a></li>
					<li><a href="#">test2</a></li>
					<li><a href="#">test3</a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- The JavaScript -->
	<script type="text/javascript" src="lib/jquery/dist/jquery.js"></script>
	<script type="text/javascript" src="plugin/jquery.easing.js"></script>
	<script type="text/javascript">
		$(function() {
			$('#nav > div').hover(
			function () {
				var $this = $(this);
				$this.find('img').stop().animate({
					'width'     :'240px',
					'height'    :'240px',
					'top'       :'-35px',
					'left'      :'-35px',
					'opacity'   :'1.0'
				},500,'easeOutBack',function(){
					$(this).parent().find('ul').fadeIn(700);
				});

				$this.find('a:first,h2').addClass('active');
			},
			function () {
				var $this = $(this);
				$this.find('ul').fadeOut(500);
				$this.find('img').stop().animate({
					'width'     :'52px',
					'height'    :'52px',
					'top'       :'0px',
					'left'      :'0px',
					'opacity'   :'0.1'
				},5000,'easeOutBack');

				$this.find('a:first,h2').removeClass('active');
			}
		);
		});
	</script>
</body>
