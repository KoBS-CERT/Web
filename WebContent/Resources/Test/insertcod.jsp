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
    card1_title=request.getParameter("card1_title");
    card2_title=request.getParameter("card2_title");
    card3_title=request.getParameter("card3_title");
    card4_title=request.getParameter("card4_title");
    card5_title=request.getParameter("card5_title");
    card6_title=request.getParameter("card6_title");
    card1[0]=Float.parseFloat(request.getParameter("card_1_data_gs_x"));
    card1[1]=Float.parseFloat(request.getParameter("card_1_data_gs_y"));
    card1[2]=Float.parseFloat(request.getParameter("card_1_data_gs_width"));
    card1[3]=Float.parseFloat(request.getParameter("card_1_data_gs_height"));
    card2[0]=Float.parseFloat(request.getParameter("card_2_data_gs_x"));
    card2[1]=Float.parseFloat(request.getParameter("card_2_data_gs_y"));
    card2[2]=Float.parseFloat(request.getParameter("card_2_data_gs_width"));
    card2[3]=Float.parseFloat(request.getParameter("card_2_data_gs_height"));
    card3[0]=Float.parseFloat(request.getParameter("card_3_data_gs_x"));
    card3[1]=Float.parseFloat(request.getParameter("card_3_data_gs_y"));
    card3[2]=Float.parseFloat(request.getParameter("card_3_data_gs_width"));
    card3[3]=Float.parseFloat(request.getParameter("card_3_data_gs_height"));
    card4[0]=Float.parseFloat(request.getParameter("card_4_data_gs_x"));
    card4[1]=Float.parseFloat(request.getParameter("card_4_data_gs_y"));
    card4[2]=Float.parseFloat(request.getParameter("card_4_data_gs_width"));
    card4[3]=Float.parseFloat(request.getParameter("card_4_data_gs_height"));
    card5[0]=Float.parseFloat(request.getParameter("card_5_data_gs_x"));
    card5[1]=Float.parseFloat(request.getParameter("card_5_data_gs_y"));
    card5[2]=Float.parseFloat(request.getParameter("card_5_data_gs_width"));
    card5[3]=Float.parseFloat(request.getParameter("card_5_data_gs_height"));
    card6[0]=Float.parseFloat(request.getParameter("card_6_data_gs_x"));
    card6[1]=Float.parseFloat(request.getParameter("card_6_data_gs_y"));
    card6[2]=Float.parseFloat(request.getParameter("card_6_data_gs_width"));
    card6[3]=Float.parseFloat(request.getParameter("card_6_data_gs_height"));

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
    	 pstmt = conn.prepareStatement("DELETE FROM user_table_info WHERE (idx = ?)");
         //System.out.println(pstmt + "<-- pstmt 1");
         //System.out.println(pstmt.getClass() + "<-- pstmt.getClass() 1");
     //insert into tb_member values('id001','pw001','관리자','홍01','email01');
         pstmt.setInt(1, idx);
        // System.out.println(pstmt + "<-- pstmt 2");
     //03단계 :Query실행을 위한 statement 또는 prepareStatement객체생성 끝
     
     //04단계 :Query실행 시작
         pstmt.executeUpdate();
        pstmt = conn.prepareStatement("INSERT INTO user_table_info (idx,card_1_data_gs_x,card_1_data_gs_y,card_1_data_gs_width,card_1_data_gs_height,card_2_data_gs_x,card_2_data_gs_y,card_2_data_gs_width,card_2_data_gs_height,card_3_data_gs_x,card_3_data_gs_y,card_3_data_gs_width,card_3_data_gs_height,card_4_data_gs_x,card_4_data_gs_y,card_4_data_gs_width,card_4_data_gs_height,card_5_data_gs_x,card_5_data_gs_y,card_5_data_gs_width,card_5_data_gs_height,card_6_data_gs_x,card_6_data_gs_y,card_6_data_gs_width,card_6_data_gs_height,card1_title,card2_title,card3_title,card4_title,card5_title,card6_title) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        //System.out.println(pstmt + "<-- pstmt 1");
        //System.out.println(pstmt.getClass() + "<-- pstmt.getClass() 1");
    //insert into tb_member values('id001','pw001','관리자','홍01','email01');
        pstmt.setInt(1, idx);
        pstmt.setFloat(2,card1[0]);
        pstmt.setFloat(3,card1[1]);
        pstmt.setFloat(4,card1[2]);
        pstmt.setFloat(5,card1[3]);
        pstmt.setFloat(6,card2[0]);
        pstmt.setFloat(7,card2[1]);
        pstmt.setFloat(8,card2[2]);
        pstmt.setFloat(9,card2[3]);
        pstmt.setFloat(10,card3[0]);
        pstmt.setFloat(11,card3[1]);
        pstmt.setFloat(12,card3[2]);
        pstmt.setFloat(13,card3[3]);
        pstmt.setFloat(14,card4[0]);
        pstmt.setFloat(15,card4[1]);
        pstmt.setFloat(16,card4[2]);
        pstmt.setFloat(17,card4[3]);
        pstmt.setFloat(18,card5[0]);
        pstmt.setFloat(19,card5[1]);
        pstmt.setFloat(20,card5[2]);
        pstmt.setFloat(21,card5[3]);
        pstmt.setFloat(22,card6[0]);
        pstmt.setFloat(23,card6[1]);
        pstmt.setFloat(24,card6[2]);
        pstmt.setFloat(25,card6[3]);
        pstmt.setString(26,card1_title);
        pstmt.setString(27,card2_title);
        pstmt.setString(28,card3_title);
        pstmt.setString(29,card4_title);
        pstmt.setString(30,card5_title);
        pstmt.setString(31,card6_title);
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
