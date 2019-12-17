<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<!--  JSP에서 jsoup을 사용하기 위해 import -->
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!-- The MIT License (MIT)

Copyright (c) 2014-2019 Dylan Weiss, Alain Dumesny, Pavel Reznikov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. -->
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%

String id = "";
id = (String)session.getAttribute("id");            // request에서 id 파라미터를 가져온다
if(id==null || id.equals("")){                            // id가 Null 이거나 없을 경우
	response.sendRedirect("/Resources/Test/login.jsp");    // 로그인 페이지로 리다이렉트 한다.
}


%>


<%
Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	    float[] card1 = new float[4];
	    float[] card2 = new float[4];
	    float[] card3 = new float[4];
	    float[] card4 = new float[4];
	    float[] card5 = new float[4];
	    float[] card6 = new float[4];
	    String card1_title="";
	    String card2_title="";
	    String card3_title="";
	    String card4_title="";
	    String card5_title="";
	    String card6_title="";
	    int card1_fontsize=15;
	    int card2_fontsize=15;
	    int card3_fontsize=15;
	    int card4_fontsize=15;
	    int card5_fontsize=15;
	    int card6_fontsize=15;
		int url_Idx=-1;
		try{
			String jdbcDriver = "jdbc:mysql://localhost:3306/sys?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
			String dbUser = "root";
			String dbPwd = "$cert0188";
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
			
			
			pstmt = conn.prepareStatement("SELECT * FROM user_table_info WHERE idx=(SELECT idx FROM user_table_info WHERE idx=(SELECT idx from user_info where user_id= ?))");
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			while(rs.next()){
			    card1[0]=rs.getFloat("card_1_data_gs_x");
			    card1[1]=rs.getFloat("card_1_data_gs_y");
			    card1[2]=rs.getFloat("card_1_data_gs_width");
			    card1[3]=rs.getFloat("card_1_data_gs_height");
			    card2[0]=rs.getFloat("card_2_data_gs_x");
			    card2[1]=rs.getFloat("card_2_data_gs_y");
			    card2[2]=rs.getFloat("card_2_data_gs_width");
			    card2[3]=rs.getFloat("card_2_data_gs_height");
			    card3[0]=rs.getFloat("card_3_data_gs_x");
			    card3[1]=rs.getFloat("card_3_data_gs_y");
			    card3[2]=rs.getFloat("card_3_data_gs_width");
			    card3[3]=rs.getFloat("card_3_data_gs_height");
			    card4[0]=rs.getFloat("card_4_data_gs_x");
			    card4[1]=rs.getFloat("card_4_data_gs_y");
			    card4[2]=rs.getFloat("card_4_data_gs_width");
			    card4[3]=rs.getFloat("card_4_data_gs_height");
			    card5[0]=rs.getFloat("card_5_data_gs_x");
			    card5[1]=rs.getFloat("card_5_data_gs_y");
			    card5[2]=rs.getFloat("card_5_data_gs_width");
			    card5[3]=rs.getFloat("card_5_data_gs_height");
			    card6[0]=rs.getFloat("card_6_data_gs_x");
			    card6[1]=rs.getFloat("card_6_data_gs_y");
			    card6[2]=rs.getFloat("card_6_data_gs_width");
			    card6[3]=rs.getFloat("card_6_data_gs_height");
			    card1_title=rs.getString("card1_title");
			    card2_title=rs.getString("card2_title");
			    card3_title=rs.getString("card3_title");
			    card4_title=rs.getString("card4_title");
			    card5_title=rs.getString("card5_title");
			    card6_title=rs.getString("card6_title");
			    card1_fontsize=rs.getInt("card1_fontsize");
			    card2_fontsize=rs.getInt("card2_fontsize");
			    card3_fontsize=rs.getInt("card3_fontsize");
			    card4_fontsize=rs.getInt("card4_fontsize");
			    card5_fontsize=rs.getInt("card5_fontsize");
			    card6_fontsize=rs.getInt("card6_fontsize");
			}
		}catch(SQLException se){
			se.printStackTrace();
		}finally{
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
			
			%>
<!DOCTYPE html>
<html lang="en">
  <head>
  		<meta
			name="viewport"
			content="width=device-width, initial-scale=1.0, shrink-to-fit=no, user-scalable=yes"
		/>
				<script
			type="module"
			src="https://unpkg.com/ionicons@4.5.10-0/dist/ionicons/ionicons.esm.js"
		></script>
		<script
			nomodule=""
			src="https://unpkg.com/ionicons@4.5.10-0/dist/ionicons/ionicons.js"
		></script>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>

		<script src="https://cdn.jsdelivr.net/npm/gridstack@0.5.1/dist/gridstack.all.js"></script>
		<script
			src="https://getbootstrap.com/docs/4.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o"
			crossorigin="anonymous"
		></script>
		<script src="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@9.16.2/build/highlight.min.js"></script>
		<script>$(document).ready(function(){

	  	  $('#btn2').on('click', function(){
	  		  $.ajax({
	  		        url:'/Resources/Test/insertcod.jsp',
	  		        type: 'post',
	  		        data: {
	  		        	//alert($(card_3).attr("data-gs-x"));
	  		        	card_1_data_gs_x:$(card_1).attr("data-gs-x"),
	  		        	card_1_data_gs_y:$(card_1).attr("data-gs-y"),
	  		        	card_1_data_gs_width:$(card_1).attr("data-gs-width"),
	  		        	card_1_data_gs_height:$(card_1).attr("data-gs-height"),
	  		        	card_2_data_gs_x:$(card_2).attr("data-gs-x"),
	  		        	card_2_data_gs_y:$(card_2).attr("data-gs-y"),
	  		        	card_2_data_gs_width:$(card_2).attr("data-gs-width"),
	  		        	card_2_data_gs_height:$(card_2).attr("data-gs-height"),
	  		        	card_3_data_gs_x:$(card_3).attr("data-gs-x"),
	  		        	card_3_data_gs_y:$(card_3).attr("data-gs-y"),
	  		        	card_3_data_gs_width:$(card_3).attr("data-gs-width"),
	  		        	card_3_data_gs_height:$(card_3).attr("data-gs-height"),
	  		        	card_4_data_gs_x:$(card_4).attr("data-gs-x"),
	  		        	card_4_data_gs_y:$(card_4).attr("data-gs-y"),
	  		        	card_4_data_gs_width:$(card_4).attr("data-gs-width"),
	  		        	card_4_data_gs_height:$(card_4).attr("data-gs-height"),
	  		        	card_5_data_gs_x:$(card_5).attr("data-gs-x"),
	  		        	card_5_data_gs_y:$(card_5).attr("data-gs-y"),
	  		        	card_5_data_gs_width:$(card_5).attr("data-gs-width"),
	  		        	card_5_data_gs_height:$(card_5).attr("data-gs-height"),
	  		        	card_6_data_gs_x:$(card_6).attr("data-gs-x"),
	  		        	card_6_data_gs_y:$(card_6).attr("data-gs-y"),
	  		        	card_6_data_gs_width:$(card_6).attr("data-gs-width"),
	  		        	card_6_data_gs_height:$(card_6).attr("data-gs-height"),
	  		        	card1_title:$(card1_title).val(),
	  		        	card2_title:$(card2_title).val(),
	  		        	card3_title:$(card3_title).val(),
	  		        	card4_title:$(card4_title).val(),
	  		        	card5_title:$(card5_title).val(),
	  		        	card6_title:$(card6_title).val()
	  		        	},
	  		        success : function(data){
	  		        	alert("저장완료!");
	  		       	        },
	  		        error: function(err) {
	  		         	alert("에러!");
	  		        }
	  		    });
	  	  })
		})
	  	  </script>
  <style>
::-webkit-scrollbar-track
{
 -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
 border-radius: 10px;
 background-color: #F5F5F5;
}

::-webkit-scrollbar
{
 width: 12px;
 background-color: #F5F5F5;
}

::-webkit-scrollbar-thumb
{
 border-radius: 10px;
 -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
 background-color: #555;
}
		<style type="text/css">
			.grid-stack-item {
				border: 0;
				
			}

			#demo h1,
			#getStarted h1 {
				font-size: 3rem;
			}

			.card {
				background: none;
			}

			section {
				padding: 0 15px 0 15px;
			}

			.grid-stack-item-removing {
				opacity: 0.8;
				filter: blur(5px);
			}
			@media all and (max-width: 575px) {
				#hero {
					margin-top: 32px;
				}
			}
			.logo {
				display: inline;
				margin-right: 15px;
			}
			#card1{
			font-size:<%=card1_fontsize%>px;
			}
			#card1 *{
			font-size:<%=card1_fontsize%>px;
			}
			#card2{
			font-size:<%=card2_fontsize%>px;
			}
			#card2 *{
			font-size:<%=card2_fontsize%>px;
			}
			#card3{
			font-size:<%=card3_fontsize%>px;
			}
			#card3 *{
			font-size:<%=card3_fontsize%>px;
			}
			#card4{
			font-size:<%=card4_fontsize%>px;
			}
			#card4 *{
			font-size:<%=card4_fontsize%>px;
			}
			#card5{
			font-size:<%=card5_fontsize%>px;
			}
			#card5 *{
			font-size:<%=card5_fontsize%>px;
			}
			#card6{
			font-size:<%=card6_fontsize%>px;
			}
			#card6 *{
			font-size:<%=card6_fontsize%>px;
			}
</style>
			
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

	<script src="/Resources/vendors/jquery-ui-touch/jquery.ui.touch.js"></script>
    <!-- FastClick -->
    <script src="/Resources/vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="/Resources/vendors/nprogress/nprogress.js"></script>
    <!-- Chart.js -->
    <script src="/Resources/vendors/Chart.js/dist/Chart.min.js"></script>
    <!-- jQuery Sparklines -->
    <script src="/Resources/vendors/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
    <!-- DateJS -->
    <script src="/Resources/vendors/DateJS/build/date.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="/Resources/vendors/moment/min/moment.min.js"></script>
    <script src="/Resources/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
        <!-- iCheck -->
    <script src="/Resources/vendors/iCheck/icheck.min.js"></script>

    		     	<!-- custom scrollbar stylesheet -->
	<link rel="stylesheet" href="/Resources/scrollbar/jquery.mCustomScrollbar.css">
    <title>EZ2C! 한눈에 보는 공지사항! | </title>
<script>
function inner(url_Idx){
	id_card="card"+url_Idx;
	//document.getElementById("card1").innerHTML="test1";
	document.getElementById(eval("'"+id_card+"'")).innerHTML = document.getElementById('hid').innerHTML;
	$('#hid').html('');
};
</script>
    <!-- Bootstrap -->
		<link
			href="https://bootswatch.com/4/yeti/bootstrap.min.css"
			rel="stylesheet"
		/>
				<link
			href="https://cdn.jsdelivr.net/npm/gridstack@0.5.1/dist/gridstack.css"
			rel="stylesheet"
		/>
		<link
			rel="stylesheet"
			href="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@9.16.2/build/styles/default.min.css"
		/>
    <!-- Font Awesome -->
    <link href="/Resources/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="/Resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- bootstrap-daterangepicker -->
    <link href="/Resources/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="/Resources/build/css/custom.min.css" rel="stylesheet">
    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" ></script>
  </head>



<script>
$(function() {
	$('#simple-grid').gridstack({
		alwaysShowResizeHandle: /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
			navigator.userAgent
		),
		resizable: {
			handles: 'e, se, s, sw, w'
		}
	});
	$('#advanced-grid').gridstack({
		alwaysShowResizeHandle: /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
			navigator.userAgent
		),
		resizable: {
			handles: 'e, se, s, sw, w'
		},
		removable: '#trash',
		removeTimeout: 100,
		acceptWidgets: '.newWidget'
	});
	$('.newWidget').draggable({
		revert: 'invalid',
		scroll: false,
		appendTo: 'body',
		helper: 'clone'
	});
	$('.nav-item').on('click', function(event) {
		$('.nav-item').removeClass('active');
		var target = $(event.currentTarget);
		if (target.hasClass('nav-item-highlight')) {
			target.addClass('active');
		}
	});
	hljs.initHighlightingOnLoad();
});

function sessionDel(){
	location.href="/Resources/Test/logout.jsp"; 
};
function help(){
	window.open("https://youtu.be/6m-45YrrWbk","","fullscreen,scrollbars")
};
function goToInsertUrl(){
	window.open('/Resources/Test/InsertUrl.jsp', 'newWindow');
};
function goToFontSet(){
	window.open('/Resources/Test/fontsetting.jsp', 'newWindow');
};
</script>
  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index2.jsp" class="site_title"><i class="fa fa-paw"></i> <span>EZ2C</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="/Resources/Test/images/img.jpg" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome,</span>
                <h2><%=id %></h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3>General</h3>
                <ul class="nav side-menu">
                  <li><a><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="index2.jsp">Dashboard</a></li>
                      <li><a href="InsertUrl.jsp">InsertUrl</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-edit"></i> Forms <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="form.html">General Form</a></li>
                      <li><a href="form_advanced.html">Advanced Components</a></li>
                      <li><a href="form_validation.html">Form Validation</a></li>
                      <li><a href="form_wizards.html">Form Wizard</a></li>
                      <li><a href="form_upload.html">Form Upload</a></li>
                      <li><a href="form_buttons.html">Form Buttons</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-desktop"></i> Coming Soon <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="general_elements.html">General Elements</a></li>
                      <li><a href="media_gallery.html">Media Gallery</a></li>
                      <li><a href="typography.html">Typography</a></li>
                      <li><a href="icons.html">Icons</a></li>
                      <li><a href="glyphicons.html">Glyphicons</a></li>
                      <li><a href="widgets.html">Widgets</a></li>
                      <li><a href="invoice.html">Invoice</a></li>
                      <li><a href="inbox.html">Inbox</a></li>
                      <li><a href="calendar.html">Calendar</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-table"></i> Tables <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="tables.html">Tables</a></li>
                      <li><a href="tables_dynamic.html">Table Dynamic</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-bar-chart-o"></i> Data Presentation <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="chartjs.html">Chart JS</a></li>
                      <li><a href="chartjs2.html">Chart JS2</a></li>
                      <li><a href="morisjs.html">Moris JS</a></li>
                      <li><a href="echarts.html">ECharts</a></li>
                      <li><a href="other_charts.html">Other Charts</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-clone"></i>Layouts <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="fixed_sidebar.html">Fixed Sidebar</a></li>
                      <li><a href="fixed_footer.html">Fixed Footer</a></li>
                    </ul>
                  </li>
                </ul>
              </div>
              <div class="menu_section">
                <h3>Live On</h3>
                <ul class="nav side-menu">
                  <li><a><i class="fa fa-bug"></i> Additional Pages <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="e_commerce.html">E-commerce</a></li>
                      <li><a href="projects.html">Projects</a></li>
                      <li><a href="project_detail.html">Project Detail</a></li>
                      <li><a href="contacts.html">Contacts</a></li>
                      <li><a href="profile.html">Profile</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-windows"></i> Extras <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="page_403.html">403 Error</a></li>
                      <li><a href="page_404.html">404 Error</a></li>
                      <li><a href="page_500.html">500 Error</a></li>
                      <li><a href="plain_page.html">Plain Page</a></li>
                      <li><a href="login.html">Login Page</a></li>
                      <li><a href="pricing_tables.html">Pricing Tables</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-sitemap"></i> Multilevel Menu <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="#level1_1">Level One</a>
                        <li><a>Level One<span class="fa fa-chevron-down"></span></a>
                          <ul class="nav child_menu">
                            <li class="sub_menu"><a href="level2.html">Level Two</a>
                            </li>
                            <li><a href="#level2_1">Level Two</a>
                            </li>
                            <li><a href="#level2_2">Level Two</a>
                            </li>
                          </ul>
                        </li>
                        <li><a href="#level1_2">Level One</a>
                        </li>
                    </ul>
                  </li>                  
                  <li><a href="javascript:void(0)"><i class="fa fa-laptop"></i> Landing Page <span class="label label-success pull-right">Coming Soon</span></a></li>
                </ul>
              </div>
            </div>
            <!-- /sidebar menu -->
            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="InserUrl" href="javascript:goToInsertUrl();">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a href="javascript:sessionDel();" data-toggle="tooltip" data-placement="top" title="Logout">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
            <div class="nav_menu">
                <div class="nav toggle">
                  <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                </div>
                <nav class="nav navbar-nav">
                <ul class=" navbar-right">
                  <li class="nav-item dropdown open" style="padding-left: 15px;">
                    <a href="javascript:;" class="user-profile dropdown-toggle" aria-haspopup="true" id="navbarDropdown" data-toggle="dropdown" aria-expanded="false">
                      <img src="images/img.jpg" alt=""><%=id %>
                    </a>
                    <div class="dropdown-menu dropdown-usermenu pull-right" aria-labelledby="navbarDropdown">
                      <a class="dropdown-item"  href="javascript:goToFontSet();"> 글자크기변경</a>
                        <a class="dropdown-item"  href="javascript:goToInsertUrl();">
                          <span class="badge bg-green pull-right">URL추가</span>
                          <span>InsertUrl</span>
                        </a>
                    <a class="dropdown-item" href="javascript:help();">Help</a>
                      <a href="javascript:sessionDel();" class="dropdown-item"><i class="fa fa-sign-out pull-right"></i> Log Out</a>
                    </div>
                  </li>
  
                  <li role="presentation" class="nav-item dropdown open">
                    <a href="javascript:;" class="dropdown-toggle info-number" id="navbarDropdown1" data-toggle="dropdown" aria-expanded="false">
                      <i class="fa fa-envelope-o"></i>
                      <span class="badge bg-green">4</span>
                    </a>
                    <ul class="dropdown-menu list-unstyled msg_list" role="menu" aria-labelledby="navbarDropdown1">
                      <li class="nav-item">
                        <a class="dropdown-item">
                          <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                          <span>
                            <span>관리자</span>
                            <span class="time">3 mins ago</span>
                          </span>
                          <span class="message">
                            왼쪽탭에 InsertUrl을 이용하면 웹페이지를 추가할 수 있습니다.
                          </span>
                        </a>
                      </li>
                      <li class="nav-item">
                        <a class="dropdown-item">
                          <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                          <span>
                            <span>관리자</span>
                            <span class="time">3 mins ago</span>
                          </span>
                          <span class="message">
                          안되는 기능들이 대부분입니다! help를 눌러 나오는 유튜브영상의 기능이 전부입니다
                          </span>
                        </a>
                      </li>
                      <li class="nav-item">
                        <a class="dropdown-item">
                          <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                          <span>
                            <span>관리자</span>
                            <span class="time">3 mins ago</span>
                          </span>
                          <span class="message">
                            앞에있는 카드모양의 테이블들을 자유롭게 움직이고, 크기조정을 한 뒤 대시보드 저장버튼을 누르면 저장됩니다.
                          </span>
                        </a>
                      </li>
                      <li class="nav-item">
                        <a class="dropdown-item">
                          <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                          <span>
                            <span>관리자</span>
                            <span class="time">3 mins ago</span>
                          </span>
                          <span class="message">
                            추가 궁금하신 사항은 메시지버튼 오른쪽에있는 계정을 클릭하신 후 HELP를 눌러주세요
                          </span>
                        </a>
                      </li>
                      <li class="nav-item">
                        <div class="text-center">
                          <a class="dropdown-item">
                            <strong>See All Alerts</strong>
                            <i class="fa fa-angle-right"></i>
                          </a>
                        </div>
                      </li>
                    </ul>
                  </li>
                </ul>
              </nav>
            </div>
          </div>
        <!-- /top navigation -->

        <!-- page content -->
          <div class="">

        <div class="right_col" role="main">
          
			<section id="demo" class="bg-light">
				<div class="row">
					<div class="col-sm-12" style="padding-bottom: 25px;">
						<div style="padding: 15px; border: 1px solid white">
							<div class="grid-stack" id="simple-grid" data-gs-width="12" data-gs-animate="yes">
								<div id="card_1"
									class="grid-stack-item card"
									data-gs-x="<%=card1[0]%>"
									data-gs-y="<%=card1[1]%>"
									data-gs-width="<%=card1[2]%>"
									data-gs-height="<%=card1[3]%>"
								>	
									<div class="grid-stack-item-content card-body bg-white" >
									<p><input type="text" id="card1_title" style="border-right:0px; border-top:0px; border-left:0px; border-bottom:1px solid;" maxlength="30" placeholder="TableNumber 1" value="<%=card1_title%>"></p>
										<p id="card1">1</p>
									</div>
								</div>
								<div id="card_2"
									class="grid-stack-item card"
									data-gs-x="<%=card2[0]%>"
									data-gs-y="<%=card2[1]%>"
									data-gs-width="<%=card2[2]%>"
									data-gs-height="<%=card2[3]%>"
								>
									<div class="grid-stack-item-content card-body bg-white">
									<p><input type="text" id="card2_title" style="border-right:0px; border-top:0px; border-left:0px; border-bottom:1px solid;" maxlength="30" placeholder="TableNumber 2" value="<%=card2_title%>"></p>
										<p id="card2">
											2
										</p>
									</div>
								</div>
								<div id="card_3"
									class="grid-stack-item card"
									data-gs-x="<%=card3[0]%>"
									data-gs-y="<%=card3[1]%>"
									data-gs-width="<%=card3[2]%>"
									data-gs-height="<%=card3[3]%>"
								>
								
									<div
										class="grid-stack-item-content card-body bg-white"
									>
									<p><input type="text" id="card3_title" style="border-right:0px; border-top:0px; border-left:0px; border-bottom:1px solid;" maxlength="30" placeholder="TableNumber 3" value="<%=card3_title%>"></p>
										<p id="card3" style="margin-bottom: 0">
											3
										</p>
									</div>
								</div>
								<div id="card_4"
									class="grid-stack-item card"
									data-gs-x="<%=card4[0]%>"
									data-gs-y="<%=card4[1]%>"
									data-gs-width="<%=card4[2]%>"
									data-gs-height="<%=card4[3]%>"
								>
									<div class="grid-stack-item-content card-body bg-white">
									<p><input type="text" id="card4_title" style="border-right:0px; border-top:0px; border-left:0px; border-bottom:1px solid;" maxlength="30" placeholder="TableNumber 4" value="<%=card4_title%>"></p>
										<p id="card4">4</p>
									</div>
								</div>
								<div id="card_5"
									class="grid-stack-item card"
									data-gs-x="<%=card5[0]%>"
									data-gs-y="<%=card5[1]%>"
									data-gs-width="<%=card5[2]%>"
									data-gs-height="<%=card5[3]%>"
								>
									<div class="grid-stack-item-content card-body bg-white">
									<p><input type="text" id="card5_title" style="border-right:0px; border-top:0px; border-left:0px; border-bottom:1px solid;" maxlength="30" placeholder="TableNumber 5" value="<%=card5_title%>"></p>
										<p id="card5">5</p>
									</div>
								</div>
								<div id="card_6"
									class="grid-stack-item card"
									data-gs-x="<%=card6[0]%>"
									data-gs-y="<%=card6[1]%>"
									data-gs-width="<%=card6[2]%>"
									data-gs-height="<%=card6[3]%>"
								>
									<div class="grid-stack-item-content card-body bg-white">
									<p><input type="text" id="card6_title" style="border-right:0px; border-top:0px; border-left:0px; border-bottom:1px solid;" maxlength="30" placeholder="TableNumber 6" value="<%=card6_title%>"></p>
										<p id="card6">6</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				                  <input class="btn btn-success submit" type="button" id="btn2" name="btn2" value="대시보드 저장하기"/>
			</section>
          </div>

        </div>
        <!-- /page content -->
                           <div class="col-md-6">
                           <div><input type="checkbox" onclick="toggleAutoRefresh(this);" id="reloadCB"> Auto Refresh</div>
                    <div id="reportrange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                      <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                      <span>Loading...</span> <b class="caret"></b>
                      
                    </div>
                    
                  </div>

      </div>
    </div>
		        <!-- footer content -->
        <footer>
          <div class="pull-right">
          	서울과학기술대학교 15109306 고병산</a><br>
            Gentelella - Bootstrap Admin Template by <a href="https://colorlib.com">Colorlib</a>
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
        
        <div id="hid" style='display:none;'>
	<%
	
		Class.forName("com.mysql.jdbc.Driver");
		//Connection conn = null;
		//PreparedStatement pstmt = null;
		//ResultSet rs = null;

		url_Idx=-1;
		try{
			String jdbcDriver = "jdbc:mysql://localhost:3306/sys?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
			String dbUser = "root";
			String dbPwd = "$cert0188";
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
			
			
			pstmt = conn.prepareStatement("SELECT * FROM user_table_info WHERE idx=(SELECT idx FROM user_table_info WHERE idx=(SELECT idx from user_info where user_id= ?))");
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			
			
			pstmt = conn.prepareStatement("select * from url_info WHERE user_idx = (SELECT idx from user_info WHERE user_id=?)");
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			String url=null;
			String tag=null;
			String tag2=null;
			while(rs.next()){
				url = rs.getString("url");
				tag = rs.getString("tag1");
				tag2 = rs.getString("tag2");
				url_Idx=rs.getInt("url_idx");
				HashMap<String,String> map = new HashMap<String,String>();
				map.put("url",url);
				map.put("tag",tag);
				map.put("tag2",tag2);
				Document doc3 = Jsoup.connect(map.get("url")).get();
		        String tag_tag=map.get("tag");
				Elements posts = doc3.select(tag_tag);
				//Elements posts = doc3.body().getElementsByClass(map.get("tag"));
				Elements file = posts.select(map.get("tag2"));
				 Elements select = file.select("a");
			        for(Element e : select){
			        	String absUrl = e.absUrl("href");
			        	e.attr("href",absUrl);
			        }
			        select = file.select("img");
			        for (Element e : select){
			            e.attr("src", e.absUrl("src"));
			        }
				for(Element e : file){
					String aa;
					String bb;
					String cc;
					aa=e.outerHtml();
					%>
					<%=aa %>
					<br>
					<%
					}
				%>
									
						
				<script>
				inner("<%=url_Idx%>");
				</script>
				
				<%
			}
		}catch(SQLException se){
			se.printStackTrace();
		}finally{
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		%>

        </div>
        <script>
        var reloading;

        function checkReloading() {
            if (window.location.hash=="#autoreload") {
                reloading=setTimeout("window.location.reload();", 100000);
                document.getElementById("reloadCB").checked=true;
            }
        }

        function toggleAutoRefresh(cb) {
            if (cb.checked) {
                window.location.replace("#autoreload");
                reloading=setTimeout("window.location.reload();", 100000);
            } else {
                window.location.replace("#");
                clearTimeout(reloading);
            }
        }

        window.onload=checkReloading;
        $(window).load(function(){

        	$('.grid-stack').css("touch-action", "none");
        	$('.grid-stack').addTouch();

        	});
		</script>
		
		





    <!-- gauge.js -->
    <script src="/Resources/vendors/gauge.js/dist/gauge.min.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="/Resources/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- Skycons -->
    <script src="/Resources/vendors/skycons/skycons.js"></script>
    <!-- JQVMap -->
    <script src="/Resources/vendors/jqvmap/dist/jquery.vmap.js"></script>
    <script src="/Resources/vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
    <script src="/Resources/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="/Resources/vendors/moment/min/moment.min.js"></script>
    <script src="/Resources/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="/Resources/build/js/custom.min.js"></script>

  </body>
</html>