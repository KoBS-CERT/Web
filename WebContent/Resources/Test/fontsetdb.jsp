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
	response.setContentType("text/html; charset=utf-8");
    // 입력 받은 한글이 깨지지 않도록 UTF-8세팅. *getParameter위에 써야함
    ResultSet rs;
    Connection conn = null;
    // Connection클래스 데이터타입으로 객체참조 변수 conn 선언 후 null로 초기화
    PreparedStatement pstmt = null;
    // PreparedStatement클래스 데이터타입으로 객체참조 변수 pstmt 선언 후 null로 초기화
    
   int font1 = Integer.parseInt(request.getParameter("font1"));
int font2 = Integer.parseInt(request.getParameter("font2"));
int font3 = Integer.parseInt(request.getParameter("font3"));
int font4 = Integer.parseInt(request.getParameter("font4"));
int font5 = Integer.parseInt(request.getParameter("font5"));
int font6 = Integer.parseInt(request.getParameter("font6"));
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
    String SQL="UPDATE user_table_info set card1_fontsize=?, card2_fontsize=?, card3_fontsize=?, card4_fontsize=?, card5_fontsize=?, card6_fontsize=? WHERE idx=(SELECT idx from user_info WHERE user_id=?);";
    System.out.println(SQL);
    
    try {
    	// pstmt : prepared statement 정해진 sql문장을 db에 삽입하는 형식으로 인스턴스가져옴
    	pstmt = conn.prepareStatement(SQL);
    	// sql인젝션 같은 해킹기법을 방어하는것... pstmt을 이용해 하나의 문장을 미리 준비해서(물음표사용)
    	// 물음표해당하는 내용을 유저아이디로, 매개변수로 이용.. 1)존재하는지 2)비밀번호무엇인지
    	pstmt.setInt(1, font1);
    	pstmt.setInt(2, font2);
    	pstmt.setInt(3, font3);
    	pstmt.setInt(4, font4);
    	pstmt.setInt(5, font5);
    	pstmt.setInt(6, font6);
    	pstmt.setString(7, (String)session.getAttribute("id"));
        System.out.println(pstmt);
    	// rs:result set 에 결과보관
    	pstmt.executeUpdate();
    	// 결과가 존재한다면 실행
    } catch (Exception e) {
    	e.printStackTrace();
    }finally{
        //06단계 :statement 또는 prepareStatement객체 종료(close())
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        //07단계 :Connection 객체 종료(close())
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
%>
