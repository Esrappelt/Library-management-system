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
	<style>
    * {
      padding: 0;
      margin: 0;
    }
    .container {
      width: 100%;
      height: 50px;
      background: rgba(104, 54, 153,.5);
      display: flex;
      flex-direction: row;
      justify-content: space-around;
      align-items: center;
    }
  </style>
  </head>
  
  <body>
    
  	<div class="container">
        <div class="inquire">
           		 根据图书名称查询：
            <input type="text" class="bookname" />
        </div>
        <div class="inquire">
            	根据图书出版社查询：
            <input type="text" class="isbnName" />
        </div>
        <div class="inquire">
            	根据图书作者查询：
            <input type="text" class="author" />
        </div>
        <div class="inquire">
            	根据图书条形码查询：
            <input type="text" class="barcode" />
        </div>
    </div>
      <script type="text/javascript">
        $(function (){
      var $find = $("input"),value = "",className = "";
      $find.on('input', function(event) {
        value = $(this).val();
        className = this.className;
        throttle(procccess);
      });
      function procccess() {
      	  if(value == "") {
            return;
          }
          //编码
          value = encodeURI(encodeURI(value));
          var urlParam = "findBook?"+(className)+"=" + value;
          console.log(urlParam);
          $.ajax({
                url: urlParam,
                type: 'get',
                dataType: 'json'
              })
              .done(function(data) {
                  console.log(data);
              });
      }

      function throttle(method, context) {
          context = context || window;
          //用tId清除定时器
          clearTimeout(method.tId);
          //然后继续产生这个定时器
          method.tId = setTimeout(function() {
              //让执行上下文(这里是window)调用一下method ===>即这里的proccess
              method.call(context); //相当于window.proccess();
          }, 800);
      }
    });
    </script>
	</script>
  </body>
  
</html>
