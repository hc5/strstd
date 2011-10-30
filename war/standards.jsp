<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="header.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/styles.css" type="text/css" />
    <title>Strength Standards</title>
	
<script type="text/javascript" src="/jquery.js" charset="utf-8"></script>
<script src="/highchart/highcharts.js" type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/mootools/1.3.0/mootools-yui-compressed.js" type="text/javascript"></script>
<script src="/highchart/adapters/mootools-adapter.js" type="text/javascript"></script>

<script type="text/javascript" src="/jquery.DOMWindow.js" charset="utf-8"></script>
<link rel="stylesheet" href="/bar.css" type="text/css">
	
	<script type="text/javascript" src="/jquery.dependClass.js"></script>

</head>

<body>
  	<%@include file="user.jsp" %>
	<%
if(request.getParameter("sex")==null
	||request.getParameter("measure")==null){
	response.sendRedirect("/");
}
lbs = request.getParameter("measure").equals("lbs");
male =  request.getParameter("sex").equals("male");
Double weight =Double.parseDouble(request.getParameter("weight"));
Benchpress bp=null;
Squat squat=null;
Deadlift dl=null;
Press ohp=null ;
if(!lbs)
	weight*=2.204622;
%>
  <table width="100%">
	<tr>
	<td></td>
	<td id="banner"><center><a href="/"><img src="/strstd.png" /></a></center></td>
	<td></td></tr>
	<tr><td width='20%'></td>
	<td width='60%' id="mainPanel" >
	<div id="results">
		<ul>
			<li><a href="#result">Results</a></li>

				<li><a href="#routine">Calculated 5/3/1 Routine</a></li>
			<%if(key!=null){
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				Entity user = datastore.get(key);
				if(user.getProperty("lbs")==null||(Boolean)(user.getProperty("lbs"))!=lbs){
					user.setProperty("lbs",lbs);
					datastore.put(user);
				}
			%>
				<li><a href="#progress">My progress</a></li>
				<%} 
				else{%>
					<li><a href="#">Log in to track your progress</a></li>
					<%} %>
		</ul>
		<div id="result">
	<%if(!request.getParameter("benchWt").equals("")){ 
		
		double benchWt = Double.parseDouble(request.getParameter("benchWt"));
		if(!lbs)
			benchWt*= 2.20462262;
		int benchRep = Integer.parseInt(request.getParameter("benchRep"));
		bp = new Benchpress(male, weight,benchWt,benchRep);
		session.setAttribute("bp",bp);
		double bgGrade = bp.grade();
	%>
	Bench <span class="subtitle">(One Rep Max)</span>
	<br />
	<br />
	<%=BarGenerator.make("100%",bp.oneRepMax,bgGrade,bp.grades,lbs) %><br />
	<%} %>
	<%if(!request.getParameter("squatWt").equals("")){
		double squatWt = Double.parseDouble(request.getParameter("squatWt"));
		if(!lbs)
			squatWt*= 2.20462262;
		int squatRep = Integer.parseInt(request.getParameter("squatRep"));
		squat = new Squat(male, weight,squatWt,squatRep);
		session.setAttribute("squat",squat);
		double squatGrade = squat.grade();%>
	Squat <span class="subtitle">(One Rep Max)</span>
	<br />
	<br />
	<%=BarGenerator.make("100%",squat.oneRepMax,squatGrade,squat.grades,lbs) %><br />
	
	<%} %>
	<%if(!request.getParameter("dlWt").equals("")){ 
	double dlWt = Double.parseDouble(request.getParameter("dlWt"));
		if(!lbs)
			dlWt*= 2.20462262;
		int dlRep = Integer.parseInt(request.getParameter("dlRep"));
		dl = new Deadlift(male, weight,dlWt,dlRep);
		session.setAttribute("dl",dl);
		double dlGrade = dl.grade();
		%>
	Deadlift <span class="subtitle">(One Rep Max)</span>
	<br />
	<br />
	<%=BarGenerator.make("100%",dl.oneRepMax,dlGrade,dl.grades,lbs) %><br />

	<%} %>
	<%if(!request.getParameter("ohpWt").equals("")){
		double ohpWt = Double.parseDouble(request.getParameter("ohpWt"));
		if(!lbs)
			ohpWt*= 2.20462262;
		int ohpRep = Integer.parseInt(request.getParameter("ohpRep"));
		ohp= new Press(male, weight,ohpWt,ohpRep);
		session.setAttribute("ohp",ohp);
		double ohpGrade = ohp.grade();%>
		
	Overhead Press <span class="subtitle">(One Rep Max)</span>
	<br />
	<br />
	<%=BarGenerator.make("100%",ohp.oneRepMax,ohpGrade,ohp.grades,lbs) %>
<br />
	<br />
	<%} 
	
	if(key!=null){%>
	<button onclick="$('#track').slideDown(100)">Track this result!</button>
	<div id="track">
		
		Track my...<table>
		<tr>
		<td align="left" valign="top">
		<%if(bp!=null){ %>
		<input type="checkbox" checked="checked" name="trackBench" id="trackBench" /><label for='trackBench'>Bench</label><br>
		<%}
		if(squat!=null){%>
		<input type="checkbox" checked="checked" name="trackSquat" id="trackSquat" /><label for='trackSquat'>Squat</label><br>
		<%}
		if(dl!=null){%>
		<input type="checkbox" checked="checked" name="trackDL" id="trackDL" /><label for='trackDL'>Deadlift</label><br>
		<%}
		if(ohp!=null){%>
		<input type="checkbox" checked="checked" name="trackOHP" id="trackOHP" /><label for='trackOHP'>Overhead press</label><br>
		<%}
		%>
		</td>
		<tr>
		</table>
		<%if(bp!=null||squat!=null||dl!=null||ohp!=null){ %>at my<%} %> bodyweight of <input style="width:130px" id="wt"  type="text" name="wt" value="<%=weight%>"/> <%=lbs?"lbs":"kgs" %>,
		
	
		on <input style="width:130px" type="text" name="date" id="datePicker" value="<%=Converter.getDate()%>"/><br>
		Notes:<span style="color:#BBB;text-shadow:none">(optional)</span><br>
		<textarea cols="50" rows="5" id="notes"></textarea>
		<button id="go" style="vertical-align:bottom" onclick="track()">Go!</button>
		<br />
		<span id="status"></span>
		
	</div>
	<%} %>
	</div>
	<div id="routine">	
	5/3/1 Program based on your stats: 
	<br>
	<br>
	<a class="jslink" href='http://www.t-nation.com/free_online_article/sports_body_training_performance/how_to_build_pure_strength'>What is the 5/3/1 program?</a>
	<br><br>
	<center>
