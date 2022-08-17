<%@page import="com.itwillbs.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>deletePro.jsp</h1>

<%
	//전달된 정보를 저장(pw)
	//무엇을 하든 페이지간의 전달된 정보를 처리하는 것을 첫번째로
	
	//로그인 체크
	String id = (String)session.getAttribute("loginID");

	if(id == null){
		response.sendRedirect("loginForm.jsp");
	}
	
	//전달된 정보를 저장(pw) - 액션태그 안 쓰고 파라메타쓰기
	String pw = request.getParameter("pw");
	
	//회원정보 탈퇴 - 디비에 저장된 정보 삭제
	MemberDAO dao = new MemberDAO();
	
	//회원탈퇴 메서드 호출
	int result = dao.deleteMember(id, pw);
	
	if(result == 1){
		
		//탈퇴시 로그인 정보 삭제 - 세션값 삭제 초기화
		session.invalidate();
		
		%>
			<script type="text/javascript">
				alert("회원 탈퇴 성공!");
				location.href="main.jsp";
			</script>
		<%
		
	}else if(result == 0){
		%>
			<script type="text/javascript">
				alert("탈퇴실패 : 비밀번호 오류!");
				history.back();
			</script>
		<%
		
	}else{//result == -1
		%>
			<script type="text/javascript">
				alert("탈퇴실패 : 회원정보 오류!");
				history.back();
			</script>
		<%
	}
	
%>




</body>
</html>