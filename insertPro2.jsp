<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>insertPro2.jsp</h1>
<%!
static final String DRIVER = "com.mysql.cj.jdbc.Driver";
static final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
static final String DBID = "root";
static final String DBPW = "1234";
%>

<%
	
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	// 전달 정보 저장
	%>
	<!-- 액션태그 자바빈 -->
	<jsp:useBean id="mb" class="com.itwillbs.member.MemberBean"/>
	<!-- 전달정보 저장 -->
	<jsp:setProperty property="*" name="mb"/>
	<%
	//날짜 정보 추가저장 - 액션태그로는 못함.
	mb.setRegdate(new Timestamp(System.currentTimeMillis()));
	
	%>
	
	<%
	System.out.println(mb); // 콘솔창으로 정보 확인
//	System.out.println(mb.toString()); //같은 뜻
	
//	System.out.println(id +" " +pw +" " +name +" " +age+" " +gender+" " +email+" " +regdate);
	//디비연결 - 정보 저장
	// 1. 드라이버 로드
	Class.forName(DRIVER);
	// 2. 디비연결
	Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
	// 3. sql & pstmt 생성
	String sql = "insert into itwill_member(id, pw, name, age, gender, email, regdate) values(?,?,?,?,?,?,?)";
	// ???
	PreparedStatement pstmt = con.prepareStatement(sql);
	// 4. sql 실행
 	pstmt.setString(1, mb.getId());
	pstmt.setString(2, mb.getPw());
	pstmt.setString(3, mb.getName());
	pstmt.setInt(4, mb.getAge());
	pstmt.setString(5, mb.getGender());
	pstmt.setString(6, mb.getEmail());
	pstmt.setTimestamp(7, mb.getRegdate()); 
	
	//실행
	int result = pstmt.executeUpdate(); 
	// int의 리턴타입 -> 쿼리가 몇줄 들어갔는지 그 수를 리턴해준다
	//sql쿼리 결과가 테이블에 영향을 준 행의수를 리턴
	
	System.out.println("회원가입 완료!!!");
	
	//회원가입 완료 -> 로그인수행하기
	//로그인 폼으로 이동
	// 결과가 1일때 이동한다 -> 1이면 회원가입 되었다는 뜻이니까
	if(result == 1){
		response.sendRedirect("loginForm.jsp");
	}

%>





</body>
</html>