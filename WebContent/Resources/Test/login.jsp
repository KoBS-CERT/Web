<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>EZ2C! 한눈에 보는 공지사항 | </title>

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
     <script src="http://code.jquery.com/jquery-latest.min.js"></script>
     

  </head>
<%

String id = "";
id = (String)session.getAttribute("id");            // request에서 id 파라미터를 가져온다
if(id==null || id.equals("")){                            // id가 Null 이거나 없을 경우
	
}else{
	response.sendRedirect("index2.jsp");    // 로그인 페이지로 리다이렉트 한다.
}


%>
  <body class="login">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form method="post" action="loginok.jsp">
              <h1>로그인</h1>
              <div>
                <input type="text" class="form-control" placeholder="Username" name="user_id" id="user_id" required="" />
              </div>
              <div>
                <input type="password" class="form-control" placeholder="Password" name="user_pw" id="user_pw" required="" />
              </div>
              <div>
                <input class="btn btn-default submit" type="submit" onclick="goReceive();" value="Login" />
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">New to site?
                  <a href="#signup" class="to_register"> Create Account </a>
                </p>

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i> EZ2C!</h1>
                  <p>서울과학기술대학교 15109306 고병산</p>
                </div>
              </div>
            </form>
          </section>
        </div>

        <div id="register" class="animate form registration_form">
          <section class="login_content">
            <form method="post" action="register.jsp">
              <h1>회원가입</h1>
              <div>
                <input type="text" class="form-control" name="reg_id" id="reg_id" placeholder="Username" required="" />
              </div>
              <div>
                <input type="password" class="form-control" name = "reg_pw" id="reg_pw" placeholder="Password" required="" />
              </div>
              <div>
                <input class="btn btn-default submit" type="submit" onclick="goReceive();" value="SUBMIT" />
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">Already a member ?
                  <a href="#signin" class="to_register"> Log in </a>
                </p>

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i> EZ2C</h1>
                  <p>서울과학기술대학교 15109306 고병산</p>
                </div>
              </div>
            </form>
          </section>
        </div>
      </div>
    </div>
  </body>
</html>