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
	<style>
		* {
			padding: 0;
			margin: 0;
		}
		#readerInfo {
			width: 100%;
		}
		#submit {
			width: 100px;
			height: 50px;
			background: rgb(104, 54, 153);
			display: block;
			position: absolute;
			border: none;
			cursor: pointer;
			color: white;
			font-size: 16px;
			border-radius: 5px;
			bottom: 10%;
			left: 50%;
			margin-bottom: -25px;
			margin-left: -50px;
			transition: .5s;
		}
		#submit:hover {
			background: black;
		}
	</style>
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
		<div class="indexJsp">
            <div class="bookInfo">
                <div class="stuinfo"><h3>学生信息</h3>
                </div>
                <!-- 显示图书借阅排行榜 -->
                <div class="range">
                    <ul class="baseInfo">
                        <li>姓名</li>
                        <li>性别</li>
                        <li>职业</li>
                        <li>身份证</li>
                        <li>证件类型</li>
                        <li>电话号码</li>
                        <li>邮箱</li>
                        <li>可借阅量</li>
                    </ul>
                </div>
            </div>
    	</div>
	</div>

	<!-- 要借的图书的信息 -->
	<div id="bookInfo">
		<div class="indexJsp" >
			<div class="bookInfo">
				<div class="bookTitle"><h3>图书信息</h3></div>
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
	
	<input type="hidden" value="<%=session.getAttribute("name")%>">
	
	
	
	
	<script>
  		$(function (){
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
			//判断输入的情况
			var hasReaderInfo = false,hasBookInfo = false;
			//保存id
			var readerid,bookid;		
			//函数的统一管理
			function getAllInfo(callback){
				//管理读者
				ReaderInit();
				//管理图书
				BookInit();
				//管理完成借阅模块
				callback(BorrowInit);
			}

			//读者模块
			function ReaderInit(){
				//输入学号的时候，获取学生的信息
				$stuno.on('input', function(event) {
					event.preventDefault();
					hasReaderInfo = false;
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
					dataType: 'json'
				})
				.done(function(data) {
					
					processReaderInfo(data);
					
					hasReaderInfo = true;
					$stuno.val("");
				})
			}
			//这里渲染读者信息
			function processReaderInfo(data){
				console.log(data);
				readerid = data[0].readerid;
				console.log(readerid);
				//获取读者DIV
				var $readerInfo = $("#readerInfo");
				$readerInfo.find('.indexJsp .range .book').remove();
				addReader(data);
			}
			//读者模块结束

			//借阅模块
			function BorrowInit() {
				$submit.on('click', function(event) {
					event.preventDefault();
					//判断有没有输入值
					if (!canSubmit()) {
						alert("请输入图书名称或者图书条形码以获取图书信息！");
						return;
					}
					//设置日期
					var time = setTime();
					var operator = $("input[type=hidden]").val();
					operator = encodeURI(operator);
					var param = {
						'readerid':readerid,
						'bookid':bookid,
						'borrowtime':time.borrowtime,
						'givebackTime':time.givebackTime,
						'operator':operator
					};
					console.log(param);
					$.ajax({
						url: 'borrowBook',
						type: 'post',
						dataType: 'text',
						data: param
					})
					.done(function(data) {
						console.log(data);
						processSuccessBorrow(data);
						
					})
				});
			}
			function setTime(){
	            var date = new Date();
	            var year = date.getFullYear(),month = date.getMonth() + 1,day = date.getDay() + 1;
	            var borrowtime = year + "-" + month + "-" + day;
	            var givebackDate = new Date(year,month,day);
	            var newyear = givebackDate.getFullYear(),newmonth = givebackDate.getMonth() + 1,newday = givebackDate.getDay() + 1;
	            givebackDate.setDate(date.getDate()+30);
	            var givebackTime =  newyear + "-" + newmonth + "-" + newday;
	            return {"borrowtime":borrowtime,"givebackTime":givebackTime};
       	 	}
			function canSubmit(){
				return hasBookInfo && hasReaderInfo;
			}
			function processSuccessBorrow(data){
				if($.trim(data) == "true"){
					//成功
					alert("恭喜您，借阅成功，请记得及时归还!");
				}else if($.trim(data) == "false"){
					//
					console.log('抱歉，您已经借了这本书了，应该归还!');
					alert('抱歉，您已经借了这本书了，应该归还!');
				}
			}
			//借阅模块结束










			//图书模块
			function BookInit(){
				//点击完成的时候  ，获取信息
				$confirm.on('click',function(event) {
					event.preventDefault();
					hasBookInfo = false;
					getBookInfo();
				});
			}
			function getBookInfo(){
				//获取值
				barcodeValue = $barcode.val(),bookTitleValue = $bookTitle.val();
				if(barcodeValue === "" && bookTitleValue === "") {
					alert("请输入图书名称或者图书条形码!");
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
					bookid = data[0].bookid;
					console.log('bookid=' + bookid);
					callback(data);
				})
			}
			//这里渲染图书信息
			function processBookInfo(data){
				console.log(data);
				var $bookInfo = $("#bookInfo");
				$bookInfo.find('.indexJsp .book').remove();
				bookInfo(data);
				hasBookInfo = true;
			}
			//图书模块结束




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
	        //图书添加方法
	        function bookInfo(data){
				var $bookInfo = $("#bookInfo .indexJsp .bookInfo .range");
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
			//读者信息添加方法
			function addReader(data){
				var $readerInfo = $("#readerInfo .indexJsp .bookInfo .range");
				for(var i = 0; i < data.length; i++) {
					var $ul = createReader(data[i]);
					$readerInfo.append($ul);
				}
			}
			function createReader(res){
				var $ul = $("<ul class='book'></ul>");
				var $li = $("<li>"+(res.name)+"</li><li>"+(res.sex)+"</li><li>"+(res.vocation)+"</li><li>"+(res.idCard)+"</li><li>"+(res.paperType)+"</li><li>"+(res.tel)+"</li><li>"+(res.email)+"</li><li>"+(res.borrownumber)+"</li>");
				$ul.append($li);
				return $ul;
			}
			getAllInfo(function (BorrowInit){
				BorrowInit();
			});
		});
 	</script>
  </body>

</html>
