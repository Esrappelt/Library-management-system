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
  <link rel="stylesheet" href="css/search.css">
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
      justify-content: center;
      align-items: center;
    }
    .container .inquire {
      width: 25%;
      height: 100%;
      line-height: 50px;
    }
    .bookTitle {
      text-align: center;
      display: block;
      margin:  20px auto;
    }
    .fl {
      float: left;
    }
  </style>
  </head>
  
  <body >
    
  	<div class="container" id="common">
        <div class="inquire">
              <div class="fl">根据图书名称查询：</div>
              <div class="sample seven">
                <input type="text" name="search" placeholder="输入图书名称" class="bookname">
                <button type="submit" class="btn btn-search">
                  <i class="fa fa-search"></i>
                </button>
              </div>
        </div>
        <div class="inquire">
          <div class="fl">根据图书出版社查询：</div>
              <div class="sample seven">
                <input type="text" name="search" placeholder="输入图书出版社"  class="isbnName">
                <button type="submit" class="btn btn-search">
                  <i class="fa fa-search"></i>
                </button>
              </div>
        </div>
        <div class="inquire">
            	
              <div class="fl">根据图书作者查询：</div>
              <div class="sample seven">
                <input type="text" name="search" placeholder="输入图书的作者" class="author">
                <button type="submit" class="btn btn-search">
                  <i class="fa fa-search"></i>
                </button>
              </div>
        </div>
        <div class="inquire">
            	
              <div class="fl">根据图书条形码查询：</div>
              <div class="sample seven">
                <input type="text" name="search" placeholder="输入图书条形码" class="barcode">
                <button type="submit" class="btn btn-search">
                  <i class="fa fa-search"></i>
                </button>
              </div>
        </div>
    </div>
    <div class="indexJsp" id="readerInfo">
      <div class="bookInfo">
        <div class="bookTitle"><h3>查询的图书信息</h3></div>
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
    <div class="noBook"></div>
<script type="text/javascript">
    $(function (){
      var $find = $("input"),value = "",className = "";
      var res;
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
              dataType: 'json',
              async:false
            })
            .done(function(data) {
              //没有数据就是没有查询到图书
                removeReader();
                if(data.length == 0) {
                  noBookshow();
                  return;
                }
                bookInfo(data);
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
      function bookInfo(data){
        noBookhide();
        var $bookInfo = $("#readerInfo .bookInfo .range");
        for(var i = 0; i < data.length; i++) {
          var $ul = createBook(i+1,data[i]);
          $bookInfo.append($ul);
        }
      }
      function createBook(index,res){
        var $ul = $("<ul class='book'></ul>");
        var $li = $("<li>"+(res.barcode)+"</li><li>"+(res.bookname)+"</li><li>"+(res.isbnName)+"</li><li>"+(res.author)+"</li><li>"+(res.price)+"</li><li>"+(res.bookNumber)+"</li><li>"+(res.del ? "未下架" : "已下架")+"</li>");
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
      function removeReader(){
        var $readerInfo = $("#readerInfo");
        $readerInfo.find('.book').remove();
      }
    });
		</script>
  </body>
  
</html>
