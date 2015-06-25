<%@ include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!-- /eStore/src/com/cartmatic/estoresf/customer/web/action/OrderController.java -->

<html>
	<head>
		<title>我的订单</title>
	</head>
	<body>
	
	<script type="text/javascript">
		function changeOrderFilter() {
			if ($("#orderFilter").val() == "special") {
				$("#orderNo").show();
			} else {
				$("#orderNo").hide();
			}
		}
		changeOrderFilter();
		function doQuery() {
			var filter = $("#orderFilter").val();
			var orderNo = $("#orderNo").val();
			if (filter == "special" && orderNo == "") {
				alert("请输入订单号!");
				$("#orderNo").focus();
				return;
			}
			if (filter == "") {
				alert("请选择一个搜索条件!");
				return;
			}
			window.location = __ctxPath + "/myaccount/order/list.html?orderFilter=" + filter + "&orderNo=" + orderNo;
		}
		</script>
	
	<div class="maincontent">
         
			         <div class="position-wrap">
			            <a href="${ctxPath }/index.html">首页</a>&nbsp;&gt;&nbsp;
			            <a href="${ctxPath }/myaccount/order/list.html">我的账户</a>&nbsp;&gt;&nbsp;
			            <span class="selected">我的订单</span>
			         </div>  
			         <div class="top_about">
			         <br>
			           <div class="top_title">
			           <h1>我的账户</h1>
			           </div>
			           <ul class="tophelp">
			                <li>有任何疑问&nbsp;|</li>
			                <li>请点击在线客服&nbsp;|</li>
			                <li>或拨打400-661-5677&nbsp;|</li>
			                <li><a href="mailto:cs@sifangstreet.com">客服电子邮件地址</a>&nbsp;|</li>
			                
			                    <li><a href="#"  target="_blank" >配送信息</a>&nbsp;|</li>
			                <li>
			                    <a href="#"  target="_blank" >退换货条款</a>
			                </li>
			           </ul> 
			           <div class="blank24"></div>
			           <hr>
			         </div>
                
	                <div class="bottom_about">
	       
			           <div class="remote_nav">
			            <ul id="remote_nav_ul">
			              <li><a id="t1" href="${ctxPath}/myaccount/order/list.html" title="我的订单" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/order/')!=-1}"> class="current"</c:if>>我的订单</a></li>
			              <li><a id="t2" href="${ctxPath}/myaccount/favorites.html" title="我的收藏" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/favorites.html')!=-1}"> class="current"</c:if>>我的收藏</a></li>
			              <li><a id="t3" href="${ctxPath}/myaccount/review/list.html" title="我的评价" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/review/')!=-1}"> class="current"</c:if>>我的评价<span id="reviews_count"></span></a></li>
			              <li><a id="t4" href="${ctxPath}/myaccount/settings.html" title="个人资料" <c:if test="${fn:endsWith(OriginalRequestURL,'/myaccount/settings.html')}"> class="current"</c:if>>个人资料</a></li>
			              <li><a id="t5" href="${ctxPath}/myaccount/address.html" title="收货地址 " <c:if test="${fn:endsWith(OriginalRequestURL,'/myaccount/address.html')}"> class="current"</c:if>>收货地址</a></li>
			              <li><a id="t6" href="${ctxPath}/myaccount/shopPoint.html" title="积分" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/shopPoint.html')!=-1}"> class="current"</c:if>>积分</a></li>
			              <li><a id="t7" href="${ctxPath}/myaccount/giftCouponQuery.html" title="礼券/优惠劵" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/giftCouponQuery.html')!=-1}"> class="current"</c:if>>礼券/优惠劵</a></li>
			              <li><a id="t8" href="${ctxPath}/myaccount/giftCard.html" title="礼品卡管理" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/giftCard.html')!=-1}"> class="current"</c:if>>礼品卡</a></li>
			        
			            </ul>
			           </div><!--remote_nav-->
			           
			           <form action="${ctxPath}/myaccount/order/list.html" method="post">
			           
			           <div class="down_right left_border" id="tab1">
				             <p class="account_info_title">
				               账户：${customer.email}
				               <span class="header_breadcrumb">我的订单</span>
				             </p>
				             <p class="cus_id">会员级别：${membership.membershipName}</p>
				             <div class="order_sort">
				                    <label class="styled">显示所有订单</label>
				                <fieldset>
				                    <div class="select">
				                        <select name="orderFilter" id="orderFilter" onchange="changeOrderFilter()">
				                          <option selected="selected" value="">
				                              -选择你要查询的订单范围-
				                          </option>
				                          <option value="default"  <c:if test="${param.orderFilter=='default'}">selected</c:if>>
				                              最近的订单
				                          </option>
				                          <option value="months-6" <c:if test="${param.orderFilter=='months-6'}">selected</c:if>>
				                              6个月内的订单
				                          </option>
				                          <option value="all" <c:if test="${param.orderFilter=='all'}">selected</c:if>>
				                              所有订单
				                          </option>
				                          <option value="all_cancel" <c:if test="${param.orderFilter=='all_cancel'}">selected</c:if>>
				                              所有取消的订单
				                          </option>
				                          <option value="special" <c:if test="${param.orderFilter=='special'}">selected</c:if>>
				                              指定订单号查询
				                          </option>
				                      </select>
				                    </div>
				                    <input style="display: none;" name="orderNo" id="orderNo" type="text" class="box-input" value="" placeholder="输入要查询订单号" value="${param.orderNo}">
				                     <button name="login" class="btn btn-black" type="button" onClick="return doQuery();">
				                        <i class="fa fa-search padding_right10"></i>
				                        搜索
				                     </button>
				                    <div class="clear"></div>
				                </fieldset>
				             </div><!--order_sort-->
				             <table class="account_table" cellspacing="0" cellpadding="0">
				               <thead>
				                 <tr>
				                    <th width="20%">
				                      订单号
				                    </th>
				                    <th width="30%">
				                      日期
				                    </th>
				                    <th width="15%">
				                      订单状态
				                    </th>
				                    <th width="15%">
				                      支付状态
				                    </th>
				                    <th width="20%">
				                      操作
				                    </th>
				                 </tr>
				               </thead><!--thead-->
				               <tbody>
					               	<c:forEach var="order" items="${salesOrderList}" varStatus="s">
						                 <tr>
						                    <td><a href="${ctxPath}/myaccount/order/${order.salesOrderId}.html">${order.orderNo}</a></td>
						                    <td><fmt:formatDate value="${order.createTime}" pattern="yyyy/MM/dd HH:mm:ss" /></td>
						                    <td>
							                    <c:if test="${not empty order.orderStatus }">
													<c:choose>
														<c:when test="${order.isOnHold==1 and order.isHoldByCustomer==1}">
															 <span class="processing">
										                        <i class="fa fa-paper-plane-o padding_right5"></i>
										                        <fmt:message key="salesOrder.orderStatus.toCancel" />
										                      </span>
														</c:when>
														<c:when test="${order.paymentStatus == 10&&order.orderStatus==10}">
															<%-- The Pending is displayed on orderStatus when paymentStatus is unpaid. --%>
															 <span class="processing"><i class="fa fa-paper-plane-o padding_right5"></i>待处理</span>
														</c:when>
														<c:when test="${order.paymentStatus == 10&&order.orderStatus==80}">
										                      <span class="cancel"><i class="fa fa-ban padding_right5"></i>已取消</span>
														</c:when>
														<c:when test="${order.paymentStatus == 30&&order.orderStatus==30}">
										                      <span class="complete"><i class="fa fa-check padding_right5"></i>已完成</span>
														</c:when>
														<c:otherwise>
															 <span class="processing">
										                        <i class="fa fa-paper-plane-o padding_right5">
										                        </i><fmt:message key="salesOrder.orderStatus_${order.orderStatus}" />
										                      </span>
														</c:otherwise>
													</c:choose>
												</c:if>
						                    </td>
						                    <td>
							                    <c:if test="${not empty order.paymentStatus }">
							                      <c:choose>
														<c:when test="${order.paymentStatus == 10}">
															<%-- The Pending is displayed on orderStatus when paymentStatus is unpaid. --%>
															 <span class="cancel"><i class="fa fa-times-circle-o padding_right5"></i>未支付</span>
														</c:when>
														<c:when test="${order.paymentStatus == 20}">
										                      <span class="processing"><i class="fa fa-adjust padding_right5"></i>部分支付</span>
														</c:when>
														<c:when test="${order.paymentStatus == 30}">
										                      <span class="complete"><i class="fa fa-check-circle-o padding_right5"></i>已支付</span>
														</c:when>
														<c:otherwise>
															 <span class="cancel"><i class="fa fa-times-circle-o padding_right5"></i>未支付</span>
														</c:otherwise>
													</c:choose>
												</c:if>
						                    </td>			
						                    <td> 
						                    	<c:choose>
						                    		<c:when test="${order.isCod == 0 }">
														<c:if test="${order.orderStatus!=30 and order.orderStatus!=40 and order.orderStatus!=80 and order.paymentStatus!=30}">
															<button name="pay" class="btn_small btn-gold" type="button" onclick="window.location.href='${ctxPath}/checkout/goToPay.html?doAction=selectOnlinePayment&orderNo=${order.orderNo}'" >
										                          <i class="fa fa-credit-card padding_right10"></i>
										                          支付
										                      </button>
														</c:if>
						                    		</c:when>
						                    		<c:otherwise>
						                    			<c:if test="${order.paymentStatus!=30}">
															<button name="pay" class="btn_small btn-gold" type="button" onclick="window.location.href='${ctxPath}/checkout/goToPay.html?doAction=selectOnlinePayment&orderNo=${order.orderNo}'" >
										                          <i class="fa fa-credit-card padding_right10"></i>
										                          支付
										                      </button>
														</c:if>
						                    		</c:otherwise>
						                    	</c:choose>
												<c:if test="${order.cancelOrderPermission4Customer}">
								                  <button name="cancel" class="btn_small btn-black" type="button" onclick="cancelOrder('${order.salesOrderId}');">
							                          <i class="fa fa-times padding_right10"></i>
							                          取消
							                      </button>
												</c:if>
						                    </td>
						                 </tr>
					                 </c:forEach>																			
				               </tbody>
				             </table>
				             
				             <c:if test="${not empty salesOrderList}">
							<div class="pagebar">
							<%@ include file="/common/pagingOnlyNew.jsp"%>
							</div>
							</c:if>

				           </div><!--down_right-->
				           
				           </form>
			           
			           <form method="post" id="cancelForm" name="cancelForm" action=""  style="display: inline;">
						<input type="hidden" name="doAction" value="cancelOrder" />
						<input type="hidden" name="cancleType" value="6"/>
						</form>
						
			         </div>
                
			</div>
			
			<script>
			function cancelOrder(id){
				if(confirm('确认取消此订单？')){
					var url = __ctxPath+"/myaccount/order/"+id+".html";
					$("#cancelForm").attr("action",url);
					$("#cancelForm").submit();
				}
			}
			
			</script>
    
	</body>
</html>

