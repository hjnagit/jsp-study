<%@page import="com.itwillbs.member.MemberDAO"%>
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


<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

%>

<jsp:useBean id="mb" class="com.itwillbs.member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>

<%
	// 잘 들어왔는지 확인
	System.out.println(mb);
	
	//로그인 체크하는 로직
	//MemberDAO 객체
	MemberDAO dao = new MemberDAO();
	
	//로그인 체크 기능 - loginMember()
	int result = dao.loginMember(mb);
	
	//5. 데이터 처리
	if(result == 0){
		//비밀번호 오류
		%>
		<script type="text/javascript">
			alert('비밀번호가 잘못되었습니다.');
			history.back();
		</script>
		<%
	} else if(result == -1){
		// 아이디 오류
		%>
		<script type="text/javascript">
			alert('아이디가 잘못되었습니다.');
			history.back();
		</script>
		<%
	} else {
		// result = 1 -> 로그인 성공
		session.setAttribute("loginID", mb.getId());
		//response.sendRedirect("main.jsp");
		%>
		<script type="text/javascript">
			alert('로그인 성공');
			location.href='main.jsp';
		</script>
		<%
	}
	
	
	
%>



</body>
</html>