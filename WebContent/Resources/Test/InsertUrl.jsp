<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.MalformedURLException" %>
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
        
    <%!
public static String getDomainName(String url) throws MalformedURLException{
    if(!url.startsWith("http") && !url.startsWith("https")){
         url = "http://" + url;
    }        
    URL netUrl = new URL(url);
    String host = netUrl.getHost();
    if(host.startsWith("www")){
        host = host.substring("www".length()+1);
    }
    return host;
}%>
<script language="JavaScript">
$(document).ready(function(){

	  $('#btn1').on('click', function(){
	  $.ajax({
	        url:'./crawling.jsp',
	        type: 'post',
	        data: {
	        	url:$('input#url').val(),
	        	tag:$('input#tag').val(),
	        	tag2:$('input#tag2').val()
	        	},
	        success : function(data){
	        	$("#content").html(data);
	       	        },
	        error: function(err) {
	         	alert("에러!");
	        }
	    });

  })
  	  $('#btn2').on('click', function(){
	  $.ajax({
	        url:'./insertdb.jsp',
	        type: 'post',
	        data: {
	        	url:$('input#url').val(),
	        	tag:$('input#tag').val(),
	        	tag2:$('input#tag2').val(),
	        	tb_num:$('input#tb_num').val()
	        	},
	        success : function(data){
	        	alert("저장!");
	       	        },
	        error: function(err) {
	         	alert("에러!");
	        }
	    });
  })
})
</script>
    <style>
        /* iframe을 숨기기 위한 css*/
        #if{
            width: 0px;
            height: 0px;
            border: 0px;
        }
    
    </style>

</head>

<body class="login">
             <div class="navbar nav_title" style="border: 0;">
              <a href="index2.jsp" class="site_title"><i class="fa fa-paw"></i> <span>EZ2C</span></a>
            </div>
      <div class="login_wrapper">
        <div class="animate form login_form">
  <div>
    <h6><i class="fa fa-paw"></i> 원하시는 사이트 주소를 입력해주세요 </h6>
  </div>
  <section class="login_content">
  <form name="form" id="form" method="post">
    <div >
      <label>URL</label>
      <input class="form-control" placeholder="Url" id="url" name="url" type="text" />
    </div>
    <div>
      <label>TAG명</label>
      <input class="form-control" placeholder="Tag1" id="tag"  name="tag" type="text" />
    </div>
     <div>
      <label>TAG명(2)</label>
      <input class="form-control" placeholder="Tag2" id="tag2" name="tag2" type="text" />
    </div>
     <div>
      <label>TableNumber</label>
      <input class="form-control" placeholder="Table Number" id="tb_num" name="tb_num" type="number" onKeyUp="if(this.value>6){this.value='6';}else if(this.value<1){this.value='1';}" min="1" max="6" />
    </div>
    <input class="btn btn-default submit" type="button" id="btn1" name="btn1" value="미리보기"/>
  </form>
  
  <!-- <iframe src ="crawling.jsp" id="if" name="ifr"></iframe>-->
	<div id="content">
	<h3><i class="fa fa-paw"></i> 여기에 출력됩니다. </h3>
    </div>
    
    <div>
    <input class="btn btn-default submit" type="button" id="btn2" name="btn2" value="Save"/>
</div>
</section>
</div>

</div>

</body>
</html>