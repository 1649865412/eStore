<%@ page language="java" contentType="text/javascript;charset=UTF-8" pageEncoding="UTF-8" %><%@
	page import="com.cartmatic.estore.common.helper.ConfigUtil"%><%@
	page import="com.cartmatic.estore.cart.CheckoutConstants"%><%@
	page import="com.cartmatic.estore.common.model.sales.Coupon"%><%@
	page import="com.cartmatic.estore.common.model.sales.GiftCertificate"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
	taglib uri="/WEB-INF/I18n.tld" prefix="i18n" %>
var HOMEPAGE="${ctxPath}/";
var defDatePattern='<i18n:msg key="date.format"/>';
var __ctxPath = "${ctxPath}";
var __resPath = "${resPath}";
var __mediaPath = "${appConfig.store.mediaUrlPath}";
var __defaultImage = "${resPath}/images/default/00.jpg";
var __defaultCurrencySymbol = "${appConfig.defaultCurrencySymbol}";
var __defDatePattern='<i18n:msg key="date.format"/>';
var __vaMsg = {
	notPass:"<i18n:msg key="validate.notPass"/>",
	required:"<i18n:msg key="validate.required"/>",
	number:"<i18n:msg key="validate.number" />",
	integer:"<i18n:msg key="validate.integer"/>",
	short:"<i18n:msg key="validate.short"/>",
	double:"<i18n:msg key="validate.double"/>",
	long:"<i18n:msg key="validate.long"/>",
	maxValue:"<i18n:msg key="validate.maxValue"/>",
	minValue:"<i18n:msg key="validate.minValue"/>",
	maxlength:"<i18n:msg key="validate.maxlength"/>",
	minlength:"<i18n:msg key="validate.minlength"/>",
	price:"<i18n:msg key="validate.price"/>",
	money:"<i18n:msg key="validate.money"/>",
	code:"<i18n:msg key="validate.code"/>",
	phone:"<i18n:msg key="validate.phone"/>",
	mobile:"<i18n:msg key="validate.mobile"/>",
	email:"<i18n:msg key="validate.email"/>",
	positiveInteger:"<i18n:msg key="validate.positiveInteger"/>",
	double4:"<i18n:msg key="validate.double4"/>",
	noHtml:"<i18n:msg key="validate.noHtml"/>",
	radio:"<i18n:msg key="validate.radio"/>",
	url:"<i18n:msg key="validate.url"/>",
	date:"<i18n:msg key="validate.date"/>",
	bill_n:"<i18n:msg key="billingAddress.system"/>",
	wrap_n:"<i18n:msg key="checkout.wrap.notDIS"/>",
	gcno_null:"<i18n:msg key="checkout.giftCertificateNoNotNull"/>"
};

var __FMT = {
	customer_account:"<i18n:msg key="customer.accountSetting"/>",
	customer_login:"<i18n:msg key="customer.login"/>",
	customer_logout:"<i18n:msg key="customer.logout"/>",
	customer_signup:"<i18n:msg key="user.signup"/>",
	customer_username_isRequired:"<i18n:msg key="customer.username.isRequired"/>",
	customer_password_isRequired:"<i18n:msg key="customer.password.isRequired"/>",
	customer_login_fail:"<i18n:msg key="customer.login.fail"/>",
	loginConfirm:"<i18n:msg key="common.loginConfirm"/>",
    minicart_addToCart:"<i18n:msg key="btn.txt.addtocart.on" />",
    minicart_addToCartSuccess:"<i18n:msg key="minicart.addToCartMessage"/>",
    minicart_unit:"<i18n:msg key="minicart.itemUnit"/>",
    minicart_id_cookie:"<%=CheckoutConstants.SHOPPINGCART_COOKIE%>",
    minicart_totalprice_cookie:"<%=CheckoutConstants.SHOPPINGCART_PRICE_COOKIE%>",
    c_itemcount_cookie:"<%=CheckoutConstants.C_ITEMCOUNT_COOKIE%>",
    f_itemcount_cookie:"<%=CheckoutConstants.F_ITEMCOUNT_COOKIE%>",
    cannotMoveToC:"<%=CheckoutConstants.CANNOTMOVE_C_NOINVENTORY%>",
    noMoreInvetory:"<%=CheckoutConstants.CANNOTMOVE_C_NOINVENTORY_NOMORE%>",
    update_stockNotEnough:"<i18n:msg key="shoppingcartItem.cannotUpdate_stockNotEnough"/>",
    update_noMoreInventory:"<i18n:msg key="shoppingcartItem.cannotUpdate_noMoreInventory"/>",
    favorite_:"<i18n:msg key="favorite"/>",
    notAnonymousF:"<i18n:msg key="shoppingcart.notAllowAnonymous"/>",
    couponNull:"<i18n:msg key="checkout.couponNoNotNull"/>",
    outOfStock:"<i18n:msg key="btn.txt.outOfStock"/>",
    continueShopping:"<i18n:msg key="shoppingcart.continue"/>",
    checkout:"<i18n:msg key="shoppingcart.checkout"/>",
    
    gc_INVALID_v:"<%=GiftCertificate.STATE_INVALID%>",
    gc_UNACTIVE_v:"<%=GiftCertificate.STATE_UNACTIVE%>",
    gc_UNDEAL_v:"<%=GiftCertificate.STATE_UNDEAL%>",
    gc_EXPIRE_v:"<%=GiftCertificate.STATE_EXPIRE%>",
    gc_NOT_ENOUGH_v:"<%=GiftCertificate.STATE_NOT_ENOUGH_REMAINEDAMT%>",
    gc_AVAILABLE_v:"<%=GiftCertificate.STATE_AVAILABLE%>",
    gc_MONEYNULL_v:"<%=GiftCertificate.STATE_REMAINEDAMT_IS_ZERO%>",
    gc_INVALID:"<i18n:msg key="giftCertificate.error.notAgiftCertificate"/>",
    gc_UNACTIVE:"<i18n:msg key="giftCertificate.error.inactive"/>",
    gc_UNDEAL:"<i18n:msg key="giftCertificate.error.onUsing"/>",
    gc_EXPIRE:"<i18n:msg key="giftCertificate.error.expire"/>",
    gc_NOT_ENOUGH:"<i18n:msg key="giftCertificate.error.noMoney"/>",
    gc_MONEYNULL:"<i18n:msg key="giftCertificate.error.moneyNull"/>",
    gc_used:"<i18n:msg key="checkout.message.giftcertificate.used"/>",
    
    checkou_conplictSorry:"<i18n:msg key="checkout.conplictSorry"/>",
    checkou_noship:"<i18n:msg key="checkout.message.noship"/>",
    checkou_bill_n:"<i18n:msg key="order.not.order"/>",
    checkou_wrap_y:"<i18n:msg key="checkout.yes.wrap"/>",
    checkou_wrap_n:"<i18n:msg key="checkout.not.wrap"/>",
    checkou_error:"<i18n:msg key="checkout.error"/>",
    button_clear:"<i18n:msg key="button.clear"/>",
    button_close:"<i18n:msg key="button.close"/>",
    button_select:"<i18n:msg key="button.select"/>",
    product_addReview_success:"<i18n:msg key="product.addReview.success"/>",
    productReview_subject_maxlength:"<i18n:msg key="productReview.subject.maxlength"/>",
    productReview_subject_required:"<i18n:msg key="productReview.subject.required"/>",
    productReview_message_maxlength:"<i18n:msg key="productReview.message.maxlength"/>",
    productReview_message_required:"<i18n:msg key="productReview.message.required"/>",
    productReview_username_required:"<i18n:msg key="productReview.username.required"/>",
    productReview_voteSuccess:"<i18n:msg key="productReview.voteSuccess"/>",
    productReview_isVoted:"<i18n:msg key="productReview.isVoted"/>",
    productReview_isSelfReview:"<i18n:msg key="productReview.isSelfReview"/>",
    first_login:"<i18n:msg key="customer.login.header"/>",
    image_btn_addtocart_on:"<i18n:msg key="image.btn.addtocart.on"/>",
    image_btn_addtocart_preOrder:"<i18n:msg key="image.btn.addtocart.preOrder"/>",
    image_btn_addtocart_backOrder:"<i18n:msg key="image.btn.addtocart.backOrder"/>",
    image_btn_addtocart_off:"<i18n:msg key="image.btn.addtocart.off"/>",
    productDetail_inventory_outof_stock:"<i18n:msg key="productDetail.inventory.outof.stock"/>",
    productDetail_inventory_outof_stock_will_ship:"<i18n:msg key="productDetail.inventory.outof.stock.will.ship"/>",
    productDetail_inventory_preOrder:"<i18n:msg key="productDetail.inventory.preOrder"/>",
    productDetail_inventory_backOrder:"<i18n:msg key="productDetail.inventory.backOrder"/>",
    productDetail_inventory_will_ship:"<i18n:msg key="productDetail.inventory.will.ship"/>",
    productDetail_wholesalePrices:"<i18n:msg key="productDetail.wholesalePrices"/>",
    addressDelete:"<i18n:msg key="address.deleteConfirm"/>",
    orderQueryTimeNull:"<i18n:msg key="account.queryTimeNull"/>",
    select:"<i18n:msg key="productRating.selectRating"/>",
    unselected:"<i18n:msg key="productDetail.attributeOption.unselected"/>",
    button_uploadFile:"<i18n:msg key="button.uploadFile"/>"
    
};
var __currency = {
	<c:forEach var="currency" items="${EnableCurrencys}" varStatus="s">
	${currency.currencyCode}:{rate:${currency.exchangeRate}, symbol:"${currency.currencySymbol}", isDefault:${currency.isDefault == null ? '0' : currency.isDefault}}<c:if test="${not s.last}">,</c:if>
	</c:forEach>
};
<%@ include file="/scripts/cartmatic/global.js"%>
<%@ include file="/scripts/cartmatic/cart/cart.js"%>
<%@ include file="/scripts/cartmatic/cart/cardTyp.js"%>