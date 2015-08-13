function pagec() {
	var pageheight = $(window).height() + 120;
//	if (pageheight > 998) {
//		pageheight = 998;
//	}
	if($('.jumbotron').length>0){
		$(".swiper-slide").css("height", pageheight);
	}
	$(".w-banner").css("height", pageheight);
	$(".w-banner-con").css("height", pageheight);
	$(".w-banner-cont .w-banner-img").css("height", pageheight);
	$(".w-banner-cont .w-bannert-txt").css("height", pageheight);
	$(".w-lf .w-lf-left").css("height", pageheight+200);
	$(".w-lf .w-lf-cen").css("height", pageheight+200);
	$(".w-lf .w-lf-right").css("height", pageheight+200);
				$(".w-bannert").css("height", pageheight);
	if($(window).width()<768){
		$(".w-lf").css("height", pageheight*2+400);
			$(".w-bannert").css("height", pageheight*2);
	}else{
	$(".w-lf").css("height", pageheight+200);	
	}
	$('.index_show').height($(window).height()-94);
	$('.mrzt,.mall_right').height($('.mall_con').height());
	$('.product .li2 div').width($('.product .li2').width()-85);
	$(".cutstr2").each(function(i){
		var divH = $(this).height();
		var $p = $("a", $(this)).eq(0);
		$p.text($p.attr('title'));
		while ($p.outerHeight() > divH) {
			$p.text($p.text().replace(/(\s)*([a-zA-Z0-9]+|\W)(\.\.\.)?$/, "..."));
		};
	});
	
}
$(function() {

	pagec();

	$(window).resize(function() {
		pagec();
//$("#w-logot").text($(window).width());
	});
	
	$(".w-menu-lr").click(function() {
		$(".w-login").show();
		$(".w-login-left").show();
		$(".w-login-right").hide();
	})
	$(".w-l-close a").click(function() {
		$(".w-login").hide();
	})
	$(".w-menu-lrzc").click(function() {
		$(".w-login").show();
		$(".w-login-right").show();
		$(".w-login-left").hide();
	})
	$(".w-l-close a").click(function() {
			$(".w-login").hide();
		})

	$(".w-gwc").mouseover(function() {
		$(".w-car").show();
	})

	$(".w-car").mouseover(function() {
		$(".w-car").show();
	})
	$(".w-car").mouseout(function() {
		$(".w-car").hide();
	})
	
	$(".w-search").mouseover(function() {
		$(".w-sea").show();
	})

	$(".w-sea").mouseover(function() {
		$(".w-sea").show();
	})
	$(".w-sea").mouseout(function() {
		$(".w-sea").hide();
	})


	$(".jumbotron").click(function() {
//		$(".w-car").hide();
	})
//	$(window).scroll(function() {
//		if (!$(".w-nav").hasClass("w-nav-no")) {
//			if ($(window).scrollTop() > 1) {
//				$(".w-nav").addClass("w-nav-s");
//
//			} else {
//				$(".w-nav").removeClass("w-nav-s");
//			}
//		}
//	})
	var isopen = false;
	$(".w-menusm .fa").click(function() {
		if (isopen) {
			$(this).removeClass('fa-times');
			$(this).addClass('fa-bars');
			$(".w-menush").removeClass('w-menush-s');
			isopen = false;
		} else {
			$(this).removeClass('fa-bars');
			$(this).addClass('fa-times');
			$(".w-menush").addClass('w-menush-s');
			isopen = true;
		}

	});
	$('.visible-lg-block ul dd').hover(
		function(){
			$(this).children('.mem_dow').fadeIn();
		},function(){
			$(this).children('.mem_dow').fadeOut();
		}
	);
	if($('.index_left .swiper-slide').length>1){
		var swiper3 = new Swiper('.index_left', {
			autoplay: 4500,
			pagination : '.pagination',
			paginationClickable :true,
		});
	}
	$('.carefully_list li').click(function(){
		var $this = $(this).index();
		$(this).addClass('current').siblings().removeClass('current');
		$('.mall_right li').eq($this).fadeIn().siblings().fadeOut();
	});
	$('.carefully_list li').eq(0).trigger("click");
	$('.mall_right li,.new_list li').hover(
		function(){
			$(this).children('.mall_right_title').fadeIn();
		},function(){
			$(this).children('.mall_right_title').fadeOut();
		}
	);
});