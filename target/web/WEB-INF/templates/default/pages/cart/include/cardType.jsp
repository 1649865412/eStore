<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<div id="cardTypDiv" style="display: none;">
	<div style="float: left;padding: 10px 0 0 20px;">
		选择支付类型：
	</div>
	<div style="float: left;padding: 10px 0 0 20px;width: 88px;height: 28px;">
		<input type="radio" name="cardTyp" value="1" checked="checked"/>
		<label style="font-size: large">储蓄卡</label>
	</div>
	<div style="float: left;padding: 10px 0 0 20px;width: 88px;height: 28px;">
		<input type="radio" name="cardTyp" value="2"/>
		<label style="font-size: large">信用卡</label>
	</div>
	<div style="float: left;padding: 10px 0 0 20px;width: 88px;height: 28px;">
		<input type="radio" name="cardTyp" value="3"/>
		<label style="font-size: large">网银</label>
	</div>
	<br/><br/>
	<div style="float: right;padding: 0 10px 10px 0;"  >
		<input id="sureCardTyp" type="button" class="box-btn" value="  确定  "  onclick="showPay()" style="height: 30px;"/>
	</div>
</div>

