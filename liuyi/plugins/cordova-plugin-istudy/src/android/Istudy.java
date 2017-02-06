/*
       Licensed to the Apache Software Foundation (ASF) under one
       or more contributor license agreements.  See the NOTICE file
       distributed with this work for additional information
       regarding copyright ownership.  The ASF licenses this file
       to you under the Apache License, Version 2.0 (the
       "License"); you may not use this file except in compliance
       with the License.  You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing,
       software distributed under the License is distributed on an
       "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
       KIND, either express or implied.  See the License for the
       specific language governing permissions and limitations
       under the License.
*/
package com.istudy.jsplugin;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.istudy.jsplugin.bean.CaptureDevice;
import com.istudy.jsplugin.bean.Session;
import com.istudy.jsplugin.device.DeviceUtil;
import com.istudy.jsplugin.security.MD5;
import com.istudy.jsplugin.security.RSA;
import com.istudy.jsplugin.security.SecurityConfig;
import com.istudy.jsplugin.security.SecurityUtil;
import com.istudy.jsplugin.util.Utils;

public class Istudy extends CordovaPlugin {
  public static final String TAG = "Istudy";

  /**
   * Constructor.
   */
  public Istudy() {
  }

  /**
   * Sets the context of the Command. This can then be used to do things like
   * get file paths associated with the Activity.
   *
   * @param cordova The context of the main Activity.
   * @param webView The CordovaWebView Cordova is running in.
   */
  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);
  }

  /**
   * Executes the request and returns PluginResult.
   *
   * @param action          The action to execute.
   * @param args            JSONArry of arguments for the plugin.
   * @param callbackContext The callback id used when calling back into JavaScript.
   * @return True if the action was valid, false if not.
   */
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
    if ("getHeader".equals(action)) {
      getHeader(callbackContext, args);
    } else if ("encrypt".equals(action)) {
      encrypt(callbackContext, args);
    } else if ("verify".equals(action)) {
      verify(callbackContext, args);
    } else if ("generateMd5".equals(action)) {
      generateMd5(callbackContext, args);
    } else if ("getDeviceInfo".equals(action)) {
      getDeviceInfo(callbackContext, args);
    } else {
      return false;
    }
    return true;
  }

  public void getHeader(CallbackContext callbackContext, JSONArray jsonArray) {
    String path = "";
    HashMap<String, String> headers = null;
    HashMap<String, String> params = null;
    Session session = null;
    JSONObject jsonObject = jsonArray.optJSONObject(0);
    if (jsonObject != null) {
      path = jsonObject.optString("path");
      try {
        session = Utils.string2Obj(jsonObject.optString("session"), Session.class);
      } catch (IOException e) {
        e.printStackTrace();
      }
      headers = Utils.jsonToHashMap(jsonObject.optJSONObject("headers"));
      params = Utils.jsonToHashMap(jsonObject.optJSONObject("params"));

    }
    Map<String, String> map = SecurityUtil.buildSecurityRequestHeaders(session, path, headers, params);
    callbackContext.success(Utils.hashMapTojson(map));
  }

  //Night
  public void encrypt(CallbackContext callbackContext, JSONArray jsonArray) {

    String md5String = "";
    try {
      md5String = jsonArray.getString(0);
    } catch (JSONException e) {
      e.printStackTrace();
    }
    String encryptString = RSA.androidEncrypt(md5String, SecurityConfig.RSA_PUBLIC_KEY, SecurityConfig.UTF_8);
    callbackContext.success(encryptString);
  }

  public void verify(CallbackContext callbackContext, JSONArray jsonArray) {
    String greeting = "";
    String serverSign = "";
    JSONObject jsonObject = jsonArray.optJSONObject(0);

    if (jsonObject != null) {
      greeting = jsonObject.optString("greeting");
      serverSign = jsonObject.optString("serverSign");
    }
    boolean verifyBoolean = RSA.verify(greeting, serverSign, SecurityConfig.RSA_PUBLIC_KEY, SecurityConfig.UTF_8);
    callbackContext.success(verifyBoolean ? 0 : -1);
  }

  public void generateMd5(CallbackContext callbackContext, JSONArray jsonArray) {
    String md5String = "";
    try {
      md5String = jsonArray.getString(0);
    } catch (JSONException e) {
      e.printStackTrace();
    }
    String md = MD5.sign(md5String, "", SecurityConfig.UTF_8);
    callbackContext.success(md);
  }

  public void getDeviceInfo(CallbackContext callbackContext, JSONArray jsonArray) {

    JSONObject jsonObject = new JSONObject();
    CaptureDevice captureDevice = new CaptureDevice();
    captureDevice.setDevId(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strDeviceId());
    captureDevice.setModel(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strModel());
    captureDevice.setCpu(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strCpuModel());
    captureDevice.setIp(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strIP());
    captureDevice.setIsp(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strISP());
    captureDevice.setMac(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strMac());
    captureDevice.setMobile(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strPhoneNumber());
    captureDevice.setNetwork(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strNetworkAccessMode());
    captureDevice.setMem(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strRamCapacity());
    captureDevice.setOs(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strOsVersion());
    captureDevice.setVer(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strReleaseVersion());
    captureDevice.setRes(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strResolution());
    captureDevice.setAppVer(DeviceUtil.getM_cDeviceInfo(this.webView.getContext()).getM_strAppVersion());
    try {
      jsonObject = new JSONObject(Utils.obj2String(captureDevice));
    } catch (IOException e) {
      e.printStackTrace();
    } catch (JSONException e) {
      e.printStackTrace();
    }
    callbackContext.success(jsonObject);
  }
}

