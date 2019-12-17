<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %> 
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<!-- 특정패키지들 내에  클래스들 내에 선언된 메서드들의 기능들을 호출하기위해서  import -->
 
<%
    request.setCharacterEncoding("utf-8");
    // 입력 받은 한글이 깨지지 않도록 UTF-8세팅. *getParameter위에 써야함
    ResultSet rs;
    Connection conn = null;
    // Connection클래스 데이터타입으로 객체참조 변수 conn 선언 후 null로 초기화
    PreparedStatement pstmt = null;
    // PreparedStatement클래스 데이터타입으로 객체참조 변수 pstmt 선언 후 null로 초기화
    
    //화면에서 입력데이터를 받아서 각각 변수에 저장하고 콘솔창에 출력 시작
    String url = request.getParameter("url");
    String tag1 = request.getParameter("tag");
    String tag2 = request.getParameter("tag2");
    String rel = request.getParameter("rel");
    int tb_num = Integer.parseInt(request.getParameter("tb_num"));
    int idx=-1;
    //화면에서 입력데이터를 받아서 각각 변수에 저장하고 콘솔창에 출력 시작    
    
    // * JDBC 프로그램 순서
    //01단계 :드라이버 로딩 시작
    Class.forName("com.mysql.jdbc.Driver");
    //01단계 :드라이버 로딩 끝
    
    try{
    //02단계 :DB연결(Connection)시작
        String jdbcDriver = "jdbc:mysql://localhost:3306/sys?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
        String dbUser = "root";
        String dbPass = "$cert0188";
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
    }catch (Exception e) {
    	e.printStackTrace(); // 오류가 무엇인지 출력
    }
    //02단계 :DB연결(Connection)끝
    
    //03단계 :Query실행을 위한 statement 또는 prepareStatement객체생성 시작
    String SQL="SELECT idx FROM user_info WHERE user_id = ?";
    
    try {
    	// pstmt : prepared statement 정해진 sql문장을 db에 삽입하는 형식으로 인스턴스가져옴
    	pstmt = conn.prepareStatement(SQL);
    	// sql인젝션 같은 해킹기법을 방어하는것... pstmt을 이용해 하나의 문장을 미리 준비해서(물음표사용)
    	// 물음표해당하는 내용을 유저아이디로, 매개변수로 이용.. 1)존재하는지 2)비밀번호무엇인지
    	pstmt.setString(1, (String)session.getAttribute("id"));
    	// rs:result set 에 결과보관
    	rs = pstmt.executeQuery();
    	// 결과가 존재한다면 실행
    	if (rs.next()) {
    		idx= rs.getInt("idx");

    	}
    	if(idx==-1)
    		return;
    } catch (Exception e) {
    	e.printStackTrace();
    }
    try{
    	 pstmt = conn.prepareStatement("DELETE FROM url_info WHERE (user_idx = ? AND url_idx= ?)");
         //System.out.println(pstmt + "<-- pstmt 1");
         //System.out.println(pstmt.getClass() + "<-- pstmt.getClass() 1");
     //insert into tb_member values('id001','pw001','관리자','홍01','email01');
         pstmt.setInt(1, idx);
         pstmt.setInt(2, tb_num);
        // System.out.println(pstmt + "<-- pstmt 2");
     //03단계 :Query실행을 위한 statement 또는 prepareStatement객체생성 끝
     
     //04단계 :Query실행 시작
         pstmt.executeUpdate();
        pstmt = conn.prepareStatement("INSERT INTO url_info (user_idx,url,tag1,tag2,rel,url_idx) VALUES (?, ?, ?, ?, ?, ?)");
        //System.out.println(pstmt + "<-- pstmt 1");
        //System.out.println(pstmt.getClass() + "<-- pstmt.getClass() 1");
    //insert into tb_member values('id001','pw001','관리자','홍01','email01');
        pstmt.setInt(1, idx);
        pstmt.setString(2, url);
        pstmt.setString(3, tag1);
        pstmt.setString(4, tag2);
        pstmt.setInt(5, 1);
        pstmt.setInt(6,tb_num);
       // System.out.println(pstmt + "<-- pstmt 2");
    //03단계 :Query실행을 위한 statement 또는 prepareStatement객체생성 끝
    
    //04단계 :Query실행 시작
        pstmt.executeUpdate();
    //04단계 :Query실행 끝
    
    //05단계 :Query실행결과 사용 (insert의 경우 생략 가능단계)
    
    }finally{
        //06단계 :statement 또는 prepareStatement객체 종료(close())
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        //07단계 :Connection 객체 종료(close())
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
%>
