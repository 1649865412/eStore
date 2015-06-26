package com.cartmatic.estoresf.customer.model;

import java.io.Serializable;

/**
 * Vo for password reset form in the front page. or modify password
 * @author chenshangxuan
 * CreateTime:2006-09-01
 * @version 1.0
 */
public class PasswordModel implements Serializable{
    
    private Integer appuserId;
  
    private String password="";
    private String repassword="";
    private String email="";
    private String url="";
    
    public Integer getAppuserId() {
        return appuserId;
    }
    
    public void setAppuserId(Integer in_appuserId) {
        this.appuserId = in_appuserId;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String in_email) {
        this.email = in_email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String in_password) {
        this.password = in_password;
    }
    public String getRepassword() {
        return repassword;
    }
    public void setRepassword(String in_repassword) {
        this.repassword = in_repassword;
    }
    public String getUrl() {
        return url;
    }
    public void setUrl(String in_url) {
        this.url = in_url;
    }
    
}
