<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="strstd.*"%>
<%@ page import="com.google.appengine.api.datastore.*" %>
<script type="text/javascript">
$(document).ready(function(){
<%
Key user = (Key)session.getAttribute("id");
GetData gd = new GetData(user);
if(request.getParameter("type").equals("grade")){%>
var chart = new Highcharts.Chart({
    chart: {
        renderTo: '<%=request.getParameter("container")%>',
        backgroundColor: 'rgba(255,255,255,0)',
       	spacingTop:50,
       	spacingBottom:50
    },
   
   
    title:{
    	text: "Graded progress",
    	style:{
    		color: '#555555',
    		fontSize: '18px',
    		fontWeight: 'bold'
    	} 
    },legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: -10,
        y: 100,
        borderWidth: 0
     },
     tooltip:{
    	formatter: function(){
    		var d = new Date();
    		d.setTime(this.x);
    		p = d;
    		return d.toUTCString().split(" ")[1]+" "+d.toUTCString().split(" ")[2]+':<br>'+this.point.name;
    		
    	} 
     },
     xAxis:{
    	 maxZoom:1000*60*60*24,
    	 type:"datetime"
     },
    yAxis:{
    	title:"grade",
    	min:0,
    	max:5,
    	tickInterval:1,
    	labels:{
    		enabled:false
    	},
    	plotBands:[{
    		from:0.0,
    		to:1.0,
    		color:'#ffffff',
    		label: {
    			text:"Untrained"
    		}
    	}
    	,{from:1.0,
    		to:2.0,
    		color:'#FFFFFF',
    		label: {
    			text:"Novice"
    		}}
    	,{from:2.0,
    		to:3.0,
    		color:'#FFFFFF',
    		label: {
    			text:"Intermediate"
    		}}
    	,{from:3.0,
    		to:4.0,
    		color:'#FFFFFF',
    		label: {
    			text:"Advanced"
    		}}
    	,{from:4.0,
    		to:5.0,
    		color:'#FFFFFF',
    		label: {
    			text:"Elite"
    		}}
    	           
    	           ]
    	
    },
    colors:["#0DA2FF","#FFC20D","#DE0B0B","#2E2E2E"]
    ,
    series: [{
    	name:"Bench Press",zIndex:1,
        data: <%=
     gd.getLiftGrade("bp")
        %>
    },{
    	name:"Squat",zIndex:1,
        data: <%=
       gd.getLiftGrade("squat")
        %>
    },{
    	name:"Overhead Press",zIndex:1,
        data: <%=
       gd.getLiftGrade("ohp")
        %>
    },{
    	name:"Deadlift",zIndex:1,
        data: <%=
       gd.getLiftGrade("dl")
        %>
    },{
        name:"Notes",zIndex:0,
        type:"column",
        data:<%=gd.getNotes(5)%>
        }],
        plotOptions:{
        	 series: {
        		 cursor: 'pointer',
        		 point: {
                     events: {
                         click: function() {
                           del(this);
                         }
                     }
                 },
        		 lineWidth:3,
         		
                 marker: {
                	 symbol:"circle",
                     enabled: true,
                     states: {
                         hover: {
                             enabled: true,
                             radius:6,
                             lineWidth:2
                         }
                     },
    				radius:4
                 },
                 zIndex:1
             },
       	 column:{
       		 color:'rgba(0,166,255,0.3)',
       		pointWidth:5,
       		shadow:false,
       		borderWidth:0,
       	
       	states:{
       		hover:{
       			brightness:0.2
       		}
       	},
        zIndex:0
       	 }
        }
});<%}%>
<%if(request.getParameter("type").equals("raw")){%>
var chart = new Highcharts.Chart({
    chart: {
        renderTo: '<%=request.getParameter("container")%>',
        backgroundColor: 'rgba(0,0,0,0)',
     	spacingTop:50,
       	spacingBottom:50
    },
    xAxis:{
   	 maxZoom:1000*60*60*24,
   	
   	 type:"datetime"
    },
    title:{
    	text: "Raw progress",
    	style:{
    		color: '#555555',
    		fontSize: '18px',
    		fontWeight: 'bold'
    	} 
    },legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: -10,
        y: 100,
        borderWidth: 0
     },
     tooltip:{
    	formatter: function(){
    		var d = new Date();
    		d.setTime(this.x);

    		return d.toUTCString().split(" ")[1]+" "+d.toUTCString().split(" ")[2]+':<br>'+this.point.name;
    	} 
     },
  
    
    series: [{
    	name:"Bench Press",zIndex:1,
    
        data: <%=
        gd.getLift("bp")
        %>
    },{
    	name:"Squat",zIndex:1,
        data: <%=
        gd.getLift("squat")
        %>
    },{
    	name:"Overhead Press",zIndex:1,
        data: <%=
        gd.getLift("ohp")
        %>
    },{
    	name:"Deadlift",zIndex:1,
        data: <%=
        gd.getLift("dl")
        %>
    },{
    name:"Notes",
    type:"column",
    zIndex:0,
    data:<%=gd.getNotes(-1)%>
    }],
    yAxis:{
    	title:"Weight",
    	min:0,
 		max:<%=(int)gd.max%>
    	
    },
    colors:["#0DA2FF","#FFC20D","#DE0B0B","#2E2E2E"]
    ,
     plotOptions:{
    	 series: {
    		 cursor: 'pointer',
    		 lineWidth:3,
    		 point: {
                 events: {
                     click: function() {
                       del(this);
                     }
                 }
             },
             marker: {
            	 symbol:"circle",
                 enabled: true,
                 states: {
                     hover: {
                         enabled: true,
                         radius:6,
                         lineWidth:2
                     }
                 },
				radius:4
             },
             zIndex:1
         },
    	 column:{
    		 color:'rgba(0,166,255,0.3)',
    		pointWidth:5,
    		shadow:false,
    		borderWidth:0,
            zIndex:0,
    	
    	states:{
    		hover:{
    			brightness:0.2
    		}
    	}
    	 }
     }
});<%}%>
<%if(request.getParameter("type").equals("weight")){%>
var chart = new Highcharts.Chart({
    chart: {
        renderTo: '<%=request.getParameter("container")%>',
        backgroundColor: 'rgba(0,0,0,0)',
     	spacingTop:50,
       	spacingBottom:50
    },
    xAxis:{
   	
   	 type:"datetime"
    },
    title:{
    	text: "Body weight",
    	style:{
    		color: '#555555',
    		fontSize: '18px',
    		fontWeight: 'bold'
    	} 
    },legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: -10,
        y: 100,
        borderWidth: 0
     },
     tooltip:{
    	formatter: function(){
    		var d = new Date();
    		d.setTime(this.x);
    		
    		return d.toUTCString().split(" ")[1]+" "+d.toUTCString().split(" ")[2]+':<br>'+this.point.name;
    	} 
     },
     
    yAxis:{
    	title:"Weight",
    	min:0,
 		maxPadding:0
 	
    	
    },
  	colors:["#333333"],
    series: [{
    	name:"Bodyweight",
    	zIndex:1,
        data: <%=
        gd.getBodyweight()
        %>
    },{
        name:"Notes",
        type:"column",
        zIndex:0,
        data:<%=gd.getNotes(-1)%>
        }],
        plotOptions:{
        	 series: {
        		 cursor: 'pointer',
        		 point: {
                     events: {
                         click: function() {
                           del(this);
                         }
                     }
                 },
        		 lineWidth:2,
        		
                  marker: {
                 	 symbol:"circle",
                      enabled: true,
                      states: {
                          hover: {
                              enabled: true,
                              radius:6,
                              lineWidth:2
                          }
                      },
     				radius:4
                  }
             },
       	 column:{
       		 color:'rgba(0,166,255,0.3)',
       		pointWidth:5,
       		shadow:false,
       		borderWidth:0,
       	
      
       	 }
        }
});<%}%>
});
</script>