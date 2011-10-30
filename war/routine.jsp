<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="strstd.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="com.google.appengine.api.memcache.*"%>
<%@ page import="com.google.appengine.api.datastore.*"%>
<%
	boolean lbs = request.getParameter("measure").equals("lbs");
	boolean male = request.getParameter("sex").equals("male");
	boolean error = request.getParameter("ue").equals("true");
	GetData gd = null;
	if (session.getAttribute("id") != null) {
		gd = new GetData((Key) session.getAttribute("id"));
	}
	Double weight = 0.0;
	try {
		weight = Double.parseDouble(request.getParameter("weight"));
	} catch (Exception e) {

	}
	
	if (!lbs)
		weight *= 2.204622;
	Routine bp = new Routine();
	Routine squat = new Routine();
	Routine dl = new Routine();
	Routine ohp = new Routine();
	
		try {
	
		double benchWt = Double.parseDouble(request
				.getParameter("bp_Wt"));
		if (!lbs)
			benchWt *= 2.20462262;
		int benchRep = Integer.parseInt(request.getParameter("bpRep"));
		Benchpress bps = new Benchpress(male, weight, benchWt, benchRep);
		bp.setOrm(bps.calculateORM(),error,lbs);
	} catch (Exception e) {
		if (gd != null) {
			Benchpress bps = (Benchpress) gd.getLatestStandard("bp");
			if (bps != null)
				
				bp.setOrm(bps.calculateORM(),error,lbs);
		}
	}
	try {
		Squat squats;
		double squatWt = Double.parseDouble(request
				.getParameter("squat_Wt"));
		if (!lbs)
			squatWt *= 2.20462262;
		int squatRep = Integer.parseInt(request
				.getParameter("squatRep"));
		squats = new Squat(male, weight, squatWt, squatRep);
		squat.setOrm(squats.calculateORM(),error,lbs);
	} catch (Exception e) {
		if (gd != null) {
			Squat squats = (Squat) gd.getLatestStandard("squat");
			if (squats != null)
				squat.setOrm(squats.calculateORM(),error,lbs);
		}
	}
	try {
		Deadlift dls;
		double dlWt = Double.parseDouble(request.getParameter("dl_Wt"));
		if (!lbs)
			dlWt *= 2.20462262;
		int dlRep = Integer.parseInt(request.getParameter("dlRep"));
		dls = new Deadlift(male, weight, dlWt, dlRep);
		dl.setOrm(dls.calculateORM(),error,lbs);
	} catch (Exception e) {
		if (gd != null) {
			Deadlift dls = (Deadlift) gd.getLatestStandard("dl");
			if (dls != null)
				dl.setOrm(dls.calculateORM(),error,lbs);
		}
	}
	try {
		
		double ohpWt = Double.parseDouble(request
				.getParameter("ohp_Wt"));
		if (!lbs)
			ohpWt *= 2.20462262;
		int ohpRep = Integer.parseInt(request.getParameter("ohpRep"));
		Press ohps = new Press(male, weight, ohpWt, ohpRep);
		ohp.setOrm(ohps.calculateORM(),error,lbs);
	} catch (Exception e) {
		if (gd != null) {
			Press ohps = (Press) gd.getLatestStandard("ohp");
			if (ohps != null)
				ohp.setOrm(ohps.calculateORM(),error,lbs);
		}
	}
%>

<a class="jslink"
	href='http://www.t-nation.com/free_online_article/sports_body_training_performance/how_to_build_pure_strength'>What
	is the 5/3/1 program?</a>
<br />
<br />
<form id="4week" action="/printable.jsp" method="POST"><input type="hidden" name="bp" value="<%=bp.trueOrm %>"/>
<input type="hidden"  name="ohp" value="<%=ohp.trueOrm %>"/>
<input type="hidden" name="dl" value="<%=dl.trueOrm %>"/>
<input type="hidden" name="squat" value="<%=squat.trueOrm %>"/>

<input type="hidden" name="lbs" value="<%=lbs%>"/>
<input type="hidden" name="error" value="<%=error%>"/>
<input type="hidden" name="o" /></form>
<button onclick="print()">
	<img src="/images/print.png" /> Get printable 4 week training routine </button>

