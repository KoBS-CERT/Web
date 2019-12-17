<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %> 
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.sql.ResultSet" %>
<% request.setCharacterEncoding("UTF-8");%>

<%
Connection conn=null;
ResultSet rs;
PreparedStatement pstmt;
try {

	String dbURL = "jdbc:mysql://localhost:3306/sys?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8"; // localhost:3306 포트는 컴퓨터설치된 mysql주소
	String dbID = "root";
	String dbPassword = "$cert0188";
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
} catch (Exception e) {
	e.printStackTrace(); // 오류가 무엇인지 출력
}

String id = request.getParameter("reg_id");                        // request에서 id 파라미터를 가져온다
String passwd = request.getParameter("reg_pw");      // request에서 passwd 파라미터를 가져온다.
//String SQL = "SELECT user_pw FROM user_info WHERE user_id = "+"'"+id+"'";
String SQL = "SELECT user_id FROM user_info WHERE user_id = ?";
try {
	// pstmt : prepared statement 정해진 sql문장을 db에 삽입하는 형식으로 인스턴스가져옴
	pstmt = conn.prepareStatement(SQL);
	// sql인젝션 같은 해킹기법을 방어하는것... pstmt을 이용해 하나의 문장을 미리 준비해서(물음표사용)
	// 물음표해당하는 내용을 유저아이디로, 매개변수로 이용.. 1)존재하는지 2)비밀번호무엇인지
	pstmt.setString(1, id);
	// rs:result set 에 결과보관
	rs = pstmt.executeQuery();
	// 결과가 존재한다면 실행
	if (rs.next()) {
		%><script>alert("ID가 중복되었습니다.");
		history.go(-1);                                    // 이전 페이지로 이동
		</script>
		<%
	}else{
		 pstmt = conn.prepareStatement("INSERT INTO user_info (user_id, user_pw) VALUES (?, ?)");
	        //System.out.println(pstmt + "<-- pstmt 1");
	        //System.out.println(pstmt.getClass() + "<-- pstmt.getClass() 1");
	    //insert into tb_member values('id001','pw001','관리자','홍01','email01');
	        pstmt.setString(1, id);
	        pstmt.setString(2, passwd);
	       // System.out.println(pstmt + "<-- pstmt 2");
	    //03단계 :Query실행을 위한 statement 또는 prepareStatement객체생성 끝
	    
	    //04단계 :Query실행 시작
	        pstmt.executeUpdate();
	        %><script>alert("회원가입 완료!\n 다시 로그인해주세요!");
	        location.href="login.jsp";                                   // 이전 페이지로 이동
			</script>
			<%
	}
} catch (Exception e) {
	e.printStackTrace();
}
// 데이터베이스 오류를 의미



%>