<table cellpadding="10px" cellspacing="0">
<%if(bp!=null){
Standard s = bp;
double orm = s.oneRepMax;
if(!lbs) orm = Converter.lbsToKgs(orm);

%>


<tr style="background-color:#555;color:#EEE"><td></td><td></td><td>Week 1</td><td>Week 2</td><td>Week 3</td><td>Week 4</td></tr>

<tr class='benchRows'><td rowspan="3"><b>Bench Press</td><td>Set 1</td><td><%=Converter.round5((int)(orm*0.65))%> x 5</td><td><%=Converter.round5((int)(orm*0.70))%> x 3</td><td><%=Converter.round5((int)(orm*0.75))%> x 5</td><td><%=Converter.round5((int)(orm*0.40))%> x 5</td></tr>
<tr class='benchRows'><td>Set 2</td><td><%=Converter.round5((int)(orm*0.75))%> x 5</td><td><%=Converter.round5((int)(orm*0.80))%> x 3</td><td><%=Converter.round5((int)(orm*0.85))%> x 3</td><td><%=Converter.round5((int)(orm*0.50))%> x 5</td></tr>
<tr class='benchRows'><td>Set 3</td><td><%=Converter.round5((int)(orm*0.85))%> x 5+</td><td><%=Converter.round5((int)(orm*0.90))%> x 3+</td><td><%=Converter.round5((int)(orm*0.95))%> x 1+</td><td><%=Converter.round5((int)(orm*0.60))%> x 5</td></tr>
<% 
}%>
<%if(squat!=null){
Standard s = squat;
double orm = s.oneRepMax;
if(!lbs) orm = Converter.lbsToKgs(orm);

%>


<tr class='squatRows' ><td rowspan="3"><b>Squats</td><td>Set 1</td><td><%=Converter.round5((int)(orm*0.65))%> x 5</td><td><%=Converter.round5((int)(orm*0.70))%> x 3</td><td><%=Converter.round5((int)(orm*0.75))%> x 5</td><td><%=Converter.round5((int)(orm*0.40))%> x 5</td></tr>
<tr class='squatRows' ><td  >Set 2</td><td><%=Converter.round5((int)(orm*0.75))%> x 5</td><td><%=Converter.round5((int)(orm*0.80))%> x 3</td><td><%=Converter.round5((int)(orm*0.85))%> x 3</td><td><%=Converter.round5((int)(orm*0.50))%> x 5</td></tr>
<tr class='squatRows' ><td  >Set 3</td><td><%=Converter.round5((int)(orm*0.85))%> x 5+</td><td><%=Converter.round5((int)(orm*0.90))%> x 3+</td><td><%=Converter.round5((int)(orm*0.95))%> x 1+</td><td><%=Converter.round5((int)(orm*0.60))%> x 5</td></tr>
<% 
}%>
<%if(dl!=null){
Standard s = dl;
double orm = s.oneRepMax;
if(!lbs) orm = Converter.lbsToKgs(orm);

%>


<tr class='dlRows' ><td  rowspan="3"><b>Deadlifts</td><td>Set 1</td><td><%=Converter.round5((int)(orm*0.65))%> x 5</td><td><%=Converter.round5((int)(orm*0.70))%> x 3</td><td><%=Converter.round5((int)(orm*0.75))%> x 5</td><td><%=Converter.round5((int)(orm*0.40))%> x 5</td></tr>
<tr class='dlRows' ><td  >Set 2</td><td><%=Converter.round5((int)(orm*0.75))%> x 5</td><td><%=Converter.round5((int)(orm*0.80))%> x 3</td><td><%=Converter.round5((int)(orm*0.85))%> x 3</td><td><%=Converter.round5((int)(orm*0.50))%> x 5</td></tr>
<tr class='dlRows' ><td  >Set 3</td><td><%=Converter.round5((int)(orm*0.85))%> x 5+</td><td><%=Converter.round5((int)(orm*0.90))%> x 3+</td><td><%=Converter.round5((int)(orm*0.95))%> x 1+</td><td><%=Converter.round5((int)(orm*0.60))%> x 5</td></tr>
<% 
}%>
<%if(ohp!=null){
Standard s = ohp;
double orm = s.oneRepMax;
if(!lbs) orm = Converter.lbsToKgs(orm);

%>

<tr class='ohpRows' ><td  rowspan="3"><b>Overhead Press</td><td>Set 1</td><td><%=Converter.round5((int)(orm*0.65))%> x 5</td><td><%=Converter.round5((int)(orm*0.70))%> x 3</td><td><%=Converter.round5((int)(orm*0.75))%> x 5</td><td><%=Converter.round5((int)(orm*0.40))%> x 5</td></tr>
<tr class='ohpRows' ><td >Set 2</td><td><%=Converter.round5((int)(orm*0.75))%> x 5</td><td><%=Converter.round5((int)(orm*0.80))%> x 3</td><td><%=Converter.round5((int)(orm*0.85))%> x 3</td><td><%=Converter.round5((int)(orm*0.50))%> x 5</td></tr>
<tr class='ohpRows' ><td  >Set 3</td><td><%=Converter.round5((int)(orm*0.85))%> x 5+</td><td><%=Converter.round5((int)(orm*0.90))%> x 3+</td><td><%=Converter.round5((int)(orm*0.95))%> x 1+</td><td><%=Converter.round5((int)(orm*0.60))%> x 5</td></tr>
<% 
}%>
</table>
</center>
<br />
<span style="font-size:15px">Complete Routine with Accesory work</span><br />
<br />
<div id="acc">
<ul>
		<li><a href="#r1">Big But Boring</a></li>
		<li><a href="#r2">The Triumvirate</a></li>
		<li><a href="#r3">I'm Not Doing Jack Shit</a></li>
		<li><a href="#r4">Dave Tate's Periodization Bible</a></li>
		<li><a href="#r5">Body weight</a></li>
	</ul>
	<div id="r1">
<span class="title">Day 1</span><br />
Overhead Press - 5/3/1<br />
Overhead Press - 5x10<%if(ohp!=null){ %> at <%=Converter.round5((int)(lbs?ohp.oneRepMax*0.5:Converter.lbsToKgs(ohp.oneRepMax)*0.5)) %> <%=lbs?"lbs":"kgs" %><%} %> <br />
Chin-ups - 5 sets of 10 reps <br /><br />
<span class="title">Day 2</span><br />
Deadlift - 5/3/1 <br />
Deadlift - 5x10<%if(dl!=null){ %>  at <%=Converter.round5((int)(lbs?dl.oneRepMax*0.5:Converter.lbsToKgs(dl.oneRepMax)*0.5)) %> <%=lbs?"lbs":"kgs" %><%} %> <br />
Hanging Leg Raise - 5 sets of 15 reps <br /><br />
<span class="title">Day 3</span><br />
Bench Press - 5/3/1 <br />
Bench Press - 5x10<%if(bp!=null){ %>  at <%=Converter.round5((int)(lbs?bp.oneRepMax*0.5:Converter.lbsToKgs(bp.oneRepMax)*0.5)) %> <%=lbs?"lbs":"kgs" %><%} %> <br />
Dumbbell Row - 5 sets of 10 reps <br /><br />
<span class="title">Day 4</span><br />
Squat - 5/3/1  <br />
Squat - 5x10<%if(squat!=null){ %>  at <%=Converter.round5((int)(lbs?squat.oneRepMax*0.5:Converter.lbsToKgs(squat.oneRepMax)*0.5)) %> <%=lbs?"lbs":"kgs" %><%} %> <br />
Leg Curl - 5 sets of 10 reps <br />	</div>
	<div id="r2">
<span class="title">Day 1</span>
<br />Overhead Press - 5/3/1  
<br />Dips - 5 sets of 15 reps 
<br />Chin-ups - 5 sets of 10 reps <br />
<br /><span class="title">Day 2</span>
<br />Deadlift - 5/3/1 
<br />Good Morning - 5 sets of 12 reps 
<br />Hanging Leg Raise - 5 sets of 15 reps <br />
<br /><span class="title">Day 3</span>
<br />Bench Press - 5/3/1 
<br />Dumbbell Bench Press - 5 sets of 15 reps 
<br />Dumbbell Row - 5 sets of 10 reps <br />
<br /><span class="title">Day 4</span>
<br />Squat - 5/3/1 
<br />Leg Press - 5 sets of 15 reps 
<br />Leg Curl - 5 sets of 10 reps <br />
<br /> 
<br /> 	</div>
	<div id="r3">
	<span class="title">Day 1</span><br />
	Overhead Press - 5/3/1<br /><br />
	<span class="title">Day 2</span><br />
	Deadlift - 5/3/1<br /><br />
	<span class="title">Day 3</span><br />
	Bench Press - 5/3/1<br /><br />
	<span class="title">Day 4</span><br />
	Squat - 5/3/1
		</div>
	<div id="r4">
<span class="title">Day 1</span> 
<br />Overhead Press - 5/3/1 
<br />Shoulders or Chest - 5 sets of 10 - 20 reps (DB bench, DB Incline, DB Military, Incline 
press, Dips, Pushups) 
<br />Lats or Upper Back - 5 sets of 10 - 20 reps (DB rows, Bent Over Rows, Chins, T - bar 
Rows, Lat Pulldowns, Face Pulls, Shrugs) 
<br />Triceps - 5 sets of 10 - 20 reps (Triceps Pushdowns or Triceps Extensions) <br />
<br /><span class="title">Day 2</span> 
<br />Deadlift - 5/3/1 
<br />Hamstrings - 5 sets of 10 - 20 reps (Leg Curls, Glute - Ham Raise) 
<br />Quads - 5 sets of 10 - 20 reps (Leg Press, Lunges, Hack Squats) 
<br />Abs - 5 sets of 10 - 20 reps (Sit - ups, Hanging Leg Raises, Ab Wheel, DB Side Bend) <br />
<br /><span class="title">Day 3</span> 
<br />Bench Press - 5/3/1 
<br />Shoulders or Chest - 5 sets of 10 - 20 reps (DB bench, DB Incline, DB Military, Incline 
press, Dips, Pushups) 
<br />Lats or Upper Back - 5 sets of 10 - 20 reps (DB rows, Bent Over Rows, Chins, T - bar 
Rows, Lat Pulldowns, Face Pulls, Shrugs) 
<br />Triceps - 5 sets of 10 - 20 reps (Triceps Pushdowns or Triceps Extensions) <br />
<br /><span class="title">Day 4</span> 
<br />Squat - 5/3/1 
<br />Low Back - 5 sets of 10 - 20 reps (Reverse Hyper, Back Raise, Good Morning) 
<br />Quads - 5 sets of 10 - 20 reps (Leg Press, Lunges, Hack Squats) 
<br />Abs - 5 sets of 10 - 20 reps (Sit - ups, Hanging Leg Raises, Ab Wheel, DB Side Bend) 	</div>
	<div id="r5">
<span class="title">Day 1</span><br />
Overhead Press  - 5/3/1 <br />
Chins - 5xF  <br />
Dips - 5xF  <br /> <br />
<span class="title">Day 2</span><br />
Deadlift - 5/3/1 <br />
Glute Ham Raises - 5xF  <br />
Leg Raises - 5xF  <br /> <br />
<span class="title">Day 3</span><br />
Benchpress - 5/3/1 <br />
Chins - 5xF  <br />
Pushups - 5xF  <br /> <br />
<span class="title">Day 4</span><br />
Squat - 5/3/1 <br />
One Legged Squat - 5xF <br />
Sit-ups - 5xF <br /> <br />
	</div>
</div>
</div>
<div id="progress">
<%if(currentUser!=null){ %>
<jsp:include page="chart.jsp">
<jsp:param value="gradeChart" name="container"/>
<jsp:param value="grade" name="type"/>
</jsp:include>
<div id="gradeChart" style="height:500px"></div>
<jsp:include page="chart.jsp">
<jsp:param value="rawChart" name="container"/>
<jsp:param value="raw" name="type"/>
</jsp:include>
<div id="rawChart" style="height:500px"></div>
<jsp:include page="chart.jsp">
<jsp:param value="wtChart" name="container"/>
<jsp:param value="weight" name="type"/>
</jsp:include>
<div id="wtChart" style="height:500px"></div>
<%} %>
</div>
</div>

	
	</td>
	<td width='20%'></td></tr>
	<tr><td></td><td><iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.strstd.com%2F&amp;layout=button_count&amp;show_faces=false&amp;width=450&amp;action=like&amp;font=lucida+grande&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:21px;" allowTransparency="true"></iframe>
	
	<br>
	<div class="info">
	References:
	<br><br>
	Strength standards taken from www.exrx.net
	<br><br>
	Mayhew, J., Ball, T., & Bowen, J. (1992). Prediction of bench press lifting ability from
submaximal repetitions before and after training. Sports Medicine, Training and
Rehabilitation, 3: 195-201.
<br><br>
Mayhew, J., Ball, T., Arnold, M., & Bowen, J. (1992). Relative muscular endurance performance
as a predictor of bench press strength in college men and women. Journal of Applied Sport
Science Research, 6: 200-206.
<br><br>
Wathen, D. Load assignment. In: Essentials of Strength Training and Conditioning. T. R. Baechle (Ed.). Champaign, IL: Human Kinetics, 1994, pp. 435-439.

	</div></td><td></td></tr>
	</table>
	
</body>
	
<script type="text/javascript">

	function track(){
		
		var post={};
		if($("#trackBench").is(":checked")){
			post.bp="true";
		}
		if($("#trackSquat").is(":checked")){
			post.squat="true";
		}
		if($("#trackDL").is(":checked")){
			post.dl="true";
		}
		if($("#trackOHP").is(":checked")){
			post.ohp="true";
		}
		post.wt = $("#wt").val();
		post.date = $("#datePicker").val();
		console.log(post);
		$.post("/track",post,function(data){
			if(data=="0"){
				$("#status").html("<span class='success'>Tracked!</span>")
			}
			else{
				$("#status").html("<span class='failure'>Tracking failed!</span>")
			}
			
		});
		
	}
	$(document).ready(function(){
		$("#results").tabs();
		$( "#datePicker" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true
		});
	
			$("#acc").tabs();
	});
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