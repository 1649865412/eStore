<%@ page contentType="text/html; charset=UTF-8"%>
<html>
	<head>	
		<title>我的订单</title>	
		<script type="text/javascript">
		function changeOrderFilter() {
			if ($("#orderFilter").val() == "special") {
				$("#inputOrderNo").show();
			} else {
				$("#inputOrderNo").hide();
			}
		}
		changeOrderFilter();
		function doQuery() {
			var filter = $("#orderFilter").val();
			var orderNo = $("#orderNo").val();
			if (filter == "special" && orderNo == "") {
				alert("Input a special order No please.");
				$("#orderNo").focus();
				return;
			}
			if (filter == "") {
				alert("Please select a order filter.");
				return;
			}
			window.location = __ctxPath + "/myaccount/order/list.html?orderFilter=" + filter + "&orderNo=" + orderNo;
		}
		</script>	
	</head>
	<body>
    <h5><strong>欢迎来到四方街--我的订单功能</strong></h5>
    </body>     
</html>

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
                        <select name="orderFilter" id="orderFilter">
                          <option selected="selected" value="">
                              -选择你要查询的订单范围-
                          </option>
                          <option value="default"  <c:if test="${param.orderFilter=='default'}">selected</c:if>>
                                                                             最近的订单
                          </option>
                          <option value="months-6"  <c:if test="${param.orderFilter=='months-6'}">selected</c:if>>
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
                    <input name="orderNo" id="cq" type="text" class="box-input" value="" placeholder="输入要查询订单号">
                     <button name="login" onClick="return doQuery();" class="btn btn-black" type="submit">
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
                 <tr>
                    <td><a href="myaccount_detail.html">0141980019</a></td>
                    <td>2014/07/17 10:36:25</td>
                    <td><span class="cancel"><i class="fa fa-ban padding_right5"></i>已取消</span></td>
                    <td><span class="cancel"><i class="fa fa-times-circle-o padding_right5"></i>未支付</span></td>			
                    <td></td>
                 </tr>
                 <tr>
                    <td><a href="myaccount_detail.html">0141980019</a></td>
                    <td>2014/07/17 10:36:25</td>
                    <td>
                      <span class="processing">
                        <i class="fa fa-paper-plane-o padding_right5"></i>处理中
                      </span>
                    </td>
                    <td>
                      <span class="processing">
                        <i class="fa fa-adjust padding_right5"></i>部分支付
                      </span>
                    </td>			
                    <td> 
                      <button name="pay" class="btn_small btn-gold" type="button">
                          <i class="fa fa-credit-card padding_right10"></i>
                          支付
                      </button>
                      <button name="cancel" class="btn_small btn-black" type="button">
                          <i class="fa fa-times padding_right10"></i>
                          取消
                      </button>
                    </td>
                 </tr>
                  <tr>
                    <td><a href="myaccount_detail.html">0141980002</a></td>
                    <td>2014/06/30 10:36:25</td>
                    <td><span class="processing"><i class="fa fa-paper-plane-o padding_right5"></i>处理中</span></td>
                    <td><span class="complete"><i class="fa fa-check-circle-o padding_right5"></i>已支付</span></td>			
                    <td></td>
                 </tr>
                 <tr>
                    <td><a href="myaccount_detail.html">0141980001</a></td>
                    <td>2014/05/25 10:36:25</td>
                    <td><span class="complete"><i class="fa fa-check padding_right5"></i>已完成</span></td>
                    <td><span class="complete"><i class="fa fa-check-circle-o padding_right5"></i>已支付</span></td>			
                    <td></td>
                 </tr>
               </tbody>
             </table>

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
           </div><!--down_right-->