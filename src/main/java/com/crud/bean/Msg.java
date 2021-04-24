package com.crud.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {

    private boolean code;
    private String msg;
    private Map<String, Object> dataMap = new HashMap<>();

    public Msg() {

    }


    public Msg add(String key,Object value){
        dataMap.put(key, value);
        return this;
    }

    public boolean isCode() {
        return code;
    }

    public void setCode(boolean code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return dataMap;
    }

    public void setExtend(Map<String, Object> extend) {
        this.dataMap = extend;
    }
}
