<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.protocol.Resultset"%>
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
<h1>loginPro.jsp</h1>

<%!
static final String DRIVER = "com.mysql.cj.jdbc.Driver";
static final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
static final String DBID = "root";
static final String DBPW = "1234";
%>

<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
	//전달된 정보 저장 id pw
	//적은 정보도 담아서 사용해야 한다
//	String id = request.getParameter("id");
//	String pw = request.getParameter("pw");

	//자바빈으로 쓰자
%>

<jsp:useBean id="mb" class="com.itwillbs.member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>

<%
	// 잘 들어왔는지 확인
	System.out.println(mb);
	
	//로그인을 체크하는 로직
	////////////////////////////////////////////////////////////////////
	//디비에 연결
	//1. 드라이버 로드
	Class.forName(DRIVER);
	System.out.println("드라이버 로드 성공!");
	//2. 디비 연결
	Connection con = DriverManager.getConnection(DBURL, DBID, DBPW);
	System.out.println("디비 연결 성공!");
	//3. sql 작성(select) & pstmt 객체
	//String sql = "select * from itwill_member where id=? and pw=?";
	//id에 해당하는 pw를 가져오자
	String sql = "select pw from itwill_member where id=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	//???
	pstmt.setString(1, mb.getId());		
	//4. sql 실행
	ResultSet rs = pstmt.executeQuery();
	//5. 데이터 처리
	if(rs.next()){
		//아이디있음 회원
		if(mb.getPw().equals(rs.getString("pw"))){//자바빈에서 꺼내온다
			//아이디 있음 비번 동일 -> 본인 로그인 성공
			//로그인 정보(id) 저장, 공유 session application에 담아서- scope확인
			//id정보는 session에 담는다 / applicaion은 프로젝트 전체를 담는다
			//session 영역에 저장 공유 키-벨류
			session.setAttribute("loginID", mb.getId());
			
			// 이렇게도 표현한다 loginResult의 값이 ok이면 로그인이 되어있다는 뜻
			//session.setAttribute("loginResult", "OK");
			
			// main으로 이동
			response.sendRedirect("main.jsp");
		}else{
			//아이디 있음 비번 다름 -> 비밀번호 오류
			%>
			<script type="text/javascript">
				alert('아이디 혹은 비밀번호가 잘못되었습니다.');
				history.back();
			</script>
			<%
			
		}
	}else{
		// 아이디없음 비회원
		// 알람뜨고 페이지 뒤로가기 history.back();
		%>
		<script type="text/javascript">
			alert('아이디 혹은 비밀번호가 잘못되었습니다.');
			history.back();
		</script>
		<%
	}
	
	////////////////////////////////////////////////////////////////////
	
	
%>



</body>
</html>