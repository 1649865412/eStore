<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>四方街</title>

    <!-- Bootstrap -->
    <script src="${ctxPath}/scripts/jquery/js/global_brain.js"></script>
    <link href="${resPath}/styles/css/font-awesome.css" rel="stylesheet">
    <link href="${resPath}/styles/css/bootstrap.css" rel="stylesheet">
    <link href="${resPath}/styles/css/swiper.min.css" rel="stylesheet">
    <link href="${resPath}/styles/css/animate.min.css" rel="stylesheet">
    <link href="${ctxPath}/scripts/jquery/js/colorbox/colorbox.css" rel="stylesheet" />
    <link href="${resPath}/styles/css/index.css" rel="stylesheet">

    <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
    <link href="${resPath}/styles/css/mall_nav.css" rel="stylesheet">
    <link href="${resPath}/styles/css/shooping-list.css" rel="stylesheet">
    <!--[if IE]>  <link rel="stylesheet" type="text/css" href="index2-ie-only.css/> <![endif]-->
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
    <!--登陆注册-->
    <div class="w-login">
        <div class="w-login-s"></div><!--w-login-s-->
        <div class="w-login-c">
            <div class="w-login-left">
                <div class="w-l-close">
                    <a href="javascript:void(0)"> <i class="fa fa-times"></i> </a>
                </div><!--w-l-close-->
                <div class="w-l-title">会员登陆</div><!--w-l-title-->
                <div class="w-l-items w-l-user">
                    <div class="w-l-itemscon">
                        <i class="fa fa-user"></i>
                        <input type="text" value="邮箱/手机" />
                    </div><!--w-l-itemscon-->
                </div><!--w-l-items w-l-user-->
                <div class="w-l-items w-l-user">
                    <div class="w-l-itemscon">
                        <i class="fa fa-lock"></i>
                        <input type="text" value="密码" />
                    </div><!--w-l-itemscon-->
                </div><!--w-l-items w-l-user-->
                <div class="w-l-items w-l-user">
                    <div class="w-l-itemscon">
                        <i class="fa fa-tag"></i>
                        <input type="text" value="验证码" />
                    </div><!--w-l-itemscon-->
                </div><!--w-l-items w-l-user-->
                <div class="w-l-yzm">
                    <div class="w-l-itemscon">
                        <img src="img/yzm.jpg" />
                    </div><!--w-l-itemscon-->
                </div><!--w-l-yzm-->
                <div class="w-l-btn">
                    <div class="w-l-itemscon">
                        <button class="btn btn-default" type="submit">登陆</button>
                    </div><!--w-l-itemscon-->
                </div><!--w-l-btn-->
                <div class="w-l-info">
                    <div class="w-l-itemscon">
                        <a href="#">忘记密码?</a> | <a href="javascript:void(0)" class="w-menu-lrzc">注册新用户</a>
                    </div><!--w-l-itemscon-->
                </div><!--w-l-info-->
                <div class="w-l-note">
                    <div class="w-l-itemscon">
                        合作网站账号登录
                    </div><!--w-l-itemscon-->
                </div><!--w-l-note-->
            </div><!--w-login-left-->
            <div class="w-login-right">
                <div class="w-l-close">
                    <a href="javascript:void(0)"> <i class="fa fa-times"></i> </a>
                </div><!--w-l-close-->
                <div class="w-l-title">注册新会员</div><!--w-l-title-->
                <div class="w-l-items w-l-user">
                    <div class="w-l-itemscon">
                        <i class="fa fa-user"></i>
                        <input type="text" value="邮箱/手机" />
                    </div><!--w-l-itemscon-->
                </div><!--w-l-items w-l-user-->
                <div class="w-l-items w-l-user">
                    <div class="w-l-itemscon">
                        <i class="fa fa-lock"></i>
                        <input type="text" value="密码" />
                    </div><!--w-l-itemscon-->
                </div><!--w-l-items w-l-user-->
                <div class="w-l-items w-l-user">
                    <div class="w-l-itemscon">
                        <i class="fa fa-lock"></i>
                        <input type="text" value="确认密码" />
                    </div><!--w-l-itemscon-->
                </div><!--w-l-items w-l-user-->
                <div class="w-l-items w-l-user">
                    <div class="w-l-itemscon">
                        <i class="fa fa-tag"></i>
                        <input type="text" value="验证码" />
                    </div><!--w-l-itemscon-->
                </div><!--w-l-items w-l-user-->
                <div class="w-l-yzm">
                    <div class="w-l-itemscon">
                        <img src="img/yzm.jpg" />
                    </div><!--w-l-itemscon-->
                </div><!--w-l-yzm-->
                <div class="w-l-info">
                    <div class="w-l-itemscon">
                        <label>
                            <!--2015-8 蔡蔡改动-->
                            <input type="checkbox" /> <a href="#" style="float:right; margin-top:2px; margin-left:5px;">我已阅读并接受四方街sifangstreet服务条款。</a>
                            <!--end of 蔡蔡改动-->
                        </label>


                    </div><!--w-l-itemscon-->
                </div><!--w-l-info-->
                <div class="w-l-btn">
                    <div class="w-l-itemscon">
                        <button class="btn btn-default" type="submit">登陆</button>
                    </div><!--w-l-itemscon-->
                </div><!--w-l-btn-->

                <div class="w-l-note">
                    <div class="w-l-itemscon">
                        <span class="w-menu-lr">会员登录</span>
                    </div><!--w-l-itemscon-->
                </div><!--w-l-note-->
            </div><!--w-login-right-->
        </div><!--w-login-c-->
    </div><!--w-login-->
    <!--end of 登陆注册-->
    <!--导航-->
    <div class="w-nav w-nav-s navbar-fixed-top">
        <div class="nav2-bg">
            <!--2015-9 和其他一级页面不同的地方-->
            <div class="container" style="position: relative;z-index: 1300;">
                <!--搜索框-->
                <div class="w-sea">
                    <div class="w-sea-list">
                        <div class="w-sea-sj"></div>
                        <div class="w-sea-con">
                            <!--2015-8 蔡蔡改动-->
                            <input type="text" required placeholder="输入搜索内容" class="search_txt">
                            <input type="submit" class="search_button" value="&rarr;">
                            <!--end of 蔡蔡改动-->
                        </div><!--w-sea-con-->
                    </div><!--w-sea-list-->
                </div><!--w-sea-->
                <!--end of 搜索框-->
                <!--购物车-->
                <div class="w-car">
                    <div class="w-car-list">
                        <div class="w-car-sj"></div>
                        <div class="w-car-con">
                            <ul class="list-unstyled clearfix">
                                <li class="clearfix">
                                    <div class="w-car-img">
                                        <img src="img/car1.jpg" />
                                    </div><!--w-car-img-->
                                    <div class="w-car-info">
                                        <span>产品名很长很长恒称呼恒昌很长很长很长</span>
                                        <span class="w-car-price">￥890.00</span>
                                    </div><!--w-car-info-->
                                </li><!--clearfix-->
                                <li class="clearfix">
                                    <div class="w-car-img">
                                        <img src="img/car2.jpg" />
                                    </div><!--w-car-img-->
                                    <div class="w-car-info">
                                        <span>产品名很长很长恒称呼恒昌很长很长很长</span>
                                        <span class="w-car-price">￥890.00</span>
                                    </div><!--w-car-info-->
                                </li><!--clearfix-->
                            </ul><!--list-unstyled clearfix-->
                            <div class="w-car-msg">购物车里还有32件物品</div>
                            <div class="w-car-zj clearfix">
                                <div class="w-car-zjmc">总计：</div>
                                <div class="w-car-price">￥ 2000000.00</div>
                            </div><!--w-car-zj clearfix-->
                            <div class="w-car-btn">
                                <a class="w-car-btn" href="#">查看购物车</a>
                            </div><!--w-car-btn-->
                        </div><!--w-car-con-->
                    </div><!--w-car-list-->
                </div><!--w-car-->
                <!--end of 购物车-->
                <div class="row visible-md-block visible-lg-block">
                    <div class="col-md-2 col-lg-2 w-logo">
                        <a href="#" id="w-logot">四方街</a>
                    </div><!--col-md-2 col-lg-2 w-logo-->
                    <div class="col-md-6 col-lg-7">
                        <ul class="w-menu list-unstyled">
                            <li>
                                <a href="#"><span class="w-menu-on">商城</span></a>
                                <dl>
                                    <dd class="current"><a href="#">首页</a></dd>
                                    <dd>
                                        <a href="#">设计师</a>
                                        <div class="mem_dow">

                                            <a class="active" href="#">灯具</a>
                                            <a href="#">户外用品</a>
                                            <a href="#">慢教由問的行本</a>
                                            <a href="#">創臺文的統苦</a>
                                            <a href="#">那式根</a>
                                            <a href="#">二度</a>
                                            <a href="#">傳已經的然</a>
                                        </div>
                                    </dd>
                                    <dd><a href="#">男装</a></dd>
                                    <dd><a href="#">女装</a></dd>
                                    <dd><a href="weekly.html">每周主打</a></dd>
                                    <dd><a href="#">超值优惠</a></dd>
                                    <dd><a href="#">所有产品</a></dd>
                                </dl>
                            </li>
                            <li>
                                <a href="list.html"><span>文化资讯</span></a>
                            </li>
                            <li>
                                <a href="#"><span>设计师</span></a>
                            </li>
                            <li>
                                <a href="#"><span>关于我们</span></a>
                            </li>
                            <li>
                                <a href="#"><span>线下店铺</span></a>
                            </li>
                        </ul><!--w-menu list-unstyled-->
                    </div><!--col-md-6 col-lg-7-->
                    <div class="col-md-4 col-lg-3" style="padding-bottom: 50px;">
                        <ul class="w-menu-right list-unstyled">
                            <li>
                                <a href="javascript:void(0)"><span class="w-gwc">购物车 (0)</span></a>
                            </li>
                            <li>
                                <a href="javascript:void(0)"><span class="w-menu-lr">登录/</span><span class="w-menu-lrzc">注册</span></a>

                            </li>
                            <li>
                                <a href="#"><span class="w-search">搜索</span></a>
                            </li>
                        </ul><!--w-menu-right list-unstyled-->
                    </div><!--col-md-4 col-lg-3-->
                </div>
                <div class="row visible-sm-block visible-xs-block w-menusm">
                    <div class="col-xs-4 col-sm-3 text-left">
                        <a href="javascript:void(0)"><i class="fa fa-bars"></i></a>
                    </div><!--col-xs-4 col-sm-3 text-left-->
                    <div class="col-xs-4 col-sm-6 w-logo text-center">
                        <a href="#">四方街</a>
                    </div><!--col-xs-4 col-sm-6 w-logo text-center-->
                    <!-- 2015-10-28 宣扬修改 -->
                    <div class="col-xs-4 col-sm-3 text-right w-gwct" style="padding-bottom: 0px;">
                        <a href="javascript:void(0)"><span class="w-gwc">购物车 (0)</span></a>
                    </div><!--col-xs-4 col-sm-3 text-right w-gwct-->

                </div><!--row visible-sm-block visible-xs-block w-menusm-->

            </div><!--container-->
            <div class="w-menush visible-sm-block visible-xs-block">
                <ul class="w-menush-items list-unstyled">
                    <li>
                        <a href="#"><span class="w-menu-on">商城</span></a>
                        <dl>
                            <dd class="current"><a href="#">首页</a></dd>
                            <dd>
                                <a href="#">设计师</a>
                                <div class="mem_dow">

                                    <a class="active" href="#">灯具</a>
                                    <a href="#">户外用品</a>
                                    <a href="#">慢教由問的行本</a>
                                    <a href="#">創臺文的統苦</a>
                                    <a href="#">那式根</a>
                                    <a href="#">二度</a>
                                    <a href="#">傳已經的然</a>
                                </div>
                            </dd>
                            <dd><a href="#">男装</a></dd>
                            <dd><a href="#">女装</a></dd>
                            <dd><a href="weekly.html">每周主打</a></dd>
                            <dd><a href="#">超值优惠</a></dd>
                            <dd><a href="#">所有产品</a></dd>
                        </dl>
                    </li>
                    <li>
                        <a href="list.html"><span>文化资讯</span></a>
                    </li>
                    <li>
                        <a href="#"><span>设计师</span></a>
                    </li>
                    <li>
                        <a href="#"><span>关于我们</span></a>
                    </li>
                    <li>
                        <a href="#"><span>线下店铺</span></a>
                    </li>
                    <li>
                        <a href="javascript:void(0)"><span class="w-menu-lr">登录/</span><span class="w-menu-lrzc">注册</span></a>
                    </li>
                    <li>
                        <a href="#"><span>搜索</span></a>
                    </li>
                </ul><!--w-menush-items list-unstyled-->
            </div><!--w-menush visible-sm-block visible-xs-block-->
        </div><!--nav2-bg--><!--2015-9 和其他一级页面不同的地方-->
    </div><!--w-nav navbar-fixed-top index-nav-->
    <!--end of 导航-->
    <!--主体内容开始-->
    <div class="w-shooping-list">
        <div class="w-shooping-list-sort" id="sticky">
            <ul class="row">
                <li>
                    <div class="sort-tit">排序方式<i class="fa fa-caret-down"></i></div>
                    <p><a class="active">默认</a></p>
                    <p><a href="#">最新上架</a></p>
                    <p><a href="#">价格由低到高</a></p>
                    <p><a href="#">价格由高到低</a></p>
                </li>
                <li>
                    <p><a class="active">所有产品</a></p>
                    <p><a href="#"><i class="fa fa-venus"></i>女性</a></p>
                    <p><a href="#"><i class="fa fa-mars"></i>男性</a></p>
                </li>
                <li>
                    <p><b>服装</b></p>
                    <p><a href="#">外套</a></p>
                    <p><a href="#">上衣</a></p>
                    <p><a href="#">裙子</a></p>
                    <p><a href="#">裤子</a></p>
                </li>
                <li>
                    <p><b>鞋品</b></p>
                    <p><a href="#">平底鞋/芭蕾鞋</a></p>
                    <p><a href="#">凉鞋/拖鞋</a></p>
                    <p><a href="#">靴子/雨鞋</a></p>
                    <p><a href="#">高跟鞋</a></p>
                    <p><a href="#">商务鞋</a></p>
                    <p><a href="#">休闲鞋</a></p>
                    <p><a href="#">运动鞋</a></p>
                </li>
                <li>
                    <p><b>配件</b></p>
                    <p><a href="#">眼镜</a></p>
                    <p><a href="#">配饰</a></p>
                    <p><a href="#">帽子</a></p>
                    <p><a href="#">手表</a></p>
                    <p><a href="#">围巾</a></p>
                    <p><a href="#">包箱</a></p>
                </li>
            </ul>
            <div class="sort-btn active">
                <i class="fa fa-chevron-left"></i>
                <p>分<br>类<br>筛<br>选</p>
            </div>
        </div><!--w-shooping-list-sort-->
        <div class="w-shooping-list-box">
            <div class="w-designer-deta">
                <div class="designer-deta-img"><img src="http://www.sifangstreet.com/media/other/151009/no.jpg" width="100%"></div>
                <dl>
                    <dt><img src="http://www.sifangstreet.com/media/other/150915/necessary-objects.jpg" width="146" height="146"></dt>
                    <dd>
                        <h2>庄世谦&梁锦桢</h2>
                        <time><em>Blind by JW</em></time>
                        <p>理一石那久不前全然，各專世會是華能都方音。親小很年化過是期叫手身就運己，驗選拉完：嗎少內兒，灣似構失己品單、我理國大引我多，為象正友、正格臺國依們到立木果車！間形臺德相得們候又運山開巴化邊共非過心出人聲時當界，人面之的公大強！也門的維例居感力正在去係兒已受故戰請取話重選以議麼修沒道算球？地黃定特出為城海第</p>
                        <p class="last"><a href="#"><i class="fa fa-caret-left"></i>点击查看更详细的设计师讯息</a></p>
                    </dd>
                </dl>
            </div>
            <div class="product_box">
                <ul class="product list-unstyled col4" id="pinterestList" style="transition: height 1s; height: 1633px;">
                    <li style="display: block; left: 36px; top: 36px;">
                        <div class="li1">
                            <a href="/product/1455.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/14/55/sku.jpg" width="100%">
                                <iframe id="tmp_downloadhelper_iframe" style="display: none;"></iframe>
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1455.html">
                                    A型外套
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥1,299.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092211">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:35" style="display:none">
                                        <a id="color_Kleinblue" class="imageSku" href="#">
                                            <span>宝蓝色</span>
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>

                            <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">

                            <span class="cart_close">
                                关闭
                            </span>
                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1455" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092211',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092211">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1455)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 309.5px; top: 36px;">
                        <div class="li1">
                            <a href="/product/1454.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/14/54/sku.jpg" width="100%">
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1454.html">
                                    锥形九分裤
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥1,199.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092210">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:2" style="display:none">
                                        <a id="color_black" class="imageSku" href="#">
                                            <span>黑色</span>
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>
                            <form id="myform" method="POST" action="#">
                                <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
                            </form>
                            <span class="cart_close">
                                关闭
                            </span>
                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1454" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092210',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092210">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1454)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 583px; top: 36px;">
                        <div class="li1">
                            <a href="/product/1453.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/14/53/sku.jpg" width="100%">
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1453.html">
                                    提花衬衣
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥899.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092209">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:21" style="display:none">
                                        <a id="color_gold" class="imageSku" href="#">
                                            <span>金色</span>
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>
                            <form id="myform" method="POST" action="#">
                                <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
                            </form>
                            <span class="cart_close">
                                关闭
                            </span>
                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1453" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092209',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092209">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1453)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 856.5px; top: 36px;">
                        <div class="li1">
                            <a href="/product/1452.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/14/52/sku.jpg" width="100%">
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1452.html">
                                    童装数字10卫衣
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥399.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092208">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:35" style="display:none">
                                        <a id="color_Kleinblue" class="imageSku" href="#">
                                            <span>宝蓝色</span>
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>
                            <form id="myform" method="POST" action="#">
                                <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
                            </form>
                            <span class="cart_close">
                                关闭
                            </span>
                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1452" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092208',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092208">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1452)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 36px; top: 562px;">
                        <div class="li1">
                            <a href="/product/1451.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/14/51/sku.jpg" width="100%">
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1451.html">
                                    数字10卫衣
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥699.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092207">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:35" style="display:none">
                                        <a id="color_Kleinblue" class="imageSku" href="#">
                                            <span>宝蓝色</span>
                                            <!--  background: url(








                                                http://www.sifangstreet.com//media/product/a/00/14/51/sku_6074429526598439353.jpg









                                            ) center no-repeat; -->
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>
                            <form id="myform" method="POST" action="#">
                                <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
                            </form>
                            <span class="cart_close">
                                关闭
                            </span>



































                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1451" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092207',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>






                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092207">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1451)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 309.5px; top: 562px;">
                        <div class="li1">
                            <a href="/product/1450.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/14/50/sku.jpg" width="100%">
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1450.html">
                                    棒球衫
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥999.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092206">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:2" style="display:none">
                                        <a id="color_black" class="imageSku" href="#">
                                            <span>黑色</span>
                                            <!--  background: url(








                                                http://www.sifangstreet.com//media/product/a/00/14/49/sku_5292033419697197733.jpg









                                            ) center no-repeat; -->
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>
                            <form id="myform" method="POST" action="#">
                                <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
                            </form>
                            <span class="cart_close">
                                关闭
                            </span>



































                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1450" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092206',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>






                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092206">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1450)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 583px; top: 562px;">
                        <div class="li1">
                            <a href="/product/1449.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/14/49/sku.jpg" width="100%">
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1449.html">
                                    童装棒球衫
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥599.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092205">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:2" style="display:none">
                                        <a id="color_black" class="imageSku" href="#">
                                            <span>黑色</span>
                                            <!--  background: url(








                                                http://www.sifangstreet.com//media/product/a/00/14/49/sku_5292033419697197733.jpg









                                            ) center no-repeat; -->
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>
                            <form id="myform" method="POST" action="#">
                                <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
                            </form>
                            <span class="cart_close">
                                关闭
                            </span>



































                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1449" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092205',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>






                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092205">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1449)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 856.5px; top: 562px;">
                        <div class="li1">
                            <a href="/product/1447.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/14/47/sku.jpg" width="100%">
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1447.html">
                                    假两件套头衫
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥699.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092203">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:62" style="display:none">
                                        <a id="color_heibai" class="imageSku" href="#">
                                            <span>黑白</span>
                                            <!--  background: url(








                                                http://www.sifangstreet.com//media/product/a/00/14/47/sku_8875957781700980847.jpg









                                            ) center no-repeat; -->
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>
                            <form id="myform" method="POST" action="#">
                                <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
                            </form>
                            <span class="cart_close">
                                关闭
                            </span>



































                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1447" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092203',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>






                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092203">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1447)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 36px; top: 1088px;">
                        <div class="li1">
                            <a href="/product/1446.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/14/46/sku.jpg" width="100%">
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1446.html">
                                    A型衬衣
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥899.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092202-1">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:17" style="display:none">
                                        <a id="color_white" class="imageSku" href="#">
                                            <span>白色</span>
                                            <!--  background: url(








                                                http://www.sifangstreet.com//media/product/a/00/14/46/sku_8231269363202647464.jpg









                                            ) center no-repeat; -->
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>
                            <form id="myform" method="POST" action="#">
                                <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
                            </form>
                            <span class="cart_close">
                                关闭
                            </span>



































                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1446" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092202-1',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>






                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092202-1">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1446)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 309.5px; top: 1088px;">
                        <div class="li1">
                            <a href="/product/1445.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/14/45/sku.jpg" width="100%">
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1445.html">
                                    九分裤
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥999.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092201">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:36" style="display:none">
                                        <a id="color_darkblue" class="imageSku" href="#">
                                            <span>深蓝色</span>
                                            <!--  background: url(








                                                http://www.sifangstreet.com//media/product/a/00/14/45/sku_5352796240928043052.jpg









                                            ) center no-repeat; -->
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>
                            <form id="myform" method="POST" action="#">
                                <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
                            </form>
                            <span class="cart_close">
                                关闭
                            </span>



































                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1445" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092201',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>






                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092201">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1445)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 583px; top: 1088px;">
                        <div class="li1">
                            <a href="/product/1387.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/13/87/velox-matte-gun-grey-gradient-1_8924507670618173380.jpg" width="100%">
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1387.html">
                                    Velox Collection-Matte Gun/ Grey Gradient
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            Jesper Lindquist
                        </p>
                        <p class="li4">
                            Dienastie
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥1,250.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015091614">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:12" style="display:none">
                                        <a id="color_gray" class="imageSku" href="#">
                                            <span>灰色</span>
                                            <!--  background: url(








                                                http://www.sifangstreet.com//media/product/a/00/13/86/stealth-matte-gold-grey-gradient-1_5632820722473383575.jpg









                                            ) center no-repeat; -->
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <form id="myform" method="POST" action="#">
                                <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
                            </form>
                            <span class="cart_close">
                                关闭
                            </span>



































                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1387" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015091614',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>






                        </div>
                        <input type="hidden" id="productSkuCode" value="2015091614">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1387)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 856.5px; top: 1088px;">
                        <div class="li1">
                            <a href="/product/1386.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/13/86/stealth-matte-gold-grey-gradient-1_5632820722473383575.jpg" width="100%">
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1386.html">
                                    Stealth Collection-Matte Gold / Grey Gradient
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            Jesper Lindquist
                        </p>
                        <p class="li4">
                            Dienastie
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥1,250.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015091613">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:12" style="display:none">
                                        <a id="color_gray" class="imageSku" href="#">
                                            <span>灰色</span>
                                            <!--  background: url(








                                                http://www.sifangstreet.com//media/product/a/00/13/86/stealth-matte-gold-grey-gradient-1_5632820722473383575.jpg









                                            ) center no-repeat; -->
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <form id="myform" method="POST" action="#">
                                <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
                            </form>
                            <span class="cart_close">
                                关闭
                            </span>



































                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1386" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015091613',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>






                        </div>
                        <input type="hidden" id="productSkuCode" value="2015091613">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1386)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 36px; top: 36px;">
                        <div class="li1">
                            <a href="/product/1455.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/16/09/k94g0602.jpg" width="100%">
                                <iframe id="tmp_downloadhelper_iframe" style="display: none;"></iframe>
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1455.html">
                                    A型外套
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥1,299.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092211">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:35" style="display:none">
                                        <a id="color_Kleinblue" class="imageSku" href="#">
                                            <span>宝蓝色</span>
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>

                            <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">

                            <span class="cart_close">
                                关闭
                            </span>
                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1455" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092211',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092211">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1455)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 36px; top: 36px;">
                        <div class="li1">
                            <a href="/product/1455.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/16/10/k94g0374.jpg" width="100%">
                                <iframe id="tmp_downloadhelper_iframe" style="display: none;"></iframe>
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1455.html">
                                    A型外套
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥1,299.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092211">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:35" style="display:none">
                                        <a id="color_Kleinblue" class="imageSku" href="#">
                                            <span>宝蓝色</span>
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>

                            <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">

                            <span class="cart_close">
                                关闭
                            </span>
                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1455" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092211',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092211">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1455)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 36px; top: 36px;">
                        <div class="li1">
                            <a href="/product/1455.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/16/11/b61r1320.jpg" width="100%">
                                <iframe id="tmp_downloadhelper_iframe" style="display: none;"></iframe>
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1455.html">
                                    A型外套
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥1,299.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092211">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:35" style="display:none">
                                        <a id="color_Kleinblue" class="imageSku" href="#">
                                            <span>宝蓝色</span>
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>

                            <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">

                            <span class="cart_close">
                                关闭
                            </span>
                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1455" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092211',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092211">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1455)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                    <li style="display: block; left: 36px; top: 36px;">
                        <div class="li1">
                            <a href="/product/1455.html">
                                <img class="imgo" src="http://www.sifangstreet.com//media/product/v/00/16/12/b61r1382.jpg" width="100%">
                                <iframe id="tmp_downloadhelper_iframe" style="display: none;"></iframe>
                            </a>
                        </div>
                        <div class="li2">
                            <div class="cutstr2" style="width: 274px;">
                                <a href="/product/1455.html">
                                    A型外套
                                </a>
                            </div>
                            <span class="new">
                            </span>
                        </div>
                        <p class="li3">
                            尚文余(Evan)
                        </p>
                        <p class="li4">
                            5.W
                        </p>
                        <div class="li5">
                            <span class="s1">

                                ¥1,299.00
                            </span>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092211">
                        <div class="join_box">
                            <div class="product_color">
                                <ul class="tm-clear J_TSaleProp tb-img" data-property="颜色">
                                    <li class="tb-selected" data-value="1:35" style="display:none">
                                        <a id="color_Kleinblue" class="imageSku" href="#">
                                            <span>宝蓝色</span>
                                        </a>
                                        <i>selected</i>
                                    </li>
                                </ul>
                            </div>
                            <div class="j1">尺码</div>
                            <ul class="size" data-property="衣服尺码">
                                <p>
                                </p>
                                <div class="j2">
                                    <span data-value="10:52">XS</span>
                                    <span data-value="10:53">S</span>
                                    <span data-value="10:54">M</span>
                                </div>
                                <p></p>
                            </ul>

                            <input id="quantity" type="hidden" name="quantity" value="" onkeyup="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">

                            <span class="cart_close">
                                关闭
                            </span>
                            <a href="#cart_box" class="j3 cboxElement" id="add2Cart1455" name="addToCart" onclick="if(!checkAddProductToCart())return;$cm.addToC('2015092211',fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;">加入购物车</a>
                        </div>
                        <input type="hidden" id="productSkuCode" value="2015092211">
                        <p class="li6">
                            <!-- JiaThis Button BEGIN -->

                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>

                            <!-- JiaThis Button END -->
                            <a href="javascript:" onclick="addToFavorite(1455)"><i class="fa fa-heart-o"></i> 加入收藏</a>
                            <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                        </p>
                    </li>
                </ul>

            </div><!--product_box-->
            <div class="w-page">
                <a href="#"><i class="fa fa-long-arrow-left"></i></a>
                <a href="#">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                ·······
                <a href="#"><i class="fa fa-long-arrow-right"></i></a>
            </div>
            <!--/分页-->
            <!-- 加入购物车成功 -->
            <div style="display:none">
                <div id="cart_box" class="after_addtocart">
                    <div class="w-cart-header">
                        <span><i class="fa fa-check-circle-o"></i>该产品已经成功加入您的购物车</span>
                        <hr class="aftercart_hr" />
                    </div><!--w-cart-header-->
                    <div class="w-cart-body">
                        <div class="addcart_top">
                            <div class="addcart_part">
                                <span class="addcart_part_title">购买该产品的用户还买了</span>
                                <span class="addcart_part_more"><a href="javascript:;">更多>></a></span>
                            </div><!--addcart_part-->
                            <div class="addcart_sku">
                                <ul class="sku_row">
                                    <li class="sku_list">
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="hot">HOT</span><a href="#">产品名称写在这里长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p>
                                                <b>￥ 50.00</b>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="sale">SALE</span><a href="#">产品名称写在这里长很长很长很长很长很长很</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="new">NEW</span><a href="#">产品名称写在这里长很长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><a href="#">产品名称写在这里长很长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
                                    </li>
                                </ul>
                            </div><!--addcart_sku-->
                        </div><!--addcart_top-->
                        <div class="addcart_top">
                            <div class="addcart_part">
                                <span class="addcart_part_title">购买该产品的用户还买了</span>
                                <span class="addcart_part_more"><a href="javascript:;">更多>></a></span>
                            </div><!--addcart_part-->
                            <div class="addcart_sku">
                                <ul class="sku_row">
                                    <li class="sku_list">
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="hot">HOT</span><a href="#">产品名称写在这里长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p>
                                                <b>￥ 50.00</b>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="sale">SALE</span><a href="#">产品名称写在这里长很长很长很长很长很长很</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="new">NEW</span><a href="#">产品名称写在这里长很长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><a href="#">产品名称写在这里长很长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
                                    </li>
                                </ul>
                            </div><!--addcart_sku-->
                        </div><!--addcart_top-->
                    </div><!--w-cart-body-->
                </div><!--cart_box-->
            </div>
            <!-- End 加入购物车成功 -->
        </div><!--w-shooping-list-box-->
    </div><!--w-shooping-list-->
    <!--主体内容结束-->
    <div class="w-footer">
        <div class="container">
            <div class="row">
                <div class="w-footer-con">
                    <div class="w-footer-item w-footer-links col-lg-4">
                        <span class="w-links">
                            <a href="#">关于我们 | </a>
                            <a href="#">隐私保护政策 | </a>
                            <a href="#">使用条款 | </a>
                            <a href="#">商家入驻 | </a>
                            <a href="#">友情链接 | </a>
                            <a href="#">优品联盟</a>
                        </span>
                        <!--2015-8 蔡蔡改动-->
                        <span>Copyright©2013-2014 &nbsp;SifangStreet四方街版权所有&nbsp;<a href="http://www.miibeian.gov.cn/">粤ICP备13075482号-1</a></span>

                        <!--end of 蔡蔡改动-->
                        <span class="w-aqlm">安全联盟 百度统计 <img src="img/aqlm.png" /></span>
                    </div><!--w-footer-item w-footer-links col-lg-4-->
                    <div class="w-footer-item col-lg-4">
                        <div class="w-footer-email">
                            <!--2015-8 蔡蔡改动---->
                            <input type="text" class="email_txt" required placeholder="输入邮箱地址订阅最新资讯" />
                            <input type="submit" class="email_button" value="&rarr;">
                            <!--end of 蔡蔡改动-->
                        </div>
                    </div><!--w-footer-item col-lg-4-->
                    <div class="w-footer-item w-footer-con col-lg-4">
                        <span>联系我们</span>
                        <span>邮箱：cs@sifangstreet.com 电话：4008976336 周一至周五 9:30-18:30 节假日休息</span>
                        <!--2015-8 蔡蔡改动-->
                        <span>
                            <!-- WPA Button Begin -->
                            <!--<script charset="utf-8" type="text/javascript" src="http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODAxODYxMl8yMDgwNTlfNDAwNjYxNTY3N18"></script> -->
                            <!--<a target="_blank" href ="http://webim.qiao.baidu.com//im/index?siteid=4706350&ucid=7282853"><img src="/resources/images/baidushangqiao.png"/></a>-->
                            <a target="_blank" href="http://sighttp.qq.com/authd?IDKEY=3643eac2b6614f2095191848222279f192d6d2252e5eaa52"><img border="0" src="http://wpa.qq.com/imgd?IDKEY=3643eac2b6614f2095191848222279f192d6d2252e5eaa52&pic=51" alt="欢迎咨询" title="欢迎咨询" /></a>
                            <!-- WPA Button End -->
                            <a target="_blank" href="http://weibo.com/sifangstreet" class="social_link">
                                <i class="fa fa-weibo fa-lg"></i>
                            </a>

                            <a target="_blank" href="http://www.sifangstreet.com/resources/images/weixin.jpg" class="social_link">
                                <i class="fa fa-weixin fa-lg"></i>
                            </a>
                            <a target="_blank" href="#" class="social_link">
                                <i class="fa fa-facebook fa-lg"></i>
                            </a>


                        </span>
                        <!--end of 蔡蔡改动-->
                    </div><!--w-footer-item w-footer-con col-lg-4-->
                </div><!--w-footer-con-->
            </div><!--row-->
        </div><!--container-->
    </div><!--w-footer-->
    <script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
    <script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
    <script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
    <script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
    <script src="${ctxPath}/scripts/jquery/js/pinterest.js"></script>
    <script src="${ctxPath}/scripts/jquery/js/index.js"></script>
    <script src="${ctxPath}/scripts/jquery/js/colorbox/jquery.colorbox-min.js"></script>
    <!--<style>.w-nav{height:94px;background:url(img/navbg.gif) 0 0 repeat-x}</style>-->
    <script>
        //设置背景图片
        $(".data_bg").each(function () {
            var img = $(this).attr("data-img");
            if (img != undefined)
                $(this).css({ 'background': 'url(' + img + ')' })
        });

    </script>
    <script type="text/javascript">
        var jiathis_config = {
            summary: "",
            shortUrl: true,
            hideMore: false
        }
    </script>
    <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
    <script type="text/javascript">
        $(function () {
            /*2015-10-28 宣扬修改*/
            //分类筛选初始化
            var H = $(window).height()
            $(".w-weekly-hd").height(H)
            if ($(window).width() < 992 || H < 600) {
                $(".sort-btn p").html("分类筛选")
            } else {
                $(".sort-btn p").html("分<br>类<br>筛<br>选")
            }

            //解决图片加载好 底部出现没有加载好的现象
            var imgSum = $('.imgo').length;
            var imgSum2 = 0;
            $(".imgo").load(function () {
                imgSum2++;
                console.log(imgSum2)
                if (imgSum == imgSum2)
                    w_resize();
            });
            $(window).scroll(function () {
                $(".index-nav").addClass("w-nav-s")
            })
            var MH = $(".weekly-hd-info").height()
            $(".weekly-hd-info").css("margin-top", -MH / 2 - 30)
            $(".w-weekly-recomm ul li dl dd").click(function () {
                $(".w-buy-pop").fadeIn()
                $(".w-buy-pop-mask").fadeIn()
            })
            $(".w-buy-pop i").click(function () {
                $(".w-buy-pop").fadeOut()
                $(".w-buy-pop-mask").fadeOut()
            })
            //分类展开/关闭事件
            cInit();
            //初始化分类状态
            oInit();
            //窗体改变事件
            window.onresize = function () {
                oInit();
            }
            function oInit() {
                var H = $(window).height();
                //初始化分类筛选高度
                $('.sort-btn').height($('.w-shooping-list-sort').height());
                $(".w-weekly-hd").height(H)
                if ($(window).width() < 992 || H < 600) {
                    //初始化分类筛选高度
                    $('.sort-btn').height(31);
                    //底部footer
                    $(".w-footer").css("width", "100%");
                    $(".w-footer").css("margin-left", "0px");
                    $(".sort-btn p").html("分类筛选")
                    $(".w-shooping-list-box").css({ "margin-left": "0", "width": "100%" })
                    $(".sort-btn").removeClass("active")
                    $(".sort-btn").css("margin-top", "-30px");
                } else {
                    //初始化分类筛选高度
                    $('.sort-btn').height($('.w-shooping-list-sort').height());
                    $(".sort-btn p").html("分<br>类<br>筛<br>选");
                    $(".w-shooping-list-box").css({ "margin-left": "290px", "width": $(window).width() - 290 });
                }
                if (H < 600) {
                    $(".w-shooping-list-sort ul").css({ height: "auto" })
                    //$('.sort-btn').addClass("active")
                }
            }
            //初始化分类展开/关闭事件
            function cInit() {
                var _width = $(window).width();
                if (_width > 992 && H > 600) {
                    $(".w-shooping-list-box").css({ "margin-left": "290px", "width": $(window).width() - 290 })
                }
                else {
                    $(".sort-btn").removeClass("active")
                }
                //分类筛选点击事件
                $(".sort-btn").click(function () {
                    _width = $(window).width();
                    if (_width > 992 && H > 600) {
                        if ($(this).hasClass("active")) {
                            $(this).removeClass("active")
                            $(".sort-btn i").removeClass("fa-chevron-left")
                            $(".sort-btn i").addClass("fa-chevron-right")
                            $(".w-shooping-list-box").animate({ marginLeft: "60px", "width": $(window).width() - 60 })
                            $(".w-shooping-list-sort").animate({ marginLeft: -200 })
                        } else {
                            $(this).addClass("active")
                            $(".sort-btn i").addClass("fa-chevron-left")
                            $(".sort-btn i").removeClass("fa-chevron-right")
                            $(".w-shooping-list-sort").animate({ marginLeft: 0 })
                            $(".w-shooping-list-box").animate({ marginLeft: "290px", "width": $(window).width() - 290 })
                        }
                    }
                    else {
                        if ($(this).hasClass("active")) {
                            $(".w-shooping-list-sort ul").css({ height: "0" })
                            $(this).removeClass("active")
                        } else {
                            $(".w-shooping-list-sort ul").css({ height: "auto" })
                            $(this).addClass("active")
                        }
                    }
                    w_resize();
                })
            }
        })
        /*END 2015-10-28 宣扬修改*/
    </script>
</body>

</html>