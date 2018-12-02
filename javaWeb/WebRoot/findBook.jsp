<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'findBook.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
  </head>
  
  <body>
    
    输入图书名字进行查询<input type="text" id="input"  />
    <input type="button" value="查询" id="find" />
    <script type="text/javascript">
		var find = document.getElementById('input');
		var submit = document.getElementById("find");
		submit.onclick = function (){
			var value = encodeURI(encodeURI(find.value));
			console.log(value);
			$.ajax({
				url: 'findBook?bookname=' + value,
				type: 'get',
				dataType: 'json',
				
			})
			.done(function(data) {
				console.log(data);
			});
		}
	</script>
  </body>
  
</html>
