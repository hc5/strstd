<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/css/printable.css" type="text/css" />
<title>Your 4 Week 5/3/1 Routine</title>

</head>
<body>
<center>
<%try{ %>
<%
Routine bp = new Routine();
Routine squat = new Routine();
Routine dl = new Routine();
Routine ohp = new Routine();

boolean lbs = request.getParameter("lbs").equals("true");
boolean error = request.getParameter("error").equals("true");
double bpOrm = Double.parseDouble(request.getParameter("bp"));
int o = Integer.parseInt(request.getParameter("o"));
if(bpOrm>0)
	bp.setOrm(bpOrm,error,lbs);
double squatOrm = Double.parseDouble(request.getParameter("squat"));
if(squatOrm>0)
	squat.setOrm(squatOrm,error,lbs);
double dlOrm = Double.parseDouble(request.getParameter("dl"));
if(dlOrm>0)
	dl.setOrm(dlOrm,error,lbs);
double ohpOrm = Double.parseDouble(request.getParameter("ohp"));
if(ohpOrm>0)
	ohp.setOrm(ohpOrm,error,lbs);
%>
<%for(int i = 0;i<4;i++){
	
	%>

<h1>Week <%=i+1 %></h1>
<table cellspacing=0 cellpadding=0>
<tr>
</tr>
<!-- 5/3/1 warmup -->
<tr>
<td></td>
<td class="header">Day 1<br>Overhead Press</td>
<td class="header">Day 2<br>Deadlift</td>
<td class="header">Day 3<br>Bench Press</td>
<td class="header">Day 4<br>Squats</td>
</tr>
<tr>
<td rowspan=3>Warm Up</td>
<td class="even"><%=ohp.warmUp[0] %></td>
<td class="odd"><%=dl.warmUp[0] %></td>
<td class="even"><%=bp.warmUp[0] %></td>
<td><%=squat.warmUp[0] %></td>
</tr>
<tr>
<td class="even"><%=ohp.warmUp[1] %></td>
<td class="odd"><%=dl.warmUp[1] %></td>
<td class="even"><%=bp.warmUp[1] %></td>
<td class="odd"><%=squat.warmUp[1] %></td>
</tr>
<tr>
<td class="even"><%=ohp.warmUp[2] %></td>
<td class="odd"><%=dl.warmUp[2] %></td>
<td class="even"><%=bp.warmUp[2] %></td>
<td class="odd"><%=squat.warmUp[2] %></td>
</tr>
<!-- 5/3/1  -->
<tr>
<td rowspan=3>5/3/1</td>
<td class="even"><%=ohp.routine[i][0] %></td>
<td class="odd"><%=dl.routine[i][0] %></td>
<td class="even"><%=bp.routine[i][0] %></td>
<td class="odd"><%=squat.routine[i][0] %></td>
</tr>
<tr>
<td class="even"><%=ohp.routine[i][1] %></td>
<td class="odd"><%=dl.routine[i][1] %></td>
<td class="even"><%=bp.routine[i][1] %></td>
<td class="odd"><%=squat.routine[i][1] %></td>
</tr>
<tr>
<td class="even"><%=ohp.routine[i][2] %></td>
<td class="odd"><%=dl.routine[i][2] %></td>
<td class="even"><%=bp.routine[i][2] %></td>
<td class="odd"><%=squat.routine[i][2] %></td>
</tr>
<!-- acc  -->
<%switch(o){

//Big But Boring
case 0:%>
<tr>
<td rowspan=2>Big But Boring</td>
<td class="even"><%=ohp.bbb %></td>
<td class="odd"><%=dl.bbb %></td>
<td class="even"><%=bp.bbb %></td>
<td class="odd"><%=squat.bbb %></td>
</tr>
<tr>
<td class="even">Chin-ups - 5 x 10</td>
<td class="odd">Hanging Leg Raise - 5 x 10</td>
<td class="even">Dumbbell Row - 5 x 10</td>
<td class="odd">Leg Curl - 5 x 10</td>
</tr>

<%break;

//The Triumvirate
case 1:%>
<tr>
<td rowspan=2>The Triumvirate</td>
<td class="even">Dips 5 x 15</td>
<td class="odd">Good Mornings 5 x 12</td>
<td class="even">Dumbbell Bench Press 5 x 15</td>
<td class="odd">Leg Press 5 x 15</td>
</tr>
<tr>
<td class="even">Chin-ups - 5 x 10</td>
<td class="odd">Hanging Leg Raise - 5 x 10</td>
<td class="even">Dumbbell Row - 5 x 10</td>
<td class="odd">Leg Curl - 5 x 10</td>
</tr>


<%
break;

//I'm not doing Jack Shit
case 2:%>


<%
break;

//Dave Tate's Periodization Bible
case 3:%>
<tr class="period">
<td rowspan=3>Dave Tate's Periodization Bible</td>
<td class="even">Shoulders or Chest - 5 x 10-20 (DB bench, DB Incline, DB Military,
		Incline press, Dips, Pushups) </td>
<td class="odd">Hamstrings - 5 x 10-20 reps (Leg Curls, Glute - Ham Raise)</td>
<td class="even">Shoulders or Chest - 5 x 10-20 (DB bench, DB Incline, DB Military,
		Incline press, Dips, Pushups)</td>
<td class="odd">Hamstrings - 5 x 10-20 reps (Leg Curls, Glute - Ham Raise)</td>
</tr>
<tr class="period">
<td class="even">Lats or Upper Back - 5 x 10-20 (DB rows, Bent Over Rows, Chins, T - bar Rows, Lat
		Pulldowns, Face Pulls, Shrugs)</td>
<td class="odd">Quads -	5 x 10-20 (Leg Press, Lunges, Hack Squats)</td>
<td class="even">Lats or Upper Back - 5 x 10-20 (DB rows, Bent Over Rows, Chins, T - bar Rows, Lat
		Pulldowns, Face Pulls, Shrugs)</td>
<td class="odd">Quads -	5 x 10-20 (Leg Press, Lunges, Hack Squats)</td>
</tr>
<tr class="period">
<td class="even">Triceps - 5 x 10-20 (Triceps Pushdowns or Triceps Extensions)</td>
<td class="odd">Abs - 5	x 20 (Sit - ups, Hanging Leg Raises, Ab Wheel, DB Side
		Bend)</td>
<td class="even">Triceps - 5 x 10-20 (Triceps Pushdowns or Triceps Extensions)</td>
<td class="odd">Abs - 5	x 20 (Sit - ups, Hanging Leg Raises, Ab Wheel, DB Side
		Bend)</td>
</tr>
<%
break;

//Body weight
case 4:%>
<tr>
<td rowspan=2>Body Weight</td>
<td class="even">Chins 5 x F</td>
<td class="odd">Glute Ham Raises - 5xF</td>
<td class="even">Chins - 5xF</td>
<td class="odd">One
		Legged Squat - 5xF</td>
</tr>
<tr>
<td class="even">Dips - 5 x F</td>
<td class="odd">Leg
		Raises - 5xF</td>
<td class="even">Pushups - 5xF</td>
<td class="odd">Sit-ups - 5xF</td>
</tr>

<%
break;

}%>

</table>
<br>
<%} %>
</center>
</body>
<%}catch(Exception e){
	response.sendRedirect("/");
	
} %>
</html>