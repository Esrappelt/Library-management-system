<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'rangeBook.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<style>
		.banner {
			width: 100%;
			height: 336px;
		}
	</style>
  </head>
  
  <body>
   	<div class="indexJsp">
		<div class="bookInfo">
			<div class="library_icon"></div>
			<div class="rangeTitle"><h3>图书借阅排行榜>></h3></div>
	    	<!-- 显示图书借阅排行榜 -->
	    	<div class="range">
	    		<ul class="baseInfo">
					<li>排名</li>
					<li>图书条形码</li>
					<li>图书名称</li>
					<li>图书出版社</li>
					<li>图书作者</li>
					<li>图书价格(元)</li>
					<li>可借阅数</li>
					<li>是否下架</li>
				</ul>
	    	</div>	
	    </div>
	</div>
	<div class="noBook"></div>
  </body>
  <script type="text/javascript" src="js/banner.js"></script>
  <script>
  	getbookInfo();
  	function bookInfo(data){
   		var $bookInfo = $(".indexJsp .bookInfo .range");
   		for(var i = 0; i < data.length; i++) {
   			var $ul = createBook(i+1,data[i]);
   			$bookInfo.append($ul);
   		}
   	}
   	function createBook(index,res){
   		var $ul = $("<ul class='book'></ul>");
   		var $li = $("<li>"+(index)+"</li><li>"+(res.barcode)+"</li><li>"+(res.bookname)+"</li><li>"+(res.isbnName)+"</li><li>"+(res.author)+"</li><li>"+(res.price)+"</li><li>"+(res.bookNumber)+"</li><li>"+(res.del ? "未下架" : "已下架")+"</li>");
   		$ul.append($li);
   		return $ul;
   	}
   	//获取图书排行信息
	function getbookInfo(){
		$.ajax({
			url: 'bookInfo',
			type: 'get',
			dataType:'json',
			async:false, 
			success:function (data){
				bookInfo(data);
				console.log(data);
			},
			error:function(data){
				console.log("无获取到数据");
			}
		})
	}
  </script>
</html>
