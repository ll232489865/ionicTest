package com.istudy.jsplugin.bean;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class Session implements Serializable {
    /**  */
    private static final long serialVersionUID = 6588558650750256134L;
    /**
     * 客户端服务器会话的安全校验码，为空
     */
    private String md5key;
    /**
     * 用户的UUID，非空
     */
    private String uuid;
    /**
     * 用户在外包库的userId，非空
     */
    private Integer vendorUserId;
    /**
     * 用户在istudy库中的userId，非空
     */
    private Integer userId;
    /**
     * 端来源，老师TEACHER或者学生STUDENT，非空
     */
    private Integer appSrc;
    /**
     * 登录后获取到的令牌，永久有效
     */
    private String token;
    /**
     * 用户的近期请求标示，可空
     */
    private Map<String, Long> latestRequests = new HashMap<String, Long>();
    /**
     * 同时支持的用户并发请求数，非空
     */
    private Integer requestThreshold = 10;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getMd5key() {
        return md5key;
    }

    public void setMd5key(String md5key) {
        this.md5key = md5key;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public Integer getVendorUserId() {
        return vendorUserId;
    }

    public void setVendorUserId(Integer vendorUserId) {
        this.vendorUserId = vendorUserId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getAppSrc() {
        return appSrc;
    }

    public void setAppSrc(Integer appSrc) {
        this.appSrc = appSrc;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Map<String, Long> getLatestRequests() {
        return latestRequests;
    }

    public void setLatestRequests(Map<String, Long> latestRequests) {
        this.latestRequests = latestRequests;
    }

    public Integer getRequestThreshold() {
        return requestThreshold;
    }

    public void setRequestThreshold(Integer requestThreshold) {
        this.requestThreshold = requestThreshold;
    }
}
