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
    <%

String id = "";
id = (String)session.getAttribute("id");            // request에서 id 파라미터를 가져온다
if(id==null || id.equals("")){                            // id가 Null 이거나 없을 경우
	response.sendRedirect("login.jsp");    // 로그인 페이지로 리다이렉트 한다.
}


%>
<!DOCTYPE html>
<html>
<head>	

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <title>Insert Url</title>
    <!-- Optional JavaScript -->
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="../vendors/animate.css/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
        <%
Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
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


<script language="JavaScript">
$(document).ready(function(){

	  $('#btn1').on('click', function(){
		  $.ajax({
		        url:'./fontsetdb.jsp',
		        type: 'post',
		        data: {
		        	font1:$('input#card_1_font').val(),
		        	font2:$('input#card_2_font').val(),
		        	font3:$('input#card_3_font').val(),
		        	font4:$('input#card_4_font').val(),
		        	font5:$('input#card_5_font').val(),
		        	font6:$('input#card_6_font').val(),
		        	},
		        success : function(data){
		        	alert("저장완료");
		       	        },
		        error: function(err) {
		         	alert("에러!");
		        }
		    });

	  })
})
  </script>
</head>


<body class="login">
             <div class="navbar nav_title" style="border: 0;">
              <a href="index2.jsp" class="site_title"><i class="fa fa-paw"></i> <span>EZ2C</span></a>
            </div>
      <div class="login_wrapper">
        <div class="animate form login_form">
  <div>
    <h6><i class="fa fa-paw"></i> 글자크기 조절 </h6>
  </div>
  <section class="login_content">
  <form name="form" id="form" method="post">
    <div >
      <label><%=card1_title %></label>
      <input class="form-control" placeholder="card1 fontsize px" id="card_1_font" name="url" type="text" value="<%=card1_fontsize%>"/>
    </div>
    <div >
      <label><%=card2_title %></label>
      <input class="form-control" placeholder="card2 fontsize px" id="card_2_font" name="url" type="text" value="<%=card2_fontsize%>"/>
    </div>
    <div >
      <label><%=card3_title %></label>
      <input class="form-control" placeholder="card3 fontsize px" id="card_3_font" name="url" type="text" value="<%=card3_fontsize%>"/>
    </div>
    <div >
      <label><%=card4_title %></label>
      <input class="form-control" placeholder="card4 fontsize px" id="card_4_font" name="url" type="text" value="<%=card4_fontsize%>"/>
    </div>
        <div >
      <label><%=card5_title %></label>
      <input class="form-control" placeholder="card5 fontsize px" id="card_5_font" name="url" type="text" value="<%=card5_fontsize%>"/>
    </div>
        <div >
      <label><%=card6_title %></label>
      <input class="form-control" placeholder="card6 fontsize px" id="card_6_font" name="url" type="text" value="<%=card6_fontsize%>"/>
    </div>
    <input class="btn btn-default submit" type="button" id="btn1" name="btn1" value="저장하기"/>
  </form>
  
  <!-- <iframe src ="crawling.jsp" id="if" name="ifr"></iframe>-->

 
</section>
</div>

</div>

</body>
</html>