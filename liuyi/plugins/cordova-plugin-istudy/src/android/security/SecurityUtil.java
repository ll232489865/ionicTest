package com.istudy.jsplugin.security;

import android.text.TextUtils;

import com.istudy.jsplugin.bean.Session;

import org.codehaus.jackson.map.ObjectMapper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

public class SecurityUtil {

    private static ObjectMapper om = new ObjectMapper();

    public static final int ENCRYPT_MAX_SIZE = 116;

    public static final int DECRYPT_MAX_SIZE = 172;

    public static String wrapAccessToken(String accessToken, String serverGreeting) {
        StringBuilder sb = new StringBuilder();
        String data = accessToken + "&" + serverGreeting;
        List<String> splited = SecurityUtil.splitByLength(data, ENCRYPT_MAX_SIZE);
        for (String string : splited) {
            sb.append(RSA.encrypt(string, SecurityConfig.RSA_PUBLIC_KEY, SecurityConfig.UTF_8));
        }
        return sb.toString();
    }

    public static String wrapAndroidAccessToken(String accessToken, String serverGreeting) {
        StringBuilder sb = new StringBuilder();
        String data = accessToken + "&" + serverGreeting;
        List<String> splited = SecurityUtil.splitByLength(data, ENCRYPT_MAX_SIZE);
        for (String string : splited) {
            sb.append(RSA.androidEncrypt(string, SecurityConfig.RSA_PUBLIC_KEY, SecurityConfig.UTF_8));
        }
        return sb.toString();
    }

    public static List<String> splitByLength(String inputStr, int length) {
        List<String> splited = new ArrayList<String>();
        if (TextUtils.isEmpty(inputStr)) {
            return splited;
        }

        int dataLength = inputStr.length();
        int curIndex = 0;
        String segment;
        while (curIndex < dataLength) {
            int nextIndex = curIndex + length;
            if (nextIndex > dataLength) {
                segment = inputStr.substring(curIndex, dataLength);
            } else {
                segment = inputStr.substring(curIndex, nextIndex);
            }
            splited.add(segment);
            curIndex = nextIndex;
        }
        return splited;
    }

	public static String genClientPassword(String realPwd, String serverGreeting) {
	    return RSA.encrypt(MD5.sign(realPwd, "", SecurityConfig.UTF_8) + "&" + serverGreeting, SecurityConfig.RSA_PUBLIC_KEY, SecurityConfig.UTF_8);
	}

	public static String genAndroidClientPassword(String realPwd, String serverGreeting) {
        return RSA.androidEncrypt(MD5.sign(realPwd, "", SecurityConfig.UTF_8) + "&" + serverGreeting, SecurityConfig.RSA_PUBLIC_KEY, SecurityConfig.UTF_8);
    }

	public static String genSessionKey() {
		return UUID.randomUUID().toString();
	}

	public static String genClientGreeting() {
		return UUID.randomUUID().toString();
	}

	public static String genHandshakeCode(String serverGreeting, String sessionKey) {
        return RSA.encrypt(serverGreeting + "&" + sessionKey, SecurityConfig.RSA_PUBLIC_KEY, SecurityConfig.UTF_8);
    }

	public static String genAndroidHandshakeCode(String serverGreeting, String sessionKey) {
        return RSA.androidEncrypt(serverGreeting + "&" + sessionKey, SecurityConfig.RSA_PUBLIC_KEY, SecurityConfig.UTF_8);
    }

	public static boolean verifyServer(String clientGreeting, String serverGreeting, String serverSign) {
		return RSA.verify(clientGreeting + "&" + serverGreeting, serverSign,
				SecurityConfig.RSA_PUBLIC_KEY, SecurityConfig.UTF_8);
	}

	public static String genCheckSum(
    String urlPath, String key, Map<String, String> headers, Map<String, String> params, boolean includeParams) {
        List<String> headersParams = new ArrayList<String>();
        headersParams.addAll(parseHeaders(headers));
        if (params != null && includeParams) {
            headersParams.addAll(parseParams(params));
        }
        Collections.sort(headersParams);

        StringBuilder sb = new StringBuilder(urlPath);
        sb.append("&");
        for (String str : headersParams) {
            sb.append(str).append("&");
        }
        if (sb.length() >= 1) {
            sb.deleteCharAt(sb.length() - 1);
        }
        String content = sb.toString();

        return MD5.sign(content, key, SecurityConfig.UTF_8);
    }

	private static List<String> parseHeaders(Map<String, String> headers) {
        List<String> headerList = new ArrayList<String>();

        StringBuilder sb = new StringBuilder("");

        Iterator<String> headerNameIter = headers.keySet().iterator();
        while (headerNameIter.hasNext()) {
            String headerName = headerNameIter.next();
            String headerValue = headers.get(headerName);
            sb.append(headerName).append("=").append(headerValue);
            headerList.add(sb.toString());
            sb = new StringBuilder("");
        }

        return headerList;
    }

	public static Map<String, String> buildSecurityRequestHeaders(
    Session session, String path, Map<String, String> headers, Map<String, String> params) {
        Map<String, String> headersPerCall;
        if (headers == null) {
            headersPerCall = new HashMap<String, String>();
        } else {
            headersPerCall = new HashMap<String, String>(headers);
        }
        headersPerCall.put("timestamp", String.valueOf(System.currentTimeMillis()));

        if (session == null) return headersPerCall;

        // token
        String token = session.getToken();
        if (!TextUtils.isEmpty(token)) {
            headersPerCall.put("token", token);
        }

        String md5Key = session.getMd5key();
        if (TextUtils.isEmpty(md5Key)) return headersPerCall;
        // checksum
        String checksum = genCheckSum(path == null ? "" : path, md5Key, headersPerCall, params, true);
        try {
            headersPerCall.put("checksum-headers", om.writeValueAsString(headersPerCall.keySet()));
        } catch (Exception e) {
            throw new IllegalArgumentException("checksum-headers设置错误", e);
        }
        headersPerCall.put("checksum", checksum);
        headersPerCall.put("content-type", "application/x-www-form-urlencoded; charset=utf-8");
        return headersPerCall;
    }

    private static List<String> parseParams(Map<String, String> params) {
        List<String> paramList = new ArrayList<String>();

        StringBuilder sb = new StringBuilder("");

        Set<String> paramNames = params.keySet();
        if (paramNames == null || paramNames.isEmpty()) {
            return paramList;
        }
        Iterator<String> paramNamesIter = paramNames.iterator();
        while (paramNamesIter.hasNext()) {
            String paramName = paramNamesIter.next();
            String paramValue = params.get(paramName);
            sb.append(paramName).append("=").append(paramValue);
            paramList.add(sb.toString());
            sb = new StringBuilder("");
        }

        return paramList;
    }
}
