<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
  <head>
    
    
    <title>My JSP 'main.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body>
  	
   banner.jsp
    <script>
  
   
	   			getTime();
	   			setInterval(getTime,1000);
	   			function getTime(){
	   				var date = new Date();
	   				var time = date.toString().split(" ");
	   				var formatTime = time[3] + "年"  + (date.getMonth() + 1) + "月" + time[2] + "日" + time[4];
	   				
	   				console.log("时间:");
	   				console.log(formatTime);
	   			}
   			
    
  </script>
  </body>

</html>
