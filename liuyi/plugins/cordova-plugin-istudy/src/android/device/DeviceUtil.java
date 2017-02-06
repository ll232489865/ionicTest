package com.istudy.jsplugin.device;

import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Environment;
import android.os.StatFs;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.text.format.Formatter;
import android.util.DisplayMetrics;
import android.util.Log;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.Arrays;

/**
 * Created by john on 16-2-24.
 */
public class DeviceUtil {
  private static DeviceInfo m_cDeviceInfo;

  public static DeviceInfo getM_cDeviceInfo(Context context) {

    if (m_cDeviceInfo == null) {
      TelephonyManager tm = (TelephonyManager) context.getSystemService(context.TELEPHONY_SERVICE);
      DisplayMetrics mDisplayMetrics = new DisplayMetrics();//屏幕分辨率容器
      ((Activity) context).getWindowManager().getDefaultDisplay().getMetrics(mDisplayMetrics);
      m_cDeviceInfo = new DeviceInfo();

      int densityDpi = mDisplayMetrics.densityDpi;
      int widthPixels = mDisplayMetrics.widthPixels;
      int heightPixels = mDisplayMetrics.heightPixels;
      float density = mDisplayMetrics.density;

      String deviceId = tm.getDeviceId();
      int ip = 0;
      String macAddress = "";
      WifiManager wifiMgr = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
      WifiInfo info = null == wifiMgr ? null : wifiMgr.getConnectionInfo();
      if (null != info) {
        macAddress = info.getMacAddress();
        ip = info.getIpAddress();
      }
      if (TextUtils.isEmpty(deviceId)) {
        deviceId = macAddress;
      }
      String netType = "";
      int type = tm.getNetworkType();
      switch (getCurrentNetType(context)) {
        case NETWOKR_TYPE_MOBILE:
          netType = getNetworkClass(type) + "," + getNetworkTypeName(type);
          break;
        case NETWORK_TYPE_WIFI:
          netType = DeviceInfo.NETWORK_ACCESS_MODE_WIFI;
          break;
        case NETWORK_TYPE_NONE:
          netType = DeviceInfo.NETWORK_ACCESS_MODE_INVALID;
          break;
        default:
          break;
      }

      m_cDeviceInfo.setM_strDeviceId(deviceId);
      m_cDeviceInfo.setM_strModel(Build.MODEL);
      m_cDeviceInfo.setM_strResolution(widthPixels + "*" + heightPixels + "," + densityDpi + "," + density);
      m_cDeviceInfo.setM_strCpuModel(getCpuModel());
      m_cDeviceInfo.setM_strIP(intToIp(ip));
      m_cDeviceInfo.setM_strMac(macAddress);
      m_cDeviceInfo.setM_strNetworkAccessMode(netType);
      m_cDeviceInfo.setM_strISP(tm.getNetworkOperator() + "," + tm.getNetworkOperatorName());
      m_cDeviceInfo.setM_strOsVersion(Build.FINGERPRINT);
      m_cDeviceInfo.setM_strRamCapacity(getTotalMemory(context));
      m_cDeviceInfo.setM_strReleaseVersion(Arrays.asList(getSystemVersion()).toString());
      m_cDeviceInfo.setM_strPhoneNumber(TextUtils.isEmpty(tm.getLine1Number()) ? "" : tm.getLine1Number());

      PackageManager manager = context.getPackageManager();
      try {
        PackageInfo packageInfo = manager.getPackageInfo(context.getPackageName(), 0);
        m_cDeviceInfo.setM_strAppVersion(packageInfo.versionCode + "_" + packageInfo.versionName);
      } catch (PackageManager.NameNotFoundException e) {
        e.printStackTrace();
      }
      Log.e(DeviceUtil.class.getSimpleName(), "Device Information: " + m_cDeviceInfo.toString());
    }
    return m_cDeviceInfo;
  }


  /**
   * Return general class of network type, such as "3G" or "4G". In cases
   * where classification is contentious, this method is conservative.
   *
   * @return 返回网络类型
   */
  public static String getNetworkClass(int type) {
    switch (type) {
      case TelephonyManager.NETWORK_TYPE_GPRS:
      case 16:
      case TelephonyManager.NETWORK_TYPE_EDGE:
      case TelephonyManager.NETWORK_TYPE_CDMA:
      case TelephonyManager.NETWORK_TYPE_1xRTT:
      case TelephonyManager.NETWORK_TYPE_IDEN:
        return DeviceInfo.NETWORK_ACCESS_MODE_2G;
      case TelephonyManager.NETWORK_TYPE_UMTS:
      case TelephonyManager.NETWORK_TYPE_EVDO_0:
      case TelephonyManager.NETWORK_TYPE_EVDO_A:
      case TelephonyManager.NETWORK_TYPE_HSDPA:
      case TelephonyManager.NETWORK_TYPE_HSUPA:
      case TelephonyManager.NETWORK_TYPE_HSPA:
      case TelephonyManager.NETWORK_TYPE_EVDO_B:
      case TelephonyManager.NETWORK_TYPE_EHRPD:
      case TelephonyManager.NETWORK_TYPE_HSPAP:
      case 17:
        return DeviceInfo.NETWORK_ACCESS_MODE_3G;
      case TelephonyManager.NETWORK_TYPE_LTE:
      case 18:
        return DeviceInfo.NETWORK_ACCESS_MODE_4G;
      default:
        return DeviceInfo.NETWORK_ACCESS_MODE_UNKONWN;
    }
  }

  public static String getNetworkTypeName(int type) {
    switch (type) {
      case TelephonyManager.NETWORK_TYPE_GPRS:
        return "GPRS";
      case TelephonyManager.NETWORK_TYPE_EDGE:
        return "EDGE";
      case TelephonyManager.NETWORK_TYPE_UMTS:
        return "UMTS";
      case TelephonyManager.NETWORK_TYPE_HSDPA:
        return "HSDPA";
      case TelephonyManager.NETWORK_TYPE_HSUPA:
        return "HSUPA";
      case TelephonyManager.NETWORK_TYPE_HSPA:
        return "HSPA";
      case TelephonyManager.NETWORK_TYPE_CDMA:
        return "CDMA";
      case TelephonyManager.NETWORK_TYPE_EVDO_0:
        return "CDMA - EvDo rev. 0";
      case TelephonyManager.NETWORK_TYPE_EVDO_A:
        return "CDMA - EvDo rev. A";
      case TelephonyManager.NETWORK_TYPE_EVDO_B:
        return "CDMA - EvDo rev. B";
      case TelephonyManager.NETWORK_TYPE_1xRTT:
        return "CDMA - 1xRTT";
      case TelephonyManager.NETWORK_TYPE_LTE:
        return "LTE";
      case TelephonyManager.NETWORK_TYPE_EHRPD:
        return "CDMA - eHRPD";
      case TelephonyManager.NETWORK_TYPE_IDEN:
        return "iDEN";
      case TelephonyManager.NETWORK_TYPE_HSPAP:
        return "HSPA+";
      case 16:
        return "GSM";
      case 17:
        return "TD_SCDMA";
      case 18:
        return "IWLAN";
      default:
        return "UNKNOWN";
    }
  }

  /**
   * int 转换为 ip
   *
   * @return 返回手机的ip地址
   */
  private static String intToIp(int i) {

    return (i & 0xFF) + "." +
      ((i >> 8) & 0xFF) + "." +
      ((i >> 16) & 0xFF) + "." +
      (i >> 24 & 0xFF);
  }

  /**
   * 获取手机CPU信息
   *
   * @return 返回手机CPU信息
   */
  private static String getCpuModel() {
    String strCpuModel = "";
    String cpuInfo = null;
    try {
      byte[] bs = new byte[8192];
      RandomAccessFile reader = new RandomAccessFile("/proc/cpuinfo", "r");
      reader.read(bs);
      String ret = new String(bs);
      int index = ret.indexOf(0);
      if (index != -1) {
        cpuInfo = ret.substring(0, index);
      } else {
        cpuInfo = ret;
      }
    } catch (IOException ex) {
      cpuInfo = "";
      ex.printStackTrace();
    }
    String[] items = cpuInfo.split("\\n+");
    for (String item : items) {
      if (item.contains("Hardware")) {
        int index = item.indexOf(": ");
        if (index >= 0) {
          cpuInfo = item.substring(index + 2);
        }
      }
    }
    return cpuInfo;
  }

  /**
   * 获取手机内存大小
   *
   * @return 返回手机内存大小
   */
  private static String getTotalMemory(Context context) {
    String str1 = "/proc/meminfo";// 系统内存信息文件
    String str2;
    String[] arrayOfString;
    long initial_memory = 0;
    try {
      FileReader localFileReader = new FileReader(str1);
      BufferedReader localBufferedReader = new BufferedReader(localFileReader, 8192);
      str2 = localBufferedReader.readLine();// 读取meminfo第一行，系统总内存大小

      arrayOfString = str2.split("\\s+");
      for (String num : arrayOfString) {
        Log.i(str2, num + "\t");
      }

      initial_memory = Integer.valueOf(arrayOfString[1]).intValue() * 1024;// 获得系统总内存，单位是KB，乘以1024转换为Byte
      localBufferedReader.close();

    } catch (IOException e) {
      e.printStackTrace();
    }
    return Formatter.formatFileSize(context, initial_memory);// Byte转换为KB或者MB，内存大小规格化
  }


  /**
   * 获取当前网络状态的类型
   *
   * @param mContext
   * @return 返回网络类型
   */
  public static final int NETWORK_TYPE_NONE = -0x1;  // 断网情况
  public static final int NETWORK_TYPE_WIFI = 0x1;   // WiFi模式
  public static final int NETWOKR_TYPE_MOBILE = 0x2; // gprs模式

  private static int getCurrentNetType(Context mContext) {
    ConnectivityManager connManager = (ConnectivityManager) mContext.getSystemService(Context.CONNECTIVITY_SERVICE);
    NetworkInfo wifi = connManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI); // wifi
    NetworkInfo gprs = connManager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE); // gprs

    if (wifi != null && wifi.getState() == NetworkInfo.State.CONNECTED) {
      return NETWORK_TYPE_WIFI;
    } else if (gprs != null && gprs.getState() == NetworkInfo.State.CONNECTED) {
      return NETWOKR_TYPE_MOBILE;
    }
    return NETWORK_TYPE_NONE;
  }

  /**
   * 系统的版本信息
   *
   * @param
   * @return 系统的版本信息
   */
  public static String[] getSystemVersion() {
    String[] version = {"null", "null", "null", "null"};
    String str1 = "/proc/version";
    String str2;
    String[] arrayOfString;
    try {
      FileReader localFileReader = new FileReader(str1);
      BufferedReader localBufferedReader = new BufferedReader(
        localFileReader, 8192);
      str2 = localBufferedReader.readLine();
      arrayOfString = str2.split("\\s+");
      version[0] = arrayOfString[2];//KernelVersion
      localBufferedReader.close();
    } catch (IOException e) {
    }
    version[1] = Build.VERSION.RELEASE;// firmware version
    version[2] = Build.MODEL;//model
    version[3] = Build.DISPLAY;//system version
    return version;
  }

  /**
   * sdCard大小
   *
   * @param
   * @return sdCard的大小
   */
  public static long[] getSDCardMemory() {
    long[] sdCardInfo = new long[2];
    String state = Environment.getExternalStorageState();
    if (Environment.MEDIA_MOUNTED.equals(state)) {
      File sdcardDir = Environment.getExternalStorageDirectory();
      StatFs sf = new StatFs(sdcardDir.getPath());
      long bSize = 0;
      long bCount = 0;
      long availBlocks = 0;
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
        bSize = sf.getBlockSizeLong();
        bCount = sf.getBlockCountLong();
        availBlocks = sf.getAvailableBlocksLong();
      } else {
        bSize = sf.getBlockSize();
        bCount = sf.getBlockCount();
        availBlocks = sf.getAvailableBlocks();
      }

      sdCardInfo[0] = bSize * bCount;//总大小
      sdCardInfo[1] = bSize * availBlocks;//可用大小
    }
    return sdCardInfo;
  }
}
