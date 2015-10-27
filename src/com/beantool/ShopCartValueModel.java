package com.beantool;

import java.io.Serializable;
import java.math.BigDecimal;

import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.cartmatic.estore.common.model.cart.ShoppingcartItem;
import com.cartmatic.estore.core.model.BaseObject;

public class ShopCartValueModel  extends BaseObject implements Serializable
{

	public ShopCartValueModel(){
		
	};


	protected String brandName;
	
	protected String productName;
	
	protected BigDecimal price;
	
	protected Short isSaved;
	
	protected ShoppingcartItem parent;

	protected String image;
	
	protected Integer buyNowItemsCount= new Integer(0);
	
	protected java.math.BigDecimal subtotal = new BigDecimal(0);
	
	
	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public String getBrandName() {
		return brandName;
	}


	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}


	public BigDecimal getPrice() {
		return price;
	}


	public void setPrice(BigDecimal price) {
		this.price = price;
	}


	public Short getIsSaved() {
		return isSaved;
	}


	public void setIsSaved(Short isSaved) {
		this.isSaved = isSaved;
	}


	public ShoppingcartItem getParent() {
		return parent;
	}


	public void setParent(ShoppingcartItem parent) {
		this.parent = parent;
	}


	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}


	public Integer getBuyNowItemsCount() {
		return buyNowItemsCount;
	}


	public void setBuyNowItemsCount(Integer buyNowItemsCount) {
		this.buyNowItemsCount = buyNowItemsCount;
	}


	public java.math.BigDecimal getSubtotal() {
		return subtotal;
	}


	public void setSubtotal(java.math.BigDecimal subtotal) {
		this.subtotal = subtotal;
	}




	@Override
	public boolean equals(Object o) {
		// TODO Auto-generated method stub
		return false;
	}


	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.productName) 
		.append(this.brandName) 
		.append(this.price) 
		.append(this.isSaved) 
		.append(this.parent) 
		.append(this.image) 
		.append(this.buyNowItemsCount) 
		.append(this.subtotal) 
		.toHashCode();
	}


	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return new ToStringBuilder(this)
		.append("productSku", this.productName) 
		.append("brandName", this.brandName) 
		.append("price", this.price) 
		.append("isSaved", this.isSaved) 
		.append("parent", this.parent) 
		.append("image", this.image) 
		.append("buyNowItemsCount", this.buyNowItemsCount) 
		.append("subtotal", this.subtotal) 
		.toString();
	}
}
