<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/scripts/jquery-3.2.1.js"></script>
<script type="text/javascript">
	
	$(function(){
		
		$("#lastName").change(function(){
			
			var val = $(this).val();
			val = $.trim(val);
			
			if(val == "") {
				alert("用户名不能为空！");
				$(this).val("");
				return;
			}
			
			//若修改的 lastName 和之前的 lastName 一致, 则不发送 Ajax 请求, 直接 alert:用户名可用!
			var oldLastName = $("#oldLastName").val();
			oldLastName = $.trim(oldLastName);
			if(oldLastName != null && oldLastName != "" && oldLastName == val) {
				alert("用户名可用!");
				return;
			}
			
			$(this).val(val);
			
			var url = "${pageContext.request.contextPath }/ajaxValidateLastName";
			var args = {"lastName":val, "Date":new Date()};
			
			$.post(url, args ,function(data){
				if(data == "1") {
					alert("用户名不可用!")
				} else if (data == "0") {
					alert("用户名可用!");
				} else {
					alert("网络错误！");
				}
			});
			
		});
		
	})

</script>
</head>
<body>

	<c:set var="url" value="${pageContext.request.contextPath }/emp"></c:set>
	<c:if test="${employee.id != null }">
		<c:set var="url" value="${pageContext.request.contextPath }/emp/${employee.id }"></c:set>
	</c:if>

	<form:form action="${url }" method="post" modelAttribute="employee">
	
		<c:if test="${employee.id != null }">
			<input type="hidden" id="oldLastName" value="${employee.lastName }">
			<form:hidden path="id"/>
			<input type="hidden" name="_method" value="PUT">
		</c:if>
	
		LastName: <form:input path="lastName" id="lastName" />  <br><br>
		
		Email: <form:input path="email"/>  <br><br>
		
		Birth: <form:input path="birth"/> <br><br>
		
		Department: <form:select path="department.id" items="${departments }"
							 itemLabel="departmentName" itemValue="id"></form:select> <br><br>
							 
		<input type="submit" value="Submit">
	
	</form:form>

</body>
</html>