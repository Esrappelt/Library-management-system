<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'bookManage.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style>
		h3 {
			text-align: center;
		}
		.modify {
			cursor: pointer;
			background: purple;
			color: white;
			width: 50px;
			height: 100%;
		}
		.modifyEnd {
			cursor: pointer;
			background: purple;
			color: white;
			width: 50px;
			height: 100%;
			display: none;
		}
	</style>
  </head>
  
  <body>
    <div class="indexJsp">
		<div class="bookInfo">
			<div class="rangeTitle"><h3>图书修改</h3></div>
	    	<div class="range">
	    		<ul class="baseInfo">
					<li>编号</li>
					<li>图书条形码</li>
					<li>图书名称</li>
					<li>图书出版社</li>
					<li>图书作者</li>
					<li>图书价格(元)</li>
					<li>可借阅数</li>
					<li>是否下架</li>
					<li>修改选项</li>
				</ul>
	    	</div>	
	    </div>
	</div>
  </body>
  <script type="text/javascript">
  		var barcode;
  		getbookInfo();
  		$(".indexJsp").on('click', '.modify', function(event) {
  			barcode = $(this).parents(".book").get(0).children[1].innerHTML;
  			console.log(barcode);
  			$(this).hide();
  			$(this).next().show();
  			$(this).siblings('li.book2').attr('contenteditable', 'true');
  		});
  		$(".indexJsp").on('click', '.modifyEnd', function(event) {
  			$(this).hide();
  			$(this).prev().show();
  			$(this).siblings('li.book2').removeAttr('contenteditable');
			var $modifyContent =  $(this).parents(".book").get(0).children;
  			var v1 = $modifyContent[1].innerHTML;
  			var v2 = $modifyContent[2].innerHTML;
  			var v3 = $modifyContent[3].innerHTML;
  			var v4 = $modifyContent[4].innerHTML;
  			var v5 = $modifyContent[5].innerHTML;
  			var v6 = $modifyContent[6].innerHTML;
  			var v7 = $modifyContent[7].innerHTML;
			$.ajax({
  				url: 'updateServlet',
  				type: 'get',
  				dataType: 'text',
  				data: {
  					v1: encodeURI(v1),
  					v2: encodeURI(v2),
  					v3: encodeURI(v3),
  					v4: encodeURI(v4),
  					v5: encodeURI(v5),
  					v6: encodeURI(v6),
  					v7: encodeURI(v7),
  					barcode:barcode
  				}	
  			})
  			.done(function() {
  				
  			})
  			.fail(function() {
  				console.log("error");
  			})
  			  			
  		});
  	//获取图书排行信息
		function getbookInfo(){
			$.ajax({
				url: 'bookInfo',
				type: 'get',
				dataType:'json',
				success:function (data){
					bookInfo(data);
				},
				error:function(data){
					console.log(data.status);
				}
			})
		}
		function bookInfo(data){
	    		var $bookInfo = $(".indexJsp .bookInfo .range");
	    		for(var i = 0; i < data.length; i++) {
	    			var $ul = createBook(i+1,data[i]);
	    			$bookInfo.append($ul);
	    		}
	    	}
	    	function createBook(index,res){
	    		var $ul = $("<ul class='book'></ul>");
	    		var $li = $("<li class='book2'>"+(index)+"</li><li class='book2'>"+(res.barcode)+"</li><li class='book2'>"+(res.bookname)+"</li><li class='book2'>"+(res.isbnName)+"</li><li class='book2'>"+(res.author)+"</li><li class='book2'>"+(res.price)+"</li><li class='book2'>"+(res.bookNumber)+"</li><li class='book2'>"+(res.del == 0 ? "未下架" : "已下架")+"</li><li class='modify'>修改</li><li class='modifyEnd'>完成</li>");
	    		$ul.append($li);
	    		return $ul;
	    	}
  </script>
</html>