<br>
<br>
<center>
	<h1>Warm up:</h1>
	<table cellpadding="10px" cellspacing="0"
		style="border-style: solid; border-color: #000; border-width: 1px">
		<tr style="background-color: #3388FE; font-weight: bold">
			<td>Bench Press</td>
			<td>Squats</td>
			<td>Overhead Press</td>
			<td>Deadlift</td>
		</tr>
		<tr style="text-align: center">
			<td><%=bp.warmUp[0]%>
				</td>
			<td><%=squat.warmUp[0]%></td>
			<td><%=ohp.warmUp[0]%></td>
			<td><%=dl.warmUp[0]%></td>
		</tr>
		<tr style="text-align: center">
			<td><%=bp.warmUp[1]%>
				</td>
			<td><%=squat.warmUp[1]%></td>
			<td><%=ohp.warmUp[1]%></td>
			<td><%=dl.warmUp[1]%></td>
		</tr>
		<tr style="text-align: center">
			<td><%=bp.warmUp[2]%>
				</td>
			<td><%=squat.warmUp[2]%></td>
			<td><%=ohp.warmUp[2]%></td>
			<td><%=dl.warmUp[2]%></td>
		</tr>
	</table>
	<br>
	<br>
	<h1>5/3/1 Weights:</h1>
	<table cellpadding="10px" cellspacing="0">
		<tr style="background-color: #555; color: #EEE">
			<td></td>
			<td></td>
			<td>Week 1</td>
			<td>Week 2</td>
			<td>Week 3</td>
			<td>Week 4</td>
		</tr>
		<tr class='benchRows'>
			<td rowspan="3"><b>Bench Press
			</td>
			<td>Set 1</td>
			<td><%=bp.routine[0][0]%></td>
			<td><%=bp.routine[1][0]%></td>
			<td><%=bp.routine[2][0]%></td>
			<td><%=bp.routine[3][0]%></td>
		</tr>
		<tr class='benchRows'>
			<td>Set 2</td>
			<td><%=bp.routine[0][1]%></td>
			<td><%=bp.routine[1][1]%></td>
			<td><%=bp.routine[2][1]%></td>
			<td><%=bp.routine[3][1]%></td>
		</tr>
		<tr class='benchRows'>
			<td>Set 3</td>
			<td><%=bp.routine[0][2]%></td>
			<td><%=bp.routine[1][2]%></td>
			<td><%=bp.routine[2][2]%></td>
			<td><%=bp.routine[3][2]%></td>
		</tr>
		<tr class='squatRows'>
			<td rowspan="3"><b>Squats
			</td>
			<td>Set 1</td>
			<td><%=squat.routine[0][0]%></td>
			<td><%=squat.routine[1][0]%></td>
			<td><%=squat.routine[2][0]%></td>
			<td><%=squat.routine[3][0]%></td>
		</tr>
		<tr class='squatRows'>
			<td>Set 2</td>
			<td><%=squat.routine[0][1]%></td>
			<td><%=squat.routine[1][1]%></td>
			<td><%=squat.routine[2][1]%></td>
			<td><%=squat.routine[3][1]%></td>
		</tr>
		<tr class='squatRows'>
			<td>Set 3</td>
			<td><%=squat.routine[0][2]%></td>
			<td><%=squat.routine[1][2]%></td>
			<td><%=squat.routine[2][2]%></td>
			<td><%=squat.routine[3][2]%></td>
		</tr>
		<tr class='dlRows'>
			<td rowspan="3"><b>Deadlifts
			</td>
			<td>Set 1</td>
			<td><%=dl.routine[0][0]%></td>
			<td><%=dl.routine[1][0]%></td>
			<td><%=dl.routine[2][0]%></td>
			<td><%=dl.routine[3][0]%></td>
		</tr>
		<tr class='dlRows'>
			<td>Set 2</td>
			<td><%=dl.routine[0][1]%></td>
			<td><%=dl.routine[1][1]%></td>
			<td><%=dl.routine[2][1]%></td>
			<td><%=dl.routine[3][1]%></td>
		</tr>
		<tr class='dlRows'>
			<td>Set 3</td>
			<td><%=dl.routine[0][2]%></td>
			<td><%=dl.routine[1][2]%></td>
			<td><%=dl.routine[2][2]%></td>
			<td><%=dl.routine[3][2]%></td>
		</tr>
		<tr class='ohpRows'>
			<td rowspan="3"><b>Overhead Press
			</td>
			<td>Set 1</td>
			<td><%=ohp.routine[0][0]%></td>
			<td><%=ohp.routine[1][0]%></td>
			<td><%=ohp.routine[2][0]%></td>
			<td><%=ohp.routine[3][0]%></td>
		</tr>
		<tr class='ohpRows'>
			<td>Set 2</td>
			<td><%=ohp.routine[0][1]%></td>
			<td><%=ohp.routine[1][1]%></td>
			<td><%=ohp.routine[2][1]%></td>
			<td><%=ohp.routine[3][1]%></td>
		</tr>
		<tr class='ohpRows'>
			<td>Set 3</td>
			<td><%=ohp.routine[0][2]%></td>
			<td><%=ohp.routine[1][2]%></td>
			<td><%=ohp.routine[2][2]%></td>
			<td><%=ohp.routine[3][2]%></td>
		</tr>
	</table>

	<br />
	<h1>Complete Routine with Accessory work</h1>
	<br />
</center>
<br />
<div id="acc">
	<h2 class="current">Big But Boring</h2>
	<div class="accPane" style="display: block" id="r1">
		<span class="title">Day 1</span><br /> Overhead Press - 5/3/1<br />
		Overhead Press - <%=ohp.bbb %>
		<br /> Chin-ups - 5 sets of 10 reps <br />
		<br /> <span class="title">Day 2</span><br /> Deadlift - 5/3/1 <br />
		Deadlift - <%=dl.bbb %>
		<br /> Hanging Leg Raise - 5 sets of 15 reps <br />
		<br /> <span class="title">Day 3</span><br /> Bench Press - 5/3/1 <br />
		Bench Press - <%=bp.bbb %>
		<br /> Dumbbell Row - 5 sets of 10 reps <br />
		<br /> <span class="title">Day 4</span><br /> Squat - 5/3/1 <br />
		Squat - <%=squat.bbb %>
		<br /> Leg Curl - 5 sets of 10 reps <br />
	</div>

	<h2>The Triumvirate</h2>
	<div class="accPane" id="r2">
		<span class="title">Day 1</span> <br />Overhead Press - 5/3/1 <br />Dips
		- 5 sets of 15 reps <br />Chin-ups - 5 sets of 10 reps <br /> <br />
		<span class="title">Day 2</span> <br />Deadlift - 5/3/1 <br />Good
		Morning - 5 sets of 12 reps <br />Hanging Leg Raise - 5 sets of 15
		reps <br /> <br />
		<span class="title">Day 3</span> <br />Bench Press - 5/3/1 <br />Dumbbell
		Bench Press - 5 sets of 15 reps <br />Dumbbell Row - 5 sets of 10
		reps <br /> <br />
		<span class="title">Day 4</span> <br />Squat - 5/3/1 <br />Leg Press
		- 5 sets of 15 reps <br />Leg Curl - 5 sets of 10 reps <br /> <br />
		<br />
	</div>
	<h2>I'm Not Doing Jack Shit</h2>
	<div class="accPane" id="r3">
		<span class="title">Day 1</span><br /> Overhead Press - 5/3/1<br />
		<br /> <span class="title">Day 2</span><br /> Deadlift - 5/3/1<br />
		<br /> <span class="title">Day 3</span><br /> Bench Press - 5/3/1<br />
		<br /> <span class="title">Day 4</span><br /> Squat - 5/3/1
	</div>
	<h2>Dave Tate's Periodization Bible</h2>
	<div class="accPane" id="r4">
		<span class="title">Day 1</span> <br />Overhead Press - 5/3/1 <br />Shoulders
		or Chest - 5 sets of 10 - 20 reps (DB bench, DB Incline, DB Military,
		Incline press, Dips, Pushups) <br />Lats or Upper Back - 5 sets of 10
		- 20 reps (DB rows, Bent Over Rows, Chins, T - bar Rows, Lat
		Pulldowns, Face Pulls, Shrugs) <br />Triceps - 5 sets of 10 - 20 reps
		(Triceps Pushdowns or Triceps Extensions) <br /> <br />
		<span class="title">Day 2</span> <br />Deadlift - 5/3/1 <br />Hamstrings
		- 5 sets of 10 - 20 reps (Leg Curls, Glute - Ham Raise) <br />Quads -
		5 sets of 10 - 20 reps (Leg Press, Lunges, Hack Squats) <br />Abs - 5
		sets of 10 - 20 reps (Sit - ups, Hanging Leg Raises, Ab Wheel, DB Side
		Bend) <br /> <br />
		<span class="title">Day 3</span> <br />Bench Press - 5/3/1 <br />Shoulders
		or Chest - 5 sets of 10 - 20 reps (DB bench, DB Incline, DB Military,
		Incline press, Dips, Pushups) <br />Lats or Upper Back - 5 sets of 10
		- 20 reps (DB rows, Bent Over Rows, Chins, T - bar Rows, Lat
		Pulldowns, Face Pulls, Shrugs) <br />Triceps - 5 sets of 10 - 20 reps
		(Triceps Pushdowns or Triceps Extensions) <br /> <br />
		<span class="title">Day 4</span> <br />Squat - 5/3/1 <br />Low Back
		- 5 sets of 10 - 20 reps (Reverse Hyper, Back Raise, Good Morning) <br />Quads
		- 5 sets of 10 - 20 reps (Leg Press, Lunges, Hack Squats) <br />Abs -
		5 sets of 10 - 20 reps (Sit - ups, Hanging Leg Raises, Ab Wheel, DB
		Side Bend)
	</div>
	<h2>Body weight</h2>
	<div class="accPane" id="r5">
		<span class="title">Day 1</span><br /> Overhead Press - 5/3/1 <br />
		Chins - 5xF <br /> Dips - 5xF <br /> <br /> <span class="title">Day
			2</span><br /> Deadlift - 5/3/1 <br /> Glute Ham Raises - 5xF <br /> Leg
		Raises - 5xF <br /> <br /> <span class="title">Day 3</span><br />
		Benchpress - 5/3/1 <br /> Chins - 5xF <br /> Pushups - 5xF <br /> <br />
		<span class="title">Day 4</span><br /> Squat - 5/3/1 <br /> One
		Legged Squat - 5xF <br /> Sit-ups - 5xF <br /> <br />
	</div>
</div>