package com.zmkj.platform.common;

public class TokenLock {

    private static String token = null;
    private static String token2 = null;




    public static String getToken() {
        return token;
    }

    public static void setToken(String token) {
        TokenLock.token = token;
    }

    public static String getToken2() {
        return token2;
    }

    public static void setToken2(String token2) {
        TokenLock.token2 = token2;
    }
}
