function pagec() {
	var pageheight = $(window).height() + 90;
	if (pageheight > 998) {
		pageheight = 998;
	}
	$(".swiper-slide").css("height", pageheight);
	$(".w-banner-con").css("height", pageheight);
	$(".w-banner-cont .w-banner-img").css("height", pageheight);
	$(".w-lf .w-lf-left").css("height", pageheight);
	$(".w-lf .w-lf-cen").css("height", pageheight);
	$(".w-lf .w-lf-right").css("height", pageheight);
}
$(function() {

	pagec();

	$(window).resize(function() {
		pagec();

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
	$(window).scroll(function() {
		if (!$(".w-nav").hasClass("w-nav-no")) {
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
			isopen = false;
		} else {
			$(this).removeClass('fa-bars');
			$(this).addClass('fa-times');
			$(".w-menush").addClass('w-menush-s');
			isopen = true;
		}

	});
});