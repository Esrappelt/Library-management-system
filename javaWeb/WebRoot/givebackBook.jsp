<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  <style>

    #common *{
      box-sizing: border-box;
    }
    input {
      border: 1px solid #ccc;
      font-size: 12px;
      height: 30px;
      padding: 4px 8px;
      position: absolute;
      width: 50%;
    }
    input:focus {
      outline: none;
    }

    button {
      text-align: center;
    }
    button:focus {
      outline: none;
    }
    button.btn-search, button.btn-reset {
      background: hotpink;
      border: none;
      height: 30px;
      font-size: 12px;
      padding: 4px;
      position: absolute;
      width: 30px;
    }

    .sample {
      height: 30px;
      left: 50%;
      position: relative;
      margin-left: -75px;
      width: 150px;
      margin-top: 50px;
    }

    .sample.nine input, .sample.ten input {
      border-radius: 15px;
      transition: all .6s ease-in-out .3s;
      width: 120px;
    }
    .sample.nine input:focus, .sample.ten input:focus {
      transition-delay: 0;
      width: 200px;
    }
    .sample.nine input:focus ~ button, .sample.ten input:focus ~ button {
      transform: rotateZ(360deg);
    }
    .sample.nine input:focus ~ button.btn-search, .sample.ten input:focus ~ button.btn-search {
      background: hotpink;
      color: #fff;
      left: 172px;
      transition-delay: 0;
    }
    .sample.nine input:focus ~ button.btn-reset, .sample.ten input:focus ~ button.btn-reset {
      left: 202px;
      transition-delay: .3s;
    }
    .sample.nine button, .sample.ten button {
      transition: all .6s ease-in-out;
    }
    .sample.nine button.btn-search, .sample.ten button.btn-search {
      background: #ccc;
      border-radius: 50%;
      height: 26px;
      left: 92px;
      top: 2px;
      transition-delay: .3s;
      width: 26px;
    }
    .sample.nine button.btn-reset, .sample.ten button.btn-reset {
      background: #fff;
      border: 1px solid #ccc;
      border-radius: 50%;
      font-size: 10px;
      height: 20px;
      left: 92px;
      line-height: 20px;
      padding: 0;
      top: 5px;
      width: 20px;
      z-index: -1;
    }

    @keyframes bounceRight {
      0% {
        transform: translateX(0px);
      }
      50% {
        transform: translateX(10px);
      }
      100% {
        transform: translateX(0px);
      }
    }
    @keyframes jumpTowardSearch {
      0% {
        background: #ccc;
        opacity: 1;
        transform: rotateZ(0deg) scale(1);
      }
      20% {
        background: #ccc;
        opacity: 0;
        transform: rotateZ(-60deg) scale(50);
      }
      55% {
        background: hotpink;
        opacity: 0;
        transform: rotateZ(-30deg) scale(100);
      }
      90% {
        background: hotpink;
        opacity: 0;
        transform: rotateZ(-30deg) scale(50);
      }
      100% {
        background: hotpink;
        opacity: 1;
        transform: rotateZ(0deg) scale(1);
      }
    }
    @keyframes jumpTowardReset {
      0% {
        opacity: 0;
        transform: rotateZ(0deg) scale(1);
      }
      20% {
        opacity: 0;
        transform: rotateZ(-60deg) scale(50);
      }
      55% {
        opacity: 0;
        transform: rotateZ(-30deg) scale(100);
      }
      90% {
        opacity: 0;
        transform: rotateZ(-30deg) scale(50);
      }
      100% {
        opacity: 1;
        transform: rotateZ(0deg) scale(1);
      }
    }
  </style>
  <style type="text/css">
		#borrowInfo {
			cursor: pointer;
		}
		#borrowInfo .choiceGiveBack {
			background: rgba(104, 54, 153,.8);
			transition: all 1s;
			color: white;
		}
    .bookTitle {
      padding-top: 60px;
    }
	</style>
  </head>
  
  <body>
  
    <div class="sample ten" id="common">
      <input type="text" name="search" placeholder="请输入学生学号" id="stuno">
      <button type="submit" class="btn btn-search">
        <i class="fa fa-search"></i>
      </button>
      <button type="reset" class="btn btn-reset fa fa-times"></button>
    </div>



	<div id="borrowInfo">
		<div class="indexJsp" >
			<div class="bookInfo">
				<div class="bookTitle"><h3>学生的图书借阅情况</h3></div>
		    	<!-- 显示图书借阅排行榜 -->
		    	<div class="range">
		    		<ul class="baseInfo">
		    			<li>选择归还</li>
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
  <input class="operator" type="hidden" value="<%=session.getAttribute("name")%>">
  <div class="noBook"></div>
  </body>
  <script type="text/javascript">
  	$(function (){
  		var stuInfo;
  		var $stuno = $("#stuno");
  		$stuno.on('input', function(event) {
  			event.preventDefault();
  			stuInfo = $(this).val();
        console.log(stuInfo);
  			throttle(processStuInfo);
  		});
  		//用户点击归还
  		$("#borrowInfo").on('click', '.choiceGiveBack', function(event) {
  			var bookid = $("#borrowInfo .bookid").get(0).value;
  			var that = $(this).parent(".book");
  			givebackBook(bookid,function (){
  				that.remove();
  				alert("恭喜您，还书成功!,欢迎再次借阅");
  			});
  		});
  		function givebackBook(bookid,callback){
  			var date = new Date();
  			var backTime = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + (date.getDay() + 1);
  			var operator = $(".operator").get(0).value;
  			$.ajax({
  				url: 'giveSuccess',
  				type: 'get',
  				dataType: 'text',
  				data: {
  					'stuno': stuInfo,
  					'bookid': bookid,
  					'backTime':backTime,
  					'operator':encodeURI(operator)
  				}
  			})
  			.done(function(data) {
  				callback();
  				
  			})
  			.fail(function(e) {
  				console.log(e.status);
  			})
  		}
  		function processStuInfo(){
  			if(stuInfo === "") {return;}
  			$.ajax({
  				url: 'giveBack?stuno=' + stuInfo,
  				type: 'get',
  				dataType: 'json'
  			})
  			.done(function(data) {
          removeBook();
          $stuno.val("");
          if(data.length == 0) {
            noBookshow();
            return;
          }
  				processStuDiv(data);
  			})
  			.fail(function(e) {
  				console.log(e.status);
  			})
  		}
  		function processStuDiv(data){
        noBookhide();
  			bookInfo(data);
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
	  	//图书添加方法
	    function bookInfo(data){
			var $borrowInfo = $("#borrowInfo .indexJsp .bookInfo .range");
			for(var i = 0; i < data.length; i++) {
				var $ul = createBook(i+1,data[i]);
				$borrowInfo.append($ul);
			}
		}
		function createBook(index,res){
			var $ul = $("<ul class='book'></ul>");
			var $li = $("<li class='choiceGiveBack'>我要归还</li><li>"+(res.barcode)+"</li><li>"+(res.bookname)+"</li><li>"+(res.isbnName)+"</li><li>"+(res.author)+"</li><li>"+(res.price)+"</li><li>"+(res.bookNumber)+"</li><li>"+(res.del ? "未下架" : "已下架")+"</li><input class='bookid' type='hidden' value='"+(res.bookid)+"'/>");
			$ul.append($li);
			return $ul;
		}
    function noBookshow(){

        $(".noBook").show();
      }
      //隐藏未查询到的处理
      function noBookhide() {

        $(".noBook").hide();
      }
      function removeBook(){
        var $borrowInfo = $("#borrowInfo");
        $borrowInfo.find('.book').remove();
      }
  	});
  </script>
</html>
