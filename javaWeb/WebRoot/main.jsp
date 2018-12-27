<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
  <head>
    
    
    <title>个人图书馆</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel='stylesheet prefetch' href='http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css'>
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<link href="img/favicon.ico" rel="shortcut icon" type="image/x-icon" />
	<script type="text/javascript" src="js/jquery.js"></script>
  </head>
  
  <body>

  	<div class="header">
		<div class="mybanner">
			<ul class="banner-top">
				<li class="content" data-id="indexJsp"><a href="javascript:;">首页</a></li>
				<li class="content" data-id="bookManage"><a href="javascript:;">图书修改</a></li>
				<li class="content" data-id="borrowBook"><a href="javascript:;">图书借阅</a></li>
				<li class="content" data-id="givebackBook"><a href="javascript:;">图书归还</a></li>
				<li class="content" data-id="findBook"><a href="javascript:;">图书查询</a></li>
				<li class="content" data-id="exitSystem"><a href="javascript:;">退出系统</a></li>
				<li class="root"><a href="javascript:;">管理员:<%=session.getAttribute("name")%></a></li>
				<li id="time"></li>
			</ul>
		</div>
		
		<div id="mainContent">
			<div class="indexJsp">
				<div class="bookInfo">
					<div class="library_icon"></div>
					<div class="rangeTitle"><h3>图书借阅排行榜>></h3></div>
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
		</div>
	</div>
	

    <div class="copyright">
		CopyRight@2018 图书管理系统
		本网站由肖誉杰制作
	</div>
	
    <script>
  		$(function (){
			init();
			window.onload = function (){
				getbookInfo();
				initAll();
			}
			function init(){
   				var $content = $(".header .content");
	   			$content.each(function(index, el) {
	   				$(this).hover(function() {
	   					$(this).css({
	   						'background': 'white',
	   					});
	   					$(this).find('a').css('color', 'black');
	   				}, function() {
	   					$(this).css({
	   						'background': 'black',
	   					});
	   					$(this).find('a').css('color', 'white');
	   				});
	   			});
	   			var $time = document.getElementById('time');
	   			getTime();
	   			setInterval(getTime,1000);
	   			function getTime(){
	   				var date = new Date();
	   				var time = date.toString().split(" ");
	   				var formatTime = time[3] + "年"  + (date.getMonth() + 1) + "月" + time[2] + "日" + time[4];
	   				$time.innerHTML = formatTime;
	   			}
   			}
   			
			function loadInfo($mainContent){
				var sId = window.location.hash;
				var path,i;
				switch(sId) {
					case '#indexJsp':
						path = "rangeBook.jsp";
						break;
					case '#bookManage':
						path = "bookManage.jsp";
						break;
					case '#borrowBook':
						path = "borrowBook.jsp";
						break;
					case '#givebackBook':
						path = "givebackBook.jsp";
						break;
					case '#findBook':
						path = "findBook.jsp";
						break;
				}
				$mainContent.html("");
				$mainContent.load(path);
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
	    		var $li = $("<li>"+(index)+"</li><li>"+(res.barcode)+"</li><li>"+(res.bookname)+"</li><li>"+(res.isbnName)+"</li><li>"+(res.author)+"</li><li>"+(res.price)+"</li><li>"+(res.bookNumber)+"</li><li>"+(res.del == 0 ? "未下架" : "已下架")+"</li>");
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
					},
					error:function(data){
						console.log(data.status);
					}
				})
			}
			function initAll(){
				var $content = $(".header .content");
				var $mainContent = $("#mainContent");
				$content.on('click',function(event) {
					var sId = $(this).data('id');
					if($.trim(sId) == "exitSystem" ){
						window.location = "index.jsp";
					}else {
						window.location.hash = sId;
						loadInfo($mainContent);
					}
				});
			}
		});

  	</script>
  </body>

</html>
