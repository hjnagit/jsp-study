<%@page import="com.itwillbs.member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
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
<h1>memberList.jsp</h1>

<h2>회원 정보 목록</h2>

<%
	//로그인 체크 관리자 인지 여부 체크
	
	String id = (String)session.getAttribute("loginID");
	//로그인을 안했거나 관리자가 아닐때
	if(id == null || !id.equals("admin")){
		response.sendRedirect("loginForm.jsp");
	}
	
	//디비에 저장된 회원정보 모두 가져오기
	MemberDAO dao = new MemberDAO();
	
	//전체 회원정보를 가져오는 메서드
	ArrayList<MemberBean> memberList = dao.getMemberList();
	
	//화면에 출력
	
%>

<%=memberList %>
<hr>

<table border="1">
	<tr>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>나이</th>
		<th>성별</th>
		<th>이메일</th>
		<th>회원가입일</th>
	</tr>
	
	<%for(int i=0; i < memberList.size(); i++) {
		MemberBean mb = memberList.get(i);
		//MemberBean mb = (MemberBean)memberList.get(i); 
		//제네릭을 안쓰면 이렇게 다운캐스팅을 해준다 
		
	%>
	
	<tr>
		<td><%=mb.getId() %></td>
		<td><%=mb.getPw() %></td>
		<td><%=mb.getName() %></td>
		<td><%=mb.getAge() %></td>
		<td><%=mb.getGender() %></td>
		<td><%=mb.getEmail() %></td>
		<td><%=mb.getRegdate() %></td>
	</tr>
	
	<%} %>
	
</table>

<a href = "main.jsp">메인으로 가기</a>




</body>
</html>