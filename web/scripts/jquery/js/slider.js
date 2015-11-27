function pagec() {
    //全局变量 高度
    var pageheight = $(window).height() + 120;
    //	if (pageheight > 998) {
    //		pageheight = 998;
    //	}
    //初始化幻灯片高度
    if ($('.jumbotron').length > 0) {
        $(".swiper-slide").css("height", pageheight);
        $(".a_link").css("height", pageheight);
    }
    //初始化幻灯片高度
    $(".w-banner").css("height", pageheight);
    $(".w-banner-con").css("height", pageheight);
    $(".w-banner-cont .w-banner-img").css("height", pageheight);
    $(".w-banner-cont .w-bannert-txt").css("height", pageheight);
    $(".w-lf .w-lf-left").css("height", pageheight + 200);
    $(".w-lf .w-lf-cen").css("height", pageheight + 200);
    $(".w-lf .w-lf-right").css("height", pageheight + 200);
    $(".w-bannert").css("height", pageheight);
    //初始化手机端幻灯片高度
    if ($(window).width() < 768) {
        $(".w-lf").css("height", pageheight * 2 + 400);
        $(".w-bannert").css("height", pageheight * 2);
    } else {
        $(".w-lf").css("height", pageheight + 200);
    }
    //商城首页轮播图高度初始化
    $('.index_show').height($(window).height() - 300);
    //每周主打，每周上新高度初始化
    $('.mrzt,.mall_right').height($('.mall_con').height());
    $('.product .li2 div').width($('.product .li2').width() - 85);
    //设计师最新动态最多显示文字字数控制
    $(".cutstr3").each(function (i) {
        var divH = $(this).height();
        var $p = $("div", $(this)).eq(0);
        $p.text($p.attr('title'));
        while ($p.outerHeight() > divH) {
            $p.text($p.text().replace(/(\s)*([a-zA-Z0-9]+|\W)(\.\.\.)?$/, "..."));
        };
    });
}
$(function () {
    //页面加在完毕初始化方法
    pagec();
    //设置产品名称宽度
    $(".product .li2 .cutstr2").css("width", "80%");
    //窗体大小改变初始化
    $(window).resize(function () {
        pagec();
    });
    //初始化商城首页活动描述文字距离上方的距离
    var margin_h = $('.index_show').height() - 220;
    $(".text_content").css("margin-top", margin_h);
    //初始化商城首页轮播图文字高度和宽度
    $(".sh_link").height($('.index_show').height());
    $(".sh_link").width($('.index_left').width());
    //成功加入购物车
    //$(".j3").click(function () {
    //    $(".w-cart").css("display", "block");
    //    $(".w-cart-s").css("display", "block");
    //})
    ////弹出视屏
    //$(".designer_video").click(function () {
    //    $(".w-cart").css("display", "block");
    //    $(".w-cart-s").css("display", "block");
    //})
    ////放大图片
    //$(".designer_enlarge").click(function () {
    //    var img = $(".swiper-slide-active").attr("data-img");
    //    var video = $(".swiper-slide-active").attr("data-video");
    //    if (video == undefined) {
    //        $(".w-cart-body-video").css("display", "none");
    //        $(".w-cart").css("display", "block");
    //        $(".w-cart-s").css("display", "block");
    //        $(".w-cart-body-img").css("display", "block");
    //        $(".data_img").attr("src", img);
    //    }
    //    else {
    //        video = $(".swiper-slide-active").attr("data-video");
    //        $(".w-cart-body-img").css("display", "none");
    //        $(".w-cart").css("display", "block");
    //        $(".w-cart-s").css("display", "block");
    //        $(".w-cart-body-video").css("display", "block");
    //        $(".data_video").attr("src", img);
    //    }
    //})
    //会员登录 注册 购物车 搜索打开关闭事件
    $(".w-menu-lr").click(function () {
        $(".w-login").show();
        $(".w-login-left").show();
        $(".w-login-right").hide();
    })
    $(".w-l-close a").click(function () {
        $(".w-cart").hide();
        $(".w-login").hide();
    })
    $(".w-menu-lrzc").click(function () {
        $(".w-login").show();
        $(".w-login-right").show();
        $(".w-login-left").hide();
    })
    $(".w-l-close a").click(function () {
        $(".w-login").hide();
    })

    $(".w-gwc").mouseover(function () {
        $(".w-car").show();
    })

    $(".w-car").mouseover(function () {
        $(".w-car").show();
    })
    $(".w-car").mouseout(function () {
        $(".w-car").hide();
    })

    $(".w-search").mouseover(function () {
        $(".w-sea").show();
    })

    $(".w-sea").mouseover(function () {
        $(".w-sea").show();
    })
    $(".w-sea").mouseout(function () {
        $(".w-sea").hide();
    })
    //END 会员登录 注册 购物车 搜索打开关闭事件

    $(".jumbotron").click(function () {
        //		$(".w-car").hide();
    })
    //浏览器滚动事件
    $(window).scroll(function () {
        //滚动浏览器导航显示操作
        if (!$(".index-nav").hasClass("w-nav-no")) {
            if ($(window).scrollTop() > 1) {
                $(".w-nav").addClass("w-nav-s");

            } else {
                $(".w-nav").removeClass("w-nav-s");
            }
        }
    })
    var isopen = false;
    //手机端 菜单栏事件
    $(".w-menusm .fa").click(function () {
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
    //菜单栏鼠标悬浮事件
    $('.visible-lg-block ul dd').hover(
		function () {
		    $(this).children('.mem_dow').fadeIn();
		}, function () {
		    $(this).children('.mem_dow').fadeOut();
		}
	);
    //初始化轮播图
    if ($('.index_left .swiper-slide').length > 1) {
        var swiper3 = new Swiper('.index_left', {
            autoplay: 4500,
            pagination: '.pagination',
            paginationClickable: true,
            loop: true,
            preventClicks: false,
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
    //每周主打点击事件
    $('.carefully_list li').click(function () {
        var $this = $(this).index();
        $(this).addClass('current').siblings().removeClass('current');
        $('.mall_right li').eq($this).fadeIn().siblings().fadeOut();
    });
    $('.carefully_list li').eq(0).trigger("click");
    //图片鼠标悬浮弹出文字介绍
    $('.mall_right li,.new_list li').hover(
		function () {
		    $(this).children('.mall_right_title').fadeIn();
		}, function () {
		    $(this).children('.mall_right_title').fadeOut();
		}
	);
    //商品列表
    $('.join_box .j2 span').click(function () {
        $(this).addClass('current').siblings().removeClass('current');
    });
    $('.product .li6 .join').click(function () {
        $(this).hide();
        $(this).parent().siblings('.join_box').show();
    });
    $('.cart_close').click(function () {
        $(this).parent(".join_box").hide();
        $(this).parent().parent().find('.join').show();
    });
    $('.product .li1').hover(function () {
        $(this).find('.imgt').fadeIn();
    }, function () {
        $(this).find('.imgt').fadeOut();
    });
    //END 商品列表

    //2015-8-11 商城二级菜单 js
    $(".w-menu-sc").click(function () {
        if ($(".w-m-tmenus").is(":visible") == false) {
            $(".w-m-tmenus").slideDown("slow");
        } else {
            $(".w-m-tmenus").slideUp("slow");;
        }
    });
    $(".w-mt-ud").click(function () {
        $(".w-mt-ud").each(function () {
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