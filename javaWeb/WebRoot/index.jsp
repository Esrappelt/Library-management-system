<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>登录</title>
  <link href="http://cdn.bootcss.com/jqueryui/1.11.0/jquery-ui.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/default.css">
  <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
  <div class='login'>
    <div class='login_title'>
      <span>图书管理系统登录</span>
    </div>
    <div class='login_fields'>
      <div class='login_fields__user'>
        <div class='icon'>
          <img src='img/user_icon_copy.png'>
        </div>
        <input placeholder='用户名' type='text' id="username">
          <div class='validation'>
            <img src='img/tick.png'>
          </div>
        </input>
      </div>
      <div class='login_fields__password'>
        <div class='icon'>
          <img src='img/lock_icon_copy.png'>
        </div>
        <input placeholder='密码' type='password' id="password">
        <div class='validation'>
          <img src='img/tick.png'>
        </div>
      </div>
      <div class='login_fields__submit'>
        <input type='submit' value='登录' id="ok">
        <div class='forgot'>
          <a href='#'>忘记密码?</a>
        </div>
      </div>
    </div>
     <div class='error'>
      <h2>验证失败</h2>
      <p><a href="index.jsp">重新登录</a></p>
    </div>
    <div class='success'>
      <h2>验证成功</h2>
      <%  
        if(session.getAttribute("name") != null){
      %>
      <p>欢迎登录~<%=session.getAttribute("name")%></p>
      <%}%>
      <h3 class="mainJsp">进入首页</h3>
    </div>
    <div class='disclaimer'>
      <p>图书管理系统</p>
    </div>
  </div>
  <div class='authent'>
    <img src='img/puff.svg'>
    <p>正在验证,请稍等</p>
  </div>
  <script type="text/javascript" src='js/stopExecutionOnTimeout.js?t=1'></script>
  <script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
  <script type="text/javascript" src="js/md5.js"></script>
  <script type="text/javascript" src="http://cdn.bootcss.com/jqueryui/1.11.0/jquery-ui.min.js"></script>
  <script>
  $('input[type="submit"]').click(function () {
      var username = $("#username").val();
      var password = $("#password").val();
      if(username == "" || password == ""){ alert("请输入用户名和密码!");return;}
      var pwd = $.md5(password);
      $('.login').addClass('test');
      setTimeout(function () {
          $('.login').addClass('testtwo');
      }, 300);
      setTimeout(function () {
          $('.authent').show().animate({ right: -320 }, {
              easing: 'easeOutQuint',
              duration: 600,
              queue: false
          });
          $('.authent').animate({ opacity: 1 }, {
              duration: 200,
              queue: false
          }).addClass('visible');
      }, 500);
      $.ajax({
        url: 'Loginservlet',
        type: 'post',
        dataType: 'text',
        data: {
          'name': username,
          'pwd': password
        }
      })
      .done(function(data) {
        if($.trim(data) == "true"){
          processLogin();
        }else {
          errorLogin();
        }
      })
      .fail(function(e) {
        console.log(e.status);
      })
      function errorLogin(){
        setTimeout(function () {
            $('.authent').show().animate({ right: 90 }, {
                easing: 'easeOutQuint',
                duration: 600,
                queue: false
            });
            $('.authent').animate({ opacity: 0 }, {
                duration: 200,
                queue: false
            }).addClass('visible');
            $('.login').removeClass('testtwo');
        }, 1000);

        //主要是这两个处理登录的结果
        setTimeout(function () {
            $('.login').removeClass('test');
            $('.login div').fadeOut(123);
        }, 1000);
        setTimeout(function () {
            $('.error').fadeIn();
        }, 1000);
      }
      function processLogin(){
        var $mainJsp = $(".mainJsp");
        $mainJsp.on('click', function(event) {
          window.location = "main.jsp";
        });
        setTimeout(function () {
            $('.authent').show().animate({ right: 90 }, {
                easing: 'easeOutQuint',
                duration: 600,
                queue: false
            });
            $('.authent').animate({ opacity: 0 }, {
                duration: 200,
                queue: false
            }).addClass('visible');
            $('.login').removeClass('testtwo');
        }, 1000);

        //主要是这两个处理登录的结果
        setTimeout(function () {
            $('.login').removeClass('test');
            $('.login div').fadeOut(123);
        }, 1000);
        setTimeout(function () {
            $('.success').fadeIn();
        }, 1000);
      }
      
  });
  $('input[type="text"],input[type="password"]').focus(function () {
      $(this).prev().animate({ 'opacity': '1' }, 200);
  });
  $('input[type="text"],input[type="password"]').blur(function () {
      $(this).prev().animate({ 'opacity': '.5' }, 200);
  });
  $('input[type="text"],input[type="password"]').keyup(function () {
      if (!$(this).val() == '') {
          $(this).next().animate({
              'opacity': '1',
              'right': '30'
          }, 200);
      } else {
          $(this).next().animate({
              'opacity': '0',
              'right': '20'
          }, 200);
      }
  });
  var open = 0;
  $('.tab').click(function () {
      $(this).fadeOut(200, function () {
          $(this).parent().animate({ 'left': '0' });
      });
  });
  </script>
</body>
</html>
