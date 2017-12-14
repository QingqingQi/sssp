<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/scripts/jquery-3.2.1.js"></script>
<script type="text/javascript">

	$(function(){
		
		$(".delete").click(function(){
			
			var lastName = $(this).next(":hidden").val();
			
			var flag = confirm("确定要删除"+ lastName +"的信息吗?");
			
			if(flag) {
				var url = $(this).attr("href");
				$("#form").attr("action", url).submit();
			}
			
			return false;
		});
		
	})
</script>
</head>
<body>

	<form action="" method="post" id="form">
		<input type="hidden" name="_method" value="DELETE">
	</form>

	<c:if test="${page == null || page.numberOfElements == 0 }">
		<h3>没有员工记录！</h3>
	</c:if>
	
	<c:if test="${page != null && page.numberOfElements > 0 }">
	
		<table border="1" cellspacing="0" cellpadding="10">
		
			<tr>
				<th>Id</th>
				<th>LastName</th>
				
				<th>Email</th>
				<th>Birth</th>
				
				<th>CreateTime</th>
				<th>DepartmentName</th>
				
				<th>Edit</th>
				<th>Delete</th>
			</tr>
			
			<c:forEach items="${page.content }" var="emp">
				
				<tr>
					<td>${emp.id }</td>
					<td>${emp.lastName }</td>
					
					<td>${emp.email }</td>
					<td>${emp.birth }</td>
					
					<td>${emp.createTime }</td>
					<td>${emp.department.departmentName }</td>
					
					<td>
						<a href="${pageContext.request.contextPath }/emp/${emp.id}">Edit</a>
					</td>
					<td>
						<a href="${pageContext.request.contextPath }/emp/${emp.id}" class="delete">Delete</a>
						<input type="hidden" value="${emp.lastName }">
					</td>
				</tr>
				
			</c:forEach>
			
			<tr>
				<td colspan="8">
					共 ${page.totalElements} 条记录  &nbsp;&nbsp;&nbsp;
					共 ${page.totalPages} 页  &nbsp;&nbsp;&nbsp;
					当前为 ${page.number + 1 } 页  &nbsp;&nbsp;&nbsp;
					
					<c:if test="${page.number + 1 > 1 }">
						<a href="?pageNo=${page.number + 1 - 1 }">上一页</a>  &nbsp;&nbsp;&nbsp;
					</c:if>
					
					<c:if test="${page.number + 1 < page.totalPages}">
						<a href="?pageNo=${page.number + 1 + 1 }">下一页</a>  &nbsp;&nbsp;&nbsp;
					</c:if>
				</td>
			</tr>
						
		</table>
		
	</c:if>

</body>
</html>