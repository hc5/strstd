<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<%if(session.getAttribute("id")!=null){ %>
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