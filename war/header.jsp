<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="strstd.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="com.google.appengine.api.memcache.*"%>
<%@ page import="com.google.appengine.api.datastore.*" %>
<%
if(!request.getRequestURL().toString().contains("strstd")&&!request.getRequestURL().toString().contains("localhost")&&!request.getRequestURL().toString().startsWith("2")){
	response.sendRedirect("http://www.strstd.com");
}

%>