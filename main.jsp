<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>main.jsp</h1>
<!-- 로그인을 했을 때만 방문. 로그인x 로그인 유도 -->

<%
	//세션영역에 있는 로그인 아이디 정보를 가져오기
	String id =	(String)session.getAttribute("loginID");

	if(id == null){
		// 로그인을 안했다
		System.out.println("로그인 정보 없음!");
		response.sendRedirect("loginForm.jsp");
	}


%>
<h2><%=id %>님 환영합니다.</h2>

<input type="button" value="로그아웃" onclick ="location.href='logout.jsp';">

<hr>

<h2><a href="info.jsp">개인정보 조회</a></h2>
<h2><a href="updateForm.jsp">개인정보 수정</a></h2>
<h2><a href="deleteForm.jsp">개인정보 삭제</a></h2>

<!-- 관리자 전용 메뉴 - 관리자에게만 보이게-->
<%
//jsp코드는 처음부터 끝까지 실행 후 동작
//	if(id != null && id.equals("admin")) 이렇게도 가능

	if(id != null){
		if(id.equals("admin")){
			%>
			<h2><a href="memberList.jsp">개인정보 목록</a></h2>
			<%
		}
	}

%>



</body>
</html>