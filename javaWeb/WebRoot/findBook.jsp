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
    .bookTitle {
      text-align: center;
      display: block;
      margin:  20px auto;
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
    <div class="indexJsp">
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
                  bookInfo(data);
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
      function bookInfo(data){
        var $bookInfo = $(".indexJsp .bookInfo .range");
        $bookInfo.find('.book').text("");
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
    });
		</script>
  </body>
  
</html>
