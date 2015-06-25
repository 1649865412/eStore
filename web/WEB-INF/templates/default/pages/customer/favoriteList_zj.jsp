 <%@ include file="/common/taglibs.jsp"%>
 <%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
 <%@ page contentType="text/html; charset=UTF-8"%>
<html>
	<head>
<title>我的收藏</title>
<script type="text/javascript">
		function fnRemoveFavorite(id){
			if(confirm("确定要取消该商品收藏？")){
				window.location.href=__ctxPath+"/myaccount/favorite/delete/"+id+".html"
			}
		}
</script>
    </head>
<body> 
 <div class="down_right left_border" id="tab2">
            <p class="account_info_title">
               账户：${customer.email}
               <span class="header_breadcrumb">我的收藏</span>
             </p>
             <p class="cus_id">会员级别：${membership.membershipName}</p>
            <table class="account_table" cellspacing="0" cellpadding="0">
               <thead>
                 <tr>
                    <th width="20%">
                      商品图像
                    </th>
                    <th width="35%">
                      商品名称
                    </th>
                    <th width="15%">
                      收藏时间
                    </th>
                    <th width="30%">
                      操作
                    </th>
                 </tr>
               </thead><!--thead-->
               <tbody>
              <c:forEach var="favorite" items="${favoriteList}" varStatus="s">
			<tr>
				<td>
					<product:productImg product="${favorite.product}" size="b" width="72" height="72" isLazyload="true"/>
				</td>
				<td>
					<product:productName product="${favorite.product}" />
				</td>
				<td>
					<fmt:formatDate value="${favorite.createTime}" pattern="yyyy-MM-dd" />
				</td>
				<td>
					<a href="javascript:void(0)" onclick="fnRemoveFavorite(${favorite.id});">取消收藏</a>
				</td>
			</tr>
			</c:forEach>
               <%--
                 <tr>
                    <td class="wish_img"><a href="#"><img src="images/shoe/8.png"/></a></td>
                    <td><a href="#">高跟钻饰晚宴鞋</a></td>
                    <td>2014/07/17</td>
                    <td>
                      <button name="add_cart" class="btn_small btn-gold" type="button">
                          <i class="fa fa-shopping-cart padding_right10"></i>
                          加入购物车
                      </button>
                      <button name="cancel_wish" class="btn_small btn-black" type="button">
                          <i class="fa fa-times padding_right10"></i>
                          取消收藏
                      </button>
                    </td>
                 </tr>
                 --%>
                
               </tbody>
             </table>

         <!-- 分页显示 --> 
          <div class="pagebar">
                    <ul class="pagination">
                    <li><a href="#" title="Previous"><img src="images/img_narrow_l.gif"></a></li>
                    <li style="padding-top:1px;">
                        <a href="#">1</a>
                        2
                        <a href="#">3</a> 
                        ...
                        <a href="#">7</a>
                    </li>
                    <li><a href="#" title="Next"><img src="images/img_narrow_r.gif"></a></li>
                    </ul>
             </div>
            </div>

 </body>
 </html>