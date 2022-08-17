<%@page import="com.itwillbs.member.MemberDAO"%>
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
<h1>insertPro3.jsp</h1>

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
	
	//회원가입 - DB동작
	//insertMember()
	
	//MemberDAO객체 생성
	MemberDAO dao = new MemberDAO();
	
	//커서를 두고 f3번 누르면 해당 대상을 이동한다
	//ctrl을 누른 상태에서 커서를 이동하면 링크로 변함 -> 이것도 대상으로 이동한다
	dao.insertMember(mb);
	
	
	
	//회원가입 완료 -> 로그인수행하기
	//로그인 폼으로 이동
	// 결과가 1일때 이동한다 -> 1이면 회원가입 되었다는 뜻이니까
	
	response.sendRedirect("loginForm.jsp");
	

%>





</body>
</html>