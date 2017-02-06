package com.istudy.jsplugin.util;

import android.os.Environment;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by john on 16-8-18.
 */
public class Utils {
  private static ObjectMapper objectMapper = new ObjectMapper();

  /**
   * 把数据源HashMap转换成JSONObject
   *
   * @param map
   */
  public static JSONObject hashMapTojson(Map<String, String> map) {
    JSONObject JSONObject = new JSONObject();
    if (map != null) {
      for (Iterator it = map.entrySet().iterator(); it.hasNext(); ) {
        Map.Entry e = (Map.Entry) it.next();
        try {
          JSONObject.putOpt(e.getKey() + "", e.getValue() + "");
        } catch (JSONException e1) {
          e1.printStackTrace();
        }
      }
    }
    return JSONObject;
  }

  /***
   * 把JSONObject转换成map
   *
   * @param object
   */
  public static HashMap<String, String> jsonToHashMap(JSONObject object) {
    HashMap<String, String> jsonMap = new HashMap<String, String>();
    if (object != null) {
      Iterator<String> keyIter = object.keys();
      String key;
      String value;
      while (keyIter.hasNext()) {
        try {
          key = keyIter.next();
          value = object.get(key).toString();
          jsonMap.put(key, value);
        } catch (JSONException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }
      }
    }
    return jsonMap;
  }

  /***
   * 把JSONObject转换成map
   *
   * @param object
   */
  public static HashMap<String, Object> jsonToMap(JSONObject object) {
    HashMap<String, Object> jsonMap = new HashMap<String, Object>();
    if (object != null) {
      Iterator<String> keyIter = object.keys();
      String key;
      Object value;
      while (keyIter.hasNext()) {
        try {
          key = keyIter.next();
          value = object.get(key);
          jsonMap.put(key, value);
        } catch (JSONException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }
      }
    }
    return jsonMap;
  }

  public static <T> T string2Obj(String json, Class<T> t) throws IOException {
    return objectMapper.readValue(json, t);
  }

  public static String obj2String(Object t) throws IOException {
    return objectMapper.writeValueAsString(t);
  }
}
