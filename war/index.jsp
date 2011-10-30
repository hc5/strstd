<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta property="fb:admins" content="100000843638823">
<link rel="stylesheet" href="/css/styles.css" type="text/css" />
<link rel="stylesheet" href="/css/jquery.alerts.css" type="text/css" />
 <link type="text/css" href="/css/jquery.jgrowl.css" rel="stylesheet"/> 
<link rel="stylesheet" href="/css/bar.css" type="text/css" />
<title>Strength Standards</title>

<script type="text/javascript" src="/jquery.js" charset="utf-8"></script>

<script src="/highchart/highcharts.js" type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/mootools/1.3.0/mootools-yui-compressed.js" type="text/javascript"></script>
<script src="/highchart/adapters/mootools-adapter.js" type="text/javascript"></script>
<script  type="text/javascript" src="/dialog.js"></script>
<script type="text/javascript" src="/jquery.jgrowl.js"></script>
<script type="text/javascript" src="/jquery.alerts.js" charset="utf-8"></script>
<script type="text/javascript" src="/jquery.dateinput.js" charset="utf-8"></script>
<script type="text/javascript" src="/jquery.tooltip.js" charset="utf-8"></script>
<script type="text/javascript" src="/jquery.tabs.js" charset="utf-8"></script>
<script type="text/javascript" src="/json-minified.js" charset="utf-8"></script>
<script type="text/javascript" charset="utf-8">
	var changeWeight = function() {
		$(".weight").html($("#measure").val());
		var ar = $("input[name$='Wt']");
		for ( var i = 0; i < ar.length; i++) {
			if($("#measure").val()=="lbs")
			ar[i].value = ar[i].value*2.20462262;
			else
			ar[i].value = ar[i].value/2.20462262;
		}
		if($("#measure").val()=="lbs")
			$("#wt").val($("#wt").val()*2.20462262);
		else
			$("#wt").val($("#wt").val()/2.20462262);
		change = "all";
		refresh();
	}
	var loadRoutine = function(){
		$.get("/routine.jsp?"+$("#frm").serialize()+"&ue="+$("#underestimate").attr("checked"),function(data){
			$("#routineContent").html(data);
			$("#acc").tabs("#acc div.accPane", {tabs: 'h2', effect: 'slide', initialIndex: null});
		});
		
	}
	
	var loadProgress = function(){
		$.get("/progress.jsp",function(data){
			$("#progress").html(data);
		});
	}
	var refresh = function() {
		var ar = $("input[name$='Wt']");
		for ( var i = 0; i < ar.length; i++) {
			
			if($(ar[i]).attr("rel")!=change&&change!="all")
				continue;
			var curEl = $(ar[i]);
			var curType = ar[i].name.split("_")[0];
			var rep = $("input[name='" + curType + "Rep']")[0];
			if (rep.value != "") {
				$.get("/bar?l=" + ($("#measure").val() == "lbs") + "&m="
						+ ($("#sex").val() == "male") + "&b=" + $("#wt").val()
						+ "&w=" + ar[i].value + "&t=" + curType + "&r="
						+ rep.value, function(data) {
					var b;
					if(data!=""){
					b=jsonParse(data);
					if(b){
					update( b.target + "Bar",b.data);
					}
					}
				});
			}

		}
	}
	function del(p){
		var date = new Date();
		date.setTime(p.x);
		jConfirm('Delete this record? <br> Date: '+date.toDateString()+'<br>'+p.name, '', function(r) {
		    if(r){
		    	
		    	$.post("/remove",{"point":p.url},function(re){
		    		
					
			    	p.remove();
		    	});
		    }
		});
	};
	var update = function(target,data){
		
		$("#"+target).slideDown();
	
	
		if(data.grade<0.3){
			$("#"+target+" #lab").html(data.value);
			$("#"+target+" #lab").attr("class","label2");
		}
		else{

			$("#"+target+" #lab").html(data.value);
			$("#"+target+" #lab").attr("class","label");
		}
		$("#"+target+" .bar").css("width",data.grade/4.0*100+"%");
		var grades = $("#"+target+" .grades");
		for(var i =0;i<grades.length;i++){
			$(grades[i]).html(data.grades[i]);
		}
	}
	var changed = false;
	var change = "";
	var makeRequests = function(){
		if(changed){
			refresh();
			changed = false;
		}
		
	}
	$(document).ready(function() {
		setInterval("makeRequests()",200);
		var ar = $("input[name$='Wt']");
		$("ul.tabs").tabs("div.panes > .pane",{"effect":"fade"},{onBeforeClick : function(e, i) { 
			if($(".tabs > li > a")[i].hasClass("disabled")){
				return false;
			}
	    }		
	});
		$("#calc").click(function(){
			$("ul.tabs").data("tabs").next();
			loadRoutine();
			
			
		});
		var r = $("input:visible").not("name$='Wt'");
		for ( var i = 0; i < r.length; i++) {
			var el = $(r[i]);
			el.keyup(function() {
				changed = true;
				change = $(this).attr("rel");
			});
		}
		$(".track").tooltip({effect:'fade'});
		$(".track").click(function(){
			
			var id = this.id;
			track(id);
			
			return false;
		});
		$(":date").dateinput({
			format: 'mm/dd/yyyy'
		});
		$("#note").click(function(){
			$("#noteArea").slideDown();
			
		});
		$("#addNote").click(function(){
			var text = $("#noteText").val(); 
			$.post("/track",{notes:text,date:$("#date").val()},function(data){
				if(data=='0'){
					$.jGrowl("Track successful!");
					$("#noteText").val("");
				}
				else{
					$.jGrowl("Track failed!");
				}
			});
			
		});
		$("#trackAll").click(function(){
			$("#noteArea").slideDown();
			
		});
	});
	var track = function(id){
		var date = $("#date").val();
		var post = {};
		if($("#date").val()==""||$("#wt").val()==""|| $("input[name="+id+"_Wt]").val()==""||$("input[name="+id+"Rep]").val()==""){
			return;
		}
		post["wt"] = $("#wt").val();
		post[id] = "true";
		post[id+"wt"] = $("input[name="+id+"_Wt]").val();
		post[id+"rep"] = $("input[name="+id+"Rep]").val();
		post["date"] = date;
		$.post("/track",post,function(data){
			if(data=='0'){
				$.jGrowl("Track successful!");
				
			}
			else{
				$.jGrowl("Track failed!");
			}
			
		});
	}
	var print = function(){
		dialog("Choose your accessory routine<br><br><select id='opt'><option value='0'>Big But Boring</option>"+
				"<option value='1'>The Triumvirate</option>"+
				"<option value='2'>I'm not doing Jack Shit</option>"+
				"<option value='3'>Dave Tate's Periodization Bible</option>"+
				"<option value='4'>Body weight</option></select>",function(){
				option = ($("#opt option:selected").val());
				$("input[name='o']").val(option);
				$("#4week").submit();
				})
	}
</script>
</head>

<body>

	<%@include file="user.jsp"%>
	
	<table width="100%">
	<tr><td><div style="background-color:#EEEEEE;font-weight:bold;padding:10px;color:#222;border-radius:3px;border-style:solid;border-color:#AAA;border-width:1px;-moz-border-radius:3px;">QUESTIONS? FEEDBACK? FOLLOW <a class="jslink" href="http://twitter.com/#!/strstd">@strstd</a>!</div></td></tr>
		<tr>
			<td></td>
			<td id="banner"><center>
					<img src="/images/strstd.png" />
				</center></td>
			<td></td>
		</tr>
		<tr>
			<td width='20%'></td>
			<td width='60%' id="mainPanel">
				<div>
					<ul class="tabs">
	<li><a href="#main">My standards</a></li>
	<li><a href="#routine" onclick="loadRoutine()">My 5/3/1 routine</a></li>
	
	<%if(currentUser!=null){ %>
	<li><a href="#progress" onclick="loadProgress()">My Progress</a></li>
	<%}
	else{%>
	<li><a href="" class="disabled" onclick="return false" >Log in to see your tracked progress!</a></li>
	<%}%>
	
</ul>
<div class="panes">
					<div class="pane" id="main">
					<form id="frm">
					<%if(currentUser!=null){ %>
					Date: <input type="date" id="date" value="0" data-value="0">
					<%} %>
						<%
							if (currentUser == null) {
						%>
						Use <select name="measure" id="measure" onchange="changeWeight()" rel="all"><option
								value="lbs">imperial(lbs)</option>
							<option value="kgs">metric(kgs)</option>
						</select>
						<%
							}
						%>
						<ul>

							<li><label for="weight">How much do you weigh?</label><div><input
								type="text" name="weight" id="wt"  rel="all"/> <span class="weight"><%=lbs?"lbs":"kgs" %></span>
								<%if(currentUser!=null){ %>
								<button class="track"  id="weight" style="float:right" onclick="return false"><img src="/images/add.gif" /></button>
								<div class="tooltip">
	Track this!
	</div>
	</div>
								<%} %>
							</li>
							<%
								if (currentUser == null) {
							%>
							<li><label for="sex">What's your gender?</label><select
								id="sex" name="sex" onchange="refresh()" rel="all"><option
										value="male">Male</option>
									<option value="female">Female</option>
							</select></li>
							<%
								}
							%>
							<li><label for="bpRep">Benchpress stats:</label>
								<div>
									<input type="text" name="bpRep" rel="bp"/> reps at <input
										type="text" name="bp_Wt"  rel="bp"/> <span class='weight'>
										<%=lbs?"lbs":"kgs" %></span>
										<%if(currentUser!=null){ %>
								<button class="track"  id="bp" style="float:right" onclick="return false"><img src="/images/add.gif" /></button><div class="tooltip">
	Track this!
	</div>
								<%} %>
								</div></li>
							<li>
							
							<%=BarGenerator.make("100%","bpBar") %> </li>
							<li><label for="squatRep">Squat stats:</label>
								<div>
									<input type="text" name="squatRep" rel="squat"/> reps at <input
										type="text" name="squat_Wt"  rel="squat"/> <span class='weight'>
										<%=lbs?"lbs":"kgs" %></span>
										<%if(currentUser!=null){ %>
								<button class="track"  id="squat" style="float:right" onclick="return false"><img src="/images/add.gif" /></button><div class="tooltip">
	Track this!
	</div>
								<%} %>
								</div></li>
							<li><%=BarGenerator.make("100%","squatBar") %></li>
							<li><label for="dlRep">Deadlift stats:</label>
								<div>
									<input type="text" name="dlRep" rel="dl"/> reps at <input type="text"
										name="dl_Wt"  rel="dl"/> <span class='weight'> <%=lbs?"lbs":"kgs" %></span>
										<%if(currentUser!=null){ %>
								<button class="track" id="dl" style="float:right" onclick="return false"><img src="/images/add.gif" /></button><div class="tooltip">
	Track this!
	</div>
								<%} %>
								</div></li>
							<li><%=BarGenerator.make("100%","dlBar") %></li>
							<li><label for="ohpRep">Overhead press stats:</label>
								<div>
									<input type="text" name="ohpRep" rel="ohp"/> reps at <input type="text"
										name="ohp_Wt"  rel="ohp"/> <span class='weight'> <%=lbs?"lbs":"kgs" %></span>
										<%if(currentUser!=null){ %>
								<button class="track"  id="ohp" style="float:right" onclick="return false"><img src="/images/add.gif" /></button><div class="tooltip">
	Track this!
	</div>
								<%} %>
								</div></li>
							<li><%=BarGenerator.make("100%","ohpBar") %></li>
							
						</ul>
						<%
							if (currentUser != null) {
						%>
						<input type="hidden" id="measure" name="measure"
							value="<%=lbs ? "lbs" : "kgs"%>" /> 
						<input type="hidden" id="sex" name="sex" value="<%=male ? "male" : "female"%>" />
	<%}%>
	</form>
	<%if(currentUser!=null){ %>
	<button id="trackAll")>Track everything!</button>&nbsp;<button id="note">Add a note</button><br>
	<div id="noteArea" style="display:none">
	<textarea id="noteText" rows=5 cols=80></textarea><br>
	<button id="addNote">Add</button></div>
	<%} %>
	
	<center><button id="calc" style="height:40px;font-size:16px;width:300px;);">Calculate 5/3/1 Routine!</button></center>
	</div>
					<div class="pane" id="routine">
					<div style="padding:10px;border-color:#DDD;border-width:1px;border-style:solid"><input type="checkbox" name="underestimate" id="underestimate" checked=checked onclick="loadRoutine()"> <label for="underestimate">Use 90% of my one rep max for the program (Recommended by Wendler for the starting 4 weeks)
					<span></span>
					</label>
					</div>
			<br /><br />
					<div id="routineContent"><center><img src="/images/load.gif" style="padding:100px" /></center></div></div>
					<div class="pane" id="progress"><%if(currentUser!=null){ %><center><img src="/images/load.gif" style="padding:100px" /></center><%} %></div>
					</div>
	</div>
	</td>
	<td width='20%'></td></tr>
	
	<tr><td></td><td><iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.strstd.com%2F&amp;layout=button_count&amp;show_faces=false&amp;width=450&amp;action=like&amp;font=lucida+grande&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:100px; height:21px;" allowTransparency="true"></iframe><a href="http://twitter.com/share" class="twitter-share-button" data-count="none" data-via="strstd">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script></td><td></td></tr>
	<tr><td></td><td>
	<div style="width:100%">
	<center>
	<script type="text/javascript"><!--
google_ad_client = "ca-pub-6795284715658701";
/* strstd 1 */
google_ad_slot = "1930214997";
google_ad_width = 728;
google_ad_height = 90;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script></center></div>
	</td><td></td></tr>
	</table>
  </body>
  <script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-17199758-3']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</html>
