<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'borrowBook.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body> 
    <form>
		请输入学生的学号
		<input type="number" name="stuno">
		<div class="addway">
			请选择添加图书的方式：
			<input type="text" name="barcode" placeholder="请输入图书条形码" >
			或者<input type="text" name="bookTitle" placeholder="请输入图书名称">
			<input type="button" value="确定填写完成" name="confirm">
		</div>
		
		<input type="button" value="完成借阅" id="submit">
	</form>
	<!-- 学生信息显示 -->
	<div id="readerInfo">
		
	</div>

	<!-- 要借的图书的信息 -->
	<div id="bookInfo">
		<div class="indexJsp" >
			<div class="bookInfo">
				<div class="rangeTitle"><h3>图书信息</h3></div>
		    	<!-- 显示图书借阅排行榜 -->
		    	<div class="range">
		    		<ul class="baseInfo">
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
	
	
	
	
	
	<script>
  		$(function (){
			
			//函数的统一管理
			function getAllInfo(){
				//管理读者
				ReaderInit();
				//管理图书
				BookInit();
				//管理完成借阅模块
				BorrowInit();
			}
			//获取学号
			var $stuno = $("input[name=stuno]");
			//获取图书条形码
			var $barcode = $("input[name=barcode]");
			//获取图书名称
			var $bookTitle = $("input[name=bookTitle]");
			//获取完成
			var $confirm = $("input[name=confirm]");
			//获取提交
			var $submit = $("#submit");
			//保存值的变量
			var stunoInputValue = "",barcodeValue = "",bookTitleValue = "";


			//图书模块
		function BookInit(){
				//点击完成的时候  ，获取信息
				$confirm.on('click',function(event) {
					event.preventDefault();
					getBookInfo();
				});
			}
			function getBookInfo(){
				//获取值
				barcodeValue = $barcode.val(),bookTitleValue = $bookTitle.val();
				if(barcodeValue === "" && bookTitleValue === "") {
					console.log('没有输入值');
					//这里处理一下没有输入值的时候，提醒管理员应该输入什么
					return;
				}
				//根据图书条形码获取图书信息
				if(barcodeValue !== "") {//默认是先走第一个if，若两个都填，则选择的是第一个
					//条形码的参数为barcode
					getBarcodeInfo(barcodeValue,'barcode',function (data){
						processBookInfo(data);
					});
				} else if(bookTitleValue !== "") {
					//图书名称的调用参数为bookname
					getBarcodeInfo(bookTitleValue,'bookname',function (data){
						processBookInfo(data);
					});
				}
			}
			function getBarcodeInfo(value,param,callback){
				var url = "findBook?" + param + "=" + encodeURI(encodeURI(value));
				$.ajax({
					url: url,
					type: 'get',
					dataType: 'json'
				})
				.done(function(data) {
					callback(data);
				})
			}
			//这里渲染图书信息
			function processBookInfo(data){
				console.log(data);
				var $bookInfo = $("#bookInfo");
				$bookInfo.find('.indexJsp').css('display', 'block');
				bookInfo(data);
			}
			//图书模块结束

			//读者模块
			function ReaderInit(){
				//输入学号的时候，获取学生的信息
				$stuno.on('input', function(event) {
					event.preventDefault();
					stunoInputValue = $(this).val();
					//去获取信息
					throttle(getReaderInfo);
				});
			}

			function getReaderInfo(){
				var url = "ReaderInfo?stuno=" + stunoInputValue; 
				$.ajax({
					url: url,
					type: 'get',
					async:false,
					dataType: 'json'
				})
				.done(function(data) {
					processReaderInfo(data);
				})
			}
			//这里渲染读者信息
			function processReaderInfo(data){
				var $readerInfo = $("#readerInfo");
				$readerInfo.html("");
				$readerInfo.text(data);
			}
			//读者模块结束
			

			//借阅模块
			function BorrowInit() {

			}
			//借阅模块结束

			//函数节流方法
			function throttle(method,context){
	          context = context || window;
	          //用tId清除定时器
	          clearTimeout(method.tId);
	          //然后继续产生这个定时器
	          method.tId = setTimeout(function(){
	            //让执行上下文(这里是window)调用一下method ===>即这里的proccess
	            method.call(context);//相当于window.proccess();
	          },1000);
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
				var $li = $("<li>"+(index)+"</li><li>"+(res.barcode)+"</li><li>"+(res.bookname)+"</li><li>"+(res.isbnName)+"</li><li>"+(res.author)+"</li><li>"+(res.price)+"</li><li>"+(res.bookNumber)+"</li><li>"+(res.del ? "未下架" : "已下架")+"</li>");
				$ul.append($li);
				return $ul;
			}
	        getAllInfo();
		});
 	</script>
  </body>

</html>
