<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
session.invalidate(); 
response.sendRedirect("login.jsp");    // 로그인 페이지로 리다이렉트 한다.
%>
