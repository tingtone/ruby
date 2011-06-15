 $(".indent em:first").addClass("cur")	
 $(".indent .sub-wrap:not(:first)").hide();
 $('.indent em').click(function(){
							 
	var $wrap=$(this).parent().parent().find(".sub-wrap");
	var $other=$(this).parent().parent().siblings()
	$(this).prev().toggleClass('cur')
	$(this).parent().parent().siblings().find('h3 span').removeClass('cur')
	$wrap.slideToggle("slow");
	$other.find(".sub-wrap").hide();
    $(this).toggleClass("cur");
	//$(this).siblings("h3").removeClass("active").find("img").attr({"src":"image/jiantou1.gif"});
				
				
				
							 })