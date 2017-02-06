package com.istudy.jsplugin.device;

/**
 * Created by john on 16-2-24.
 */
public class DeviceInfo {
    //    设备唯一标识号：如：IMEI:867600025025841
//    设备型号：如：HUAWEI MT7-TL10
//    版本号：MT7-TL10V10R001CHNC00B133
//    处理器：cpu型号
//    内存：2G
//    分辨率：1080*1920
//    操作系统版本：android4.4.2
//    IP地址：
//    mac地址：
//    上网形式：wifi，2g，3g，4g
//    运营商：电信，移动，联通
//    电话号码：135********，135********
//    应用版本：1.3.2，35
    private String m_strDeviceId;
    private String m_strModel;
    private String m_strReleaseVersion;
    private String m_strCpuModel;
    private String m_strRamCapacity;
    private String m_strResolution;
    private String m_strOsVersion;
    private String m_strIP;
    private String m_strMac;
    private String m_strNetworkAccessMode;
    private String m_strISP;
    private String m_strPhoneNumber;
    private String m_strAppVersion;

    public String getM_strDeviceId() {
        return m_strDeviceId;
    }

    public void setM_strDeviceId(String m_strDeviceId) {
        this.m_strDeviceId = m_strDeviceId;
    }

    public String getM_strModel() {
        return m_strModel;
    }

    public void setM_strModel(String m_strModel) {
        this.m_strModel = m_strModel;
    }

    public String getM_strReleaseVersion() {
        return m_strReleaseVersion;
    }

    public void setM_strReleaseVersion(String m_strReleaseVersion) {
        this.m_strReleaseVersion = m_strReleaseVersion;
    }

    public String getM_strCpuModel() {
        return m_strCpuModel;
    }

    public void setM_strCpuModel(String m_strCpuModel) {
        this.m_strCpuModel = m_strCpuModel;
    }

    public String getM_strRamCapacity() {
        return m_strRamCapacity;
    }

    public void setM_strRamCapacity(String m_strRamCapacity) {
        this.m_strRamCapacity = m_strRamCapacity;
    }

    public String getM_strResolution() {
        return m_strResolution;
    }

    public void setM_strResolution(String m_strResolution) {
        this.m_strResolution = m_strResolution;
    }

    public String getM_strOsVersion() {
        return m_strOsVersion;
    }

    public void setM_strOsVersion(String m_strOsVersion) {
        this.m_strOsVersion = m_strOsVersion;
    }

    public String getM_strIP() {
        return m_strIP;
    }

    public void setM_strIP(String m_strIP) {
        this.m_strIP = m_strIP;
    }

    public String getM_strMac() {
        return m_strMac;
    }

    public void setM_strMac(String m_strMac) {
        this.m_strMac = m_strMac;
    }

    public String getM_strNetworkAccessMode() {
        return m_strNetworkAccessMode;
    }

    public void setM_strNetworkAccessMode(String m_strNetworkAccessMode) {
        this.m_strNetworkAccessMode = m_strNetworkAccessMode;
    }

    public String getM_strPhoneNumber() {
        return m_strPhoneNumber;
    }

    public void setM_strPhoneNumber(String m_strPhoneNumber) {
        this.m_strPhoneNumber = m_strPhoneNumber;
    }

    public String getM_strISP() {
        return m_strISP;
    }

    public void setM_strISP(String m_strISP) {
        this.m_strISP = m_strISP;
    }

    public static String NETWORK_ACCESS_MODE_WIFI = "wifi";
    public static String NETWORK_ACCESS_MODE_2G = "2g";
    public static String NETWORK_ACCESS_MODE_3G = "3g";
    public static String NETWORK_ACCESS_MODE_4G = "4g";
    public static String NETWORK_ACCESS_MODE_UNKONWN = "unknown";
    public static String NETWORK_ACCESS_MODE_INVALID = "invalid";

    public static String ISP_CHINA_MOBILE = "isp_china_mobile";
    public static String ISP_CHINA_UNICOM = "isp_china_unicom";
    public static String ISP_CHINA_TELECOM = "isp_china_telecom";
    public static String ISP_OTHER = "isp_other";

    public String getM_strAppVersion() {
        return m_strAppVersion;
    }

    public void setM_strAppVersion(String m_strAppVersion) {
        this.m_strAppVersion = m_strAppVersion;
    }

    @Override
    public String toString() {
        return "\nDeviceId = " + m_strDeviceId
                + "\nModel = " + m_strModel
                + "\nRelease Version = " + m_strReleaseVersion
                + "\nCpu Model = " + m_strCpuModel
                + "\nRam Capacity = " + m_strRamCapacity
                + "\nResolution = " + m_strResolution
                + "\nOs Version = " + m_strOsVersion
                + "\nIP Address = " + m_strIP
                + "\nMac Address = " + m_strMac
                + "\nNetwork Access Mode = " + m_strNetworkAccessMode
                + "\nInternet Service Provider = " + m_strISP
                + "\nPhone Number = " + m_strPhoneNumber
                + "\nApp Version = " + m_strAppVersion;
    }
}
