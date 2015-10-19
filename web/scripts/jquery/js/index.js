function pagec() {
	var pageheight = $(window).height() + 120;
//	if (pageheight > 998) {
//		pageheight = 998;
//	}
	if($('.jumbotron').length>0){
		$(".swiper-slide").css("height", pageheight);
		$(".a_link").css("height", pageheight);
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
	$('.index_show').height($(window).height()-300);
	$('.mrzt,.mall_right').height($('.mall_con').height());
	$('.product .li2 div').width($('.product .li2').width() - 85);
    $(".cutstr3").each(function(i){
		var divH = $(this).height();
		var $p = $("div", $(this)).eq(0);
		$p.text($p.attr('title'));
		while ($p.outerHeight() > divH) {
			$p.text($p.text().replace(/(\s)*([a-zA-Z0-9]+|\W)(\.\.\.)?$/, "..."));
		};
	});
	
}
$(function() {

	pagec();
    $(".product .li2 .cutstr2").css("width", "80%");
	$(window).resize(function() {
		pagec();
//$("#w-logot").text($(window).width());
	});
	var margin_h = $('.index_show').height()-220;
	$(".text_content").css("margin-top", margin_h);
	
	$(".sh_link").height($('.index_show').height());
	$(".sh_link").width($('.index_left').width());
	
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
	$(window).scroll(function() {
		if (!$(".index-nav").hasClass("w-nav-no")) {
			if ($(window).scrollTop() > 1) {
				$(".w-nav").addClass("w-nav-s");

			} else {
				$(".w-nav").removeClass("w-nav-s");
			}
		}
	})
	var isopen = false;
	$(".w-menusm .fa").click(function() {
		if (isopen) {
			$(this).removeClass('fa-times');
			$(this).addClass('fa-bars');
			$(".w-menush").removeClass('w-menush-s');
			$(".w-m-tmenus").slideUp("slow"); //2015-8-11 
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
	if ($('.designer_show .swiper-slide').length > 1) {
        var swiper3 = new Swiper('.designer_show', {
            autoplay: 4500,
            pagination: '.designer_pagination',
            //xuanyang
            paginationClickable: true,
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
	$('.join_box .j2 span').click(function(){
		$(this).addClass('current').siblings().removeClass('current');
	});
	$('.sku_list .li6 .join').click(function(){
		$(this).hide();
		$(this).parent().siblings('.join_box').show();
	});
	$('.cart_close').click(function () {
        $(this).parent(".join_box").hide();
        $(this).parent().parent().find('.join').show();
    });
	$('.product .li1').hover(function(){
		$(this).find('.imgt').fadeIn();
	},function(){
		$(this).find('.imgt').fadeOut();
	});
	
	
	
	//2015-8-11 商城二级菜单 js
	$(".w-menu-sc").click(function() {
		if ($(".w-m-tmenus").is(":visible") == false) {
			$(".w-m-tmenus").slideDown("slow");
		} else {
			$(".w-m-tmenus").slideUp("slow");;
		}
	});
	$(".w-mt-ud").click(function() {
		$(".w-mt-ud").each(function(){
			$(this).removeClass("w-mt-up");
			$(this).addClass("w-mt-down");
			$(this).find('.w-mt-nav').removeClass("w-oon");
			$(this).find('.fa').addClass("fa-chevron-down");
			$(this).find('.fa').removeClass("fa-chevron-up");
		})
		if ($(this).hasClass("w-mt-down")) {
			$(this).removeClass("w-mt-down");
			$(this).addClass("w-mt-up");
			$(this).find('.w-mt-nav').addClass("w-oon");
			$(this).find('.fa').removeClass("fa-chevron-down");
			$(this).find('.fa').addClass("fa-chevron-up");
		} else {
			$(this).removeClass("w-mt-up");
			$(this).addClass("w-mt-down");
			$(this).find('.w-mt-nav').removeClass("w-oon");
			$(this).find('.fa').addClass("fa-chevron-down");
			$(this).find('.fa').removeClass("fa-chevron-up");
		}

	});
	//2015-8-11 商城二级菜单 js end
	
	
	
});