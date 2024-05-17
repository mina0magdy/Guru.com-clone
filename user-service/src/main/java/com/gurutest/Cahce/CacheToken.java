package com.gurutest.Cahce;

import org.springframework.data.annotation.Id;
//import org.springframework.data.redis.core.RedisHash;

import java.io.Serializable;

//@RedisHash(value = "Token")
public class CacheToken implements Serializable {
    private static final long serialversionUID = 7239861379843769768l;
    @Id
    private String token;
    //    @TimeToLive
//    private Long ttl = 18000l;
    private String userId;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}
