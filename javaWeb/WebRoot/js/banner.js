 $(function(){
    /*
    准备工作
    */
    //1.调整格式
    var $banner = $(".banner");
    //2.获取图片
    var $imgs = $(".banner img"); 
    //3.图片个数
    var $img_number = $imgs.length;
    //4.创建一个ul
    var $create_ul = $("<ul></ul>");
    //5.将创建的ul包裹.banner里面的img元素
    $imgs.wrapAll($create_ul);
    //6.创建一个li元素
    var $create_li = $("<li></li>");
    //7.每个img都要被li包裹
    $imgs.wrap($create_li);
    //8.在.banner后面添加几个小控制器并添加到banner后面,并且play里面添加图片多的个数的span元素
    var $create_play = $("<div class='play'></div>");
    for(var i = 0; i < $img_number; i++) {
        var $create_span = $("<span></span>");//动态创建一个span元素并添加到play里面去
        $create_span.appendTo($create_play);
    }
    $create_play.appendTo($banner);
    //9.创建控制器
    var $create_controller = $("<div class='controller'></div>");
    //10.创建前后按钮控制器
    var $create_prev = $("<div class='prev'></div>");
    var $create_next = $("<div class='next'></div>");
    $create_prev.appendTo($create_controller);
    $create_next.appendTo($create_controller);
    $create_controller.appendTo($banner);
    //11.复制第一张图片到列表的最后
    var $clone_first_img = $(".banner ul>li").eq(0).clone();
    $(".banner ul").append($clone_first_img);
    //12.设置样式

    //重新获取元素

    var $ul = $(".banner ul");//获取ul
    var $controller = $(".banner div.controller");//获取前后按钮控制器
    var $prev = $controller.find('.prev');//前按钮控制器
    var $next = $controller.find('.next');//后按钮控制器
    var $span = $banner.find('.play>span');//n个小按钮控制器
    //获取宽度和高度，给图片添加宽度和高度
    var $bannerWidth = $banner.width();
    var $bannerHeight = $banner.height();
    var $oneWidth = $bannerWidth;
    //开始设置样式
    $banner.css({
        'position': 'relative',
        'overflow': 'hidden',
        'display': 'block'
    });
    //给图片设置宽高
    $(".banner ul>li img").each(function(index, el) {
        $(this).width($bannerWidth);
        $(this).height($bannerHeight);
    });
    //给ul设置宽度和高度,宽度是(图片的数量 + 1)乘以图片的宽度
    var $ul = $(".banner ul");
    $ul.css({
        'width': $bannerWidth * ($img_number + 1),
        'height': $bannerHeight,
        'position': 'relative'
    });

    //开始设置交互
    var timer = null;
    var count = 0;

    //先初始化样式
    $span.eq(0).addClass('on');
    //然后播放
    autuplay();

    //鼠标放在banner上
    $banner.hover(function() {
        //清除定时器
        clearInterval(timer);
        //显示控制器
        $controller.fadeIn(200);
    }, function() {
        //继续播放
        autuplay();
        //隐藏播放器
        $controller.fadeOut(200);
    });
    //鼠标移动在控制器上
    $span.mouseover(function() {
        //获取当前的位置
        count = $(this).index();
        //移动
        move();
    });
    //自动播放
    function autuplay() {
        timer = setInterval(function(){
            count++;
            move();
        },3000);
    }   
    //鼠标点击下一张
    $next.on('click', function(event) {
        event.preventDefault();
        count++;
        move();
    });
    //鼠标点击上一张
    $prev.on('click', function(event) {
        event.preventDefault();
        count--;
        move();
    });
    //移动
    function move() {
        if(count == $img_number + 1){//移动到最后一张的时候
            $ul.css('left', 0);//先假装跑到第一张图去
            count = 1;//再设置动画到第二张
        }
        else if(count == -1) {//假如向前按钮
            $ul.css('left',-($img_number) * ($oneWidth));
            //先悄悄跑到最后一张图，因为最后一张图和第一张图相同嘛
            count = $img_number - 1;
            //然后呢就动画到真正的最后一张，也就是现在的到数第二张
        }
        $ul.stop().animate({
            'left': -count * $oneWidth
        });
        $span.eq(count == $img_number ? 0 : count).addClass('on').siblings().removeClass('on');
    }
    /**
    完毕
    **/
});