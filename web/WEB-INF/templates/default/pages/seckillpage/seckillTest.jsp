<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="keywords" content="四方街">
    <meta name="description" content="">
    <meta name="baidu-site-verification" content="3PsP8afx3G">
    <title>四方街</title>
    <link rel="icon" href="${resPath}/images/favicon.ico" type="image/x-icon">
    <link rel="shortcut icon" href="${resPath}/images/mindo.ico" type="image/x-icon">
    <link href="${resPath}/styles/head_foot.css" rel="stylesheet" type="text/css">
    <link href="${resPath}/styles/nav.css" rel="stylesheet" type="text/css">
    <link href="${resPath}/styles/main.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="${resPath}/styles/component.css" />
		<!--[if IE]>
  		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="${ctxPath}/scripts/jquery/jquery-1.8.2.min.js"></script>
     <script type="text/javascript">
	
	  var serverTime = 1430367592 * 1000;
	  $(function(){
		  var dateTime = new Date();
		  var difference = dateTime.getTime() - serverTime;
		  
		  setInterval(function(){
			$(".endtime").each(function(){
			  var obj = $(this);
			  var endTime = new Date(parseInt(obj.attr('value')) * 1000);
			  var nowTime = new Date();
			  var nMS=endTime.getTime() - nowTime.getTime() + difference;
			  var myD=Math.floor(nMS/(1000 * 60 * 60 * 24));
			  var myH=Math.floor(nMS/(1000*60*60)) % 24;
			  var myM=Math.floor(nMS/(1000*60)) % 60;
			  var myS=Math.floor(nMS/1000) % 60;
			  
			  if(myD>= 0){
				  var str = myD+"天"+myH+"小时"+myM+"分"+myS+"秒";
			  }else{
				  var str = "已结束！";	
			  }
			  obj.html(str);
			});
		  }, 100);
		  
		  
		  $(".prolist li img").each(function(){
			  var img = $(this);
			  img.hover(function(){
				  img.next().show();
			  },function(){
				  img.next().hide();
			  });
		  });
	  });
	  </script>   
  </head>
  <body>
    <header>
     <div class="mid-header" id="mid-header">
    <div class="wrap1000">
    <div class="left">
       <div class="sifang-icon">
              <div class="left">地区 |</div>
              <div class="left icon-padding"><a href="http://weibo.com/sifangstreet"><img  class="icon-small" src="images/sina.png"></a></div>
              <div class="left icon-padding_right">
                <ul>
                  <li><a href="#"><img class="icon-small" src="${resPath}/images/weixin.png"></a>
                    <ul>
                      <li><img src="images/weixin.jpg"></li>
                    </ul>
                  </li>
                </ul>
              </div>
              <div class="left"> |客服热线:400-661-5677</div>
         
       </div><!--end of sifang-icon-->
     </div><!--end of left-->
      <div class="logo"> <a href="http://www.sifangstreet.com/www.sifangstreet.com"></a> </div>
      
     
      <div class="right">
            <div class="search">
              <ul class="tabs">
              <li id="loginPromptHolder">您好, <a href="/myaccount/account.html" rel="nofollow">tyfooncai</a>&nbsp;&nbsp;(<a href="/j_acegi_logout" rel="nofollow">退出</a>)&nbsp;&nbsp;|</li>
                <li id="loginPromptHolder"><a rel="nofollow" href="http://www.sifangstreet.com/myaccount/account.html">登录</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a rel="nofollow" href="http://www.sifangstreet.com/signup.html">注册</a>&nbsp;&nbsp;|</li>
                <li id="loginPromptHolderTemplateLogout" style="display: none;"><a rel="nofollow" href="http://www.sifangstreet.com/myaccount/account.html">登录</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a rel="nofollow" href="http://www.sifangstreet.com/signup.html">注册</a>&nbsp;&nbsp;|</li>
                <li id="loginPromptHolderTemplateLogin" style="display: none;">您好, <a href="http://www.sifangstreet.com/myaccount/account.html" rel="nofollow">{0}</a>&nbsp;&nbsp;(<a href="http://www.sifangstreet.com/j_acegi_logout" rel="nofollow">退出</a>)&nbsp;&nbsp;|</li>
                <li><a rel="nofollow" href="http://www.sifangstreet.com/myaccount/account.html">我的账号</a>&nbsp;&nbsp;|</li>
                <li><a rel="nofollow" href="http://www.sifangstreet.com/myaccount/order/list.html">订单状态</a></li>
              </ul>
              <span id="minicartDivTemplate" style="display: none;">{0} 件(s)&nbsp;&nbsp;{1}</span>
              <div class="blank6"></div>
              <div class="right">
                 <span id="minicartDiv">0 件(s)&nbsp;&nbsp;￥ 0.00</span>&nbsp;&nbsp;&nbsp;<a href="http://www.sifangstreet.com/cart/shoppingcart.html" rel="nofollow">购物车</a>
              </div>
              <script type="text/javascript">
			  $mnc.refresh();
			  fillLoginPrompt();
              </script> 
            </div>
            <div class="clear"></div>
            <div class="search-input">
              <form action="http://www.sifangstreet.com/search-prod.html" method="get" id="searchForm" onsubmit="return fnCheckSearchForm(this);">
                <div class="left">
                  <input value="" style="width:142px;height:23px;" name="q" class="box-input" type="text" title="Search for" autocomplete="off">
                </div>
                <div class="right">
                  <input type="image" src="images/btn_go.gif">
                </div>
              </form>
            </div>
      </div><!--end of right-->
          <div class="clear"></div>
            <div class="blank2"></div>
     <div class="nav-search">
          <div class="nav-search-wrap">
            <ul>
              <li class=""><a href="http://www.sifangstreet.com/">首页</a> </li>
              <li class="top-mama"><a href="http://www.sifangstreet.com/new-arrivals_catalog.html">新品</a>
                <ul>
                  <li><a href="http://www.sifangstreet.com/new-arrivals/new-week_catalog.html" title="一周新品">一周新品</a></li>
                  <li><a href="http://www.sifangstreet.com/new-arrivals/new-month_catalog.html" title="一月新品">一月新品</a></li>
                  <li style="height:10px; width:188px;"></li>
                </ul>
              </li>
              <li class=""><a href="http://www.sifangstreet.com/designer/index.html">设计师</a> </li>
              <li class="top-mama"><a href="http://www.sifangstreet.com/all_catalog.html">全部鞋款</a>
                <ul>
                  <li><a href="http://www.sifangstreet.com/all/c1_catalog.html" title="平底鞋">平底鞋</a></li>
                  <li><a href="http://www.sifangstreet.com/all/danxie_catalog.html" title="单鞋">单鞋</a></li>
                  <li><a href="http://www.sifangstreet.com/all/c2_catalog.html" title="高跟鞋">高跟鞋</a></li>
                  <li><a href="http://www.sifangstreet.com/all/boots_catalog.html" title="靴子">靴子</a></li>
                  <li><a href="http://www.sifangstreet.com/all/c4_catalog.html" title="船跟/坡跟鞋">船跟/坡跟鞋</a></li>
                  <li><a href="http://www.sifangstreet.com/all/c5_catalog.html" title="凉鞋/沙滩鞋">凉鞋/沙滩鞋</a></li>
                  <li><a href="http://www.sifangstreet.com/all/c6_catalog.html" title="轻便/运动鞋">轻便/运动鞋</a></li>
                  <li style="height:10px; width:188px;"></li>
                </ul>
              </li>
              <li class=""><a href="http://www.sifangstreet.com/magazine/index.html">四方志</a> </li>
              <li class=""><a href="http://www.sifangstreet.com/customer_service/_18.html">关于四方街</a> </li>
              <li class="top-mama"><a href="http://www.sifangstreet.com/all_catalog.html">全部鞋款</a>
              
           
               
            </ul>
          </div><!--end of nav-search-wrap-->
     </div><!--end of nav-search-->
    </div><!--end of wrap1000-->
  </div><!--end of mid-header-->
    </header>
    <div class="maincontent">
      <div id="large-header" class="large-header">
                  <canvas id="demo-canvas" style="width:1358px;"></canvas>
       </div><!--large-->
    <div class="bg-s">
      <div id="tabs-s" class="tabs-s">
                  <nav>
                      <ul>
                          <li><a href="#section-1"><span>5月8日</span></a></li>
                          <li><a href="#section-2"><span>5月9日</span></a></li>
                          <li><a href="#section-3"><span>5月10日</span></a></li>
                          
                      </ul>
                  </nav>
                  <div class="content">
                      <section id="section-1">
                      <div class="count">
                       <div class="times">
                          <p id="moret2">距离<span>2015年5月8日</span>还有</p>
                          <div class="endtime" value="1431079200"></div>
                       </div><!--times-->
                      </div><!--count-->
                          <div class="mediabox">
                          
                              <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/13.png"  alt="" />
                               
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                  <div class="btn start">
                                     马上开抢
                                   </div>
                                 </a>
                                </div><!--shoe_show-->
                                
                          </div><!--mediabox-->
                          <div class="mediabox">
                               <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/Desigual1.jpg"  alt="" />
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                 <div class="btn sold">
                                    已经抢光
                                   </div>
                                 </a>
                                </div><!--shoe_show-->              
                          </div><!--mediabox-->
                          <div class="mediabox">
                              <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/20.jpg"  alt="" />
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                 <div class="btn will_start">
                                     即将开始
                                  </div>
                                 </a>
                              </div><!--shoe_show-->              
                          </div><!--mediabox-->
                          <div class="mediabox">
                               <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/200.jpg"  alt="" />
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                 <div class="btn will_start">
                                     即将开始
                                   </div>
                                 </a>
                                </div><!--shoe_show-->              
                          </div><!--mediabox-->
                          <div class="mediabox">
                          
                              <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/13.png"  alt="" />
                               
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                  <div class="btn start">
                                     马上开抢
                                   </div>
                                 </a>
                                </div><!--shoe_show-->
                                
                          </div><!--mediabox-->
                          <div class="mediabox">
                          
                              <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/13.png"  alt="" />
                               
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                  <div class="btn start">
                                     马上开抢
                                   </div>
                                 </a>
                                </div><!--shoe_show-->
                                
                          </div><!--mediabox-->
                          <div class="mediabox">
                          
                              <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/13.png"  alt="" />
                               
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                  <div class="btn start">
                                     马上开抢
                                   </div>
                                 </a>
                                </div><!--shoe_show-->
                                
                          </div><!--mediabox-->
                          <div class="mediabox">
                          
                              <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/13.png"  alt="" />
                               
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                  <div class="btn start">
                                     马上开抢
                                   </div>
                                 </a>
                                </div><!--shoe_show-->
                                
                          </div><!--mediabox-->
                          <div class="mediabox">
                               <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/Desigual1.jpg"  alt="" />
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                 <div class="btn sold">
                                    已经抢光
                                   </div>
                                 </a>
                                </div><!--shoe_show-->              
                          </div><!--mediabox-->
                          <div class="mediabox">
                               <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/Desigual1.jpg"  alt="" />
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                 <div class="btn sold">
                                    已经抢光
                                   </div>
                                 </a>
                                </div><!--shoe_show-->              
                          </div><!--mediabox-->
                          <div class="mediabox">
                               <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/Desigual1.jpg"  alt="" />
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                 <div class="btn sold">
                                    已经抢光
                                   </div>
                                 </a>
                                </div><!--shoe_show-->              
                          </div><!--mediabox-->
                          <div class="mediabox">
                               <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/Desigual1.jpg"  alt="" />
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                 <div class="btn sold">
                                    已经抢光
                                   </div>
                                 </a>
                                </div><!--shoe_show-->              
                          </div><!--mediabox-->
                          <div class="mediabox">
                               <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/200.jpg"  alt="" />
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                 <div class="btn will_start">
                                     即将开始
                                   </div>
                                 </a>
                                </div><!--shoe_show-->              
                          </div><!--mediabox-->
                          <div class="mediabox">
                               <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/200.jpg"  alt="" />
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                 <div class="btn will_start">
                                     即将开始
                                   </div>
                                 </a>
                                </div><!--shoe_show-->              
                          </div><!--mediabox-->
                          <div class="mediabox">
                               <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/200.jpg"  alt="" />
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                 <div class="btn will_start">
                                     即将开始
                                   </div>
                                 </a>
                                </div><!--shoe_show-->              
                          </div><!--mediabox-->
                          <div class="mediabox">
                               <div class="shoe_show">
                               <a href="#" title="方头钻饰珠光羊皮单鞋">
                                 <img src="images/shoe/200.jpg"  alt="" />
                                 <div class="Item_name">
                                   <p class="text_prod">方头钻饰珠光羊皮单鞋</p>
                                    <p class="text_designer">Pisisi.Kin</p>
                                   <p class="price"> 
                                     <span class="ourPrice">原价： ¥418.00</span>
                                    </p>
                                    <p class="price"> 
                                     <span class="price" title="活动价">现价： ¥326.04</span>
                                   </p>
                                 </div>
                                 <div class="btn will_start">
                                     即将开始
                                   </div>
                                 </a>
                                </div><!--shoe_show-->              
                          </div><!--mediabox-->
                      </section><!--section-1-->
                      <section id="section-2">
                          <div class="mediabox">
                              
                          </div><!--mediabox-->
                          <div class="mediabox">
                              
                          </div><!--mediabox-->
                          <div class="mediabox">
                              
                          </div><!--mediabox-->
                      </section><!--section-2-->
                      <section id="section-3">
                          <div class="mediabox">
                              
                          </div><!--mediabox-->
                          <div class="mediabox">
                              
                          </div><!--mediabox-->
                          <div class="mediabox">
                          </div>	<!--mediabox-->
                      </section><!--section-3-->
              
                  </div><!-- content -->
              </div><!-- tabs-s -->
		</div><!--bg-s-->
		<script src="js/cbpFWTabs.js"></script>
		<script>
			new CBPFWTabs( document.getElementById( 'tabs-s' ) );
		</script>
		<script src="js/rAF.js"></script>
		<script src="js/twinkle-c.js"></script>
    </div><!--end of maincontent-->
  
    <footer>
      <div class="wrap1000">
        <div align="center"><img src="images/icon_footer.png"></div>
        <div class="blank24"></div>
        <div class="f-left">
          <h4>关注我们</h4>
          <ul>
            <li><a href="http://weibo.com/sifangstreet"><img src="images/sina.png"></a></li>
            <li><img src="images/instagram.png"></li>
            <li><img src="images/line.png"></li>
            <li class="weixin">
              <a href="#"><img src="images/weixin.png"></a>
              <ul>
                <li><img src="images/weixin.jpg"></li>
              </ul>
            </li>
          </ul>
        </div>
        <div class="f-middle">
          <h4>订阅四方街每周精选</h4>
          <p>输入您的邮箱,第一时间获取更多设计师产品情报</p>
          <div class="blank8"></div>
          <div class="left"><input type="text" autocomplete="off" title="Search for" value="称呼:" class="box-input" name="q" style="width:142px;height:23px;"></div>
          <div class="left" style="margin:0 10px;"><input type="text" autocomplete="off" value="邮箱：" title="Search for" class="box-input" name="q" style="width:142px;height:23px;"></div>
          <div class="left"><input type="image" src="images/btn_form.jpg"></div>
        </div>
        <div class="f-right">
          <h4>客服帮助</h4>
          <p>客服时间:周一至周五9:00-18:30<br><span class="cu_time">节假日休息</span></p>
          <p>客服热线:400-661-5677</p>
        </div>
        <div class="blank24"></div>
        <div class="foot-content">
          <dl>
            <dt>&nbsp;&nbsp;购物指南</dt>
            <dd><a href="/customer_service/_11.html"> 使用条款</a> </dd>
            <dd><a href="/customer_service/_16.html"> 会员政策 </a></dd>
            <dd><a href="/customer_service/_8.html"> 隐私政策 </a> </dd>
          </dl>
          <dl>
            <dt>&nbsp;&nbsp;支付方式</dt>
            <dd><a href="/customer_service/_6.html"> 支付方式</a> </dd>
            <dd><a href="/customer_service/_9.html"> 礼品卡使用指南</a> </dd>
          </dl>
          <dl>
            <dt>&nbsp;&nbsp;配送方式</dt>
            <dd><a href="/customer_service/_13.html"> 配送方式</a> </dd>
          </dl>
          <dl>
            <dt>&nbsp;&nbsp;售后服务</dt>
            <dd><a href="/customer_service/_12.html"> 售后服务</a> </dd>
          </dl>
          <dl>
            <dt>&nbsp;&nbsp;我的账户</dt>
            <dd><a href="/customer_service/_22.html"> 新用户注册</a></dd>
            <dd><a href="/customer_service/_21.html"> 购物流程</a></dd>
          </dl>
          <dl>
            <dt>&nbsp;&nbsp;关于我们</dt>
            <dd><a href="/customer_service/_18.html"> 关于四方街</a> </dd>
            <dd><a href="/customer_service/_27.html"> 联系我们</a></dd>
            <dd><a href="/customer_service/_19.html"> 加入我们</a></dd>
          </dl>
        </div>
        <div class="footbottom">
          <p><a href="/customer_service/_11.html">服务条款</a> | <a href="/customer_service/_8.html">隐私政策</a> | <a href="/customer_service/_25.html">商务合作</a> | <a href="">友情链接</a> </p>
          <p>Copyright©2013-2014 SifangStreet四方街版权所有        粤ICP备13075482号</p>
          <p>广州市越秀区东风东路753号天誉大厦东塔3104</p>
          <a href="http://www.anquan.org/s/www.sifangstreet.com" name="bIe7hLFwEsIGD6e0PKwvzqD2yXwpSzfTo6hyXQFEOOuySFBo9P">安全联盟、百度</a>
          <script type="text/javascript">
            var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
            document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fd57cf7b7a0ce6b40fb14c72cbbc1526a' type='text/javascript'%3E%3C/script%3E"));
          </script><script src=" http://hm.baidu.com/h.js?d57cf7b7a0ce6b40fb14c72cbbc1526a" type="text/javascript"></script>    
        </div>
      </div>
    </footer>
    <!--end of footer-->
    

  </body>
</html>
