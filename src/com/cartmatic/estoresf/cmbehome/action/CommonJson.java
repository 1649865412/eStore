package com.cartmatic.estoresf.cmbehome.action;

import java.io.Serializable;

import com.google.gson.Gson;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

public class CommonJson<T> implements Serializable {

    private static final long serialVersionUID = -3440061414071692254L;
    /**
     * ���
     */
    private T Data;

 
    public T getData() {
		return Data;
	}

	public void setData(T data) {
		Data = data;
	}

	@SuppressWarnings("rawtypes")
	public static CommonJson fromJson(String json, Class clazz) {
        Gson gson = new Gson();
        Type objectType = type(CommonJson.class, clazz);
        return gson.fromJson(json, objectType);
    }
	
	@SuppressWarnings("rawtypes")
	public static Object dataFromJson(String json, Class clazz) {
        Gson gson = new Gson();
        Type objectType = type(CommonJson.class, clazz);
        CommonJson cj = gson.fromJson(json, objectType);
        if(cj!= null){
        	return cj.getData();
        }
        return null;
    }
 
    public String toJson(Class<T> clazz) {
        Gson gson = new Gson();
        Type objectType = type(CommonJson.class, clazz);
        return gson.toJson(this, objectType);
    }

    @SuppressWarnings("rawtypes")
	static ParameterizedType type(final Class raw, final Type... args) {
        return new ParameterizedType() {
            public Type getRawType() {
                return raw;
            }
            public Type[] getActualTypeArguments() {
                return args;
            }
            public Type getOwnerType() {
                return null;
            }
        };
    }
}