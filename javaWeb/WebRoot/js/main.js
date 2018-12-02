//加载页面
    	window.onload  = function (){
	    	console.log("加载完毕");
	    	bookInfo(res);
	    }
    	function bookInfo(data){
    		var $bookInfo = $(".bookInfo");
    		for(var i = 0; i < data.length; i++) {
    			var $ul = createBook(i+1,data[i]);
    			$bookInfo.append($ul);
    		}
    	}
    	function createBook(index,res){
    		var $ul = $("<ul class='book'></ul>");
    		var $li = $("<li>"+(index)+"</li><li>"+(res.barcode)+"</li><li>"+(res.booname)+"</li><li>"+(res.isbnName)+"</li><li>"+(res.author)+"</li><li>"+(res.price)+"</li><li>"+(res.bookNumber)+"</li><li>"+(res.del ? "未下架" : "已下架")+"</li>");
    		$ul.append($li);
    		return $ul;
    	}

    	//获取图书信息
    	$(function(){
			$.ajax({
				url: 'bookInfo',
				type: 'get',
				dataType:'json', 
				success:function (data){
					res = data;
					console.log(data);
				},
				error:function(data){
					console.log("无获取到数据");
				}
			})
			
	    });
    	//美化页面
   		$(function (){
   			init();
   			function init(){
   				var $content = $(".content");
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
	   				console.log(formatTime);
	   			}
   			}
   		});