//
//  Commonfig.h
//  ZuTing
//
//  Created by 潘欣 on 16/7/13.
//  Copyright © 2016年 PEN. All rights reserved.
//

#define Commonfig_h





/***************************************************************************************/

#define MyAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define SETTINGSHAKE @"SHAKE"
#define SETTINGSOUND @"SOUND"


#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

//老师绿 RGBACOLOR(97, 191, 140, 1)
#define TEACHER_GREEN      [UIColor colorWithRed:97.0/255.0 green:191.0/255.0 blue:140.0/255.0 alpha:1]
//深灰色
#define DeepGrayColor [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.00f]
//灰色
#define GrayColor  [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]
#define GrayMoreColor  [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f]
//绿色
#define TeacherColor [UIColor colorWithRed:0.40f green:0.80f blue:0.60f alpha:1.00f]
//进度条红色
#define Color_RedCustom [UIColor colorWithRed:0.97f green:0.30f blue:0.19f alpha:1.00f]
//淡灰色
#define TingeGrayColor  [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.00f]

#define CUSTOMCOLOR         [UIColor colorWithRed:213/255.0 green:143/255.0 blue:03/255.0 alpha:1]
#define CUSTOMREDCOLOR      [UIColor colorWithRed:235/255.0 green:44/255.0 blue:45/255.0 alpha:1]

//孔裔国际公学 主色调 深蓝色
#define COLOR_MAIN [UIColor colorWithRed:0.00f green:0.13f blue:0.29f alpha:1.00f]


#define IsIOS7              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IsIOS8              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IsIOS9              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)


#define KUUID @"uuid"


//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#define ImageNamed(_pointer)   [UIImage imageNamed:_pointer]


//返回结果
#define RESULT @"result"
#define RESULTCODE @"resultCode"
#define RESULTMSG @"resultMsg"

//隐藏右按钮
#define RightHidden self.navigationItem.rightBarButtonItem.customView.hidden

////////////////////////////回调
//信鸽  h5推送id  key
#define XGPUSHKEY @"XGPUSHKEY"
//注册信鸽 回调id
#define RegisterXGCBID @"RegisterXGCBID"

//IM  h5推送id  key
#define IMPUSHKEY @"IMPUSHKEY"

//融云 IMLib 相关
#define ReceiveMessage  @"ReceiveMessage"//添加消息接受回调
#define IMConnectionStatus @"IMConnectionStatus"//添加连接状态变化的监听器

//支付宝 回调 ID
#define AliPayCBID @"AliPayCBID"

//微信回调
#define Wechatid @"wechatguizongCBID"


/**  友盟 */
#define UMENGSDKKEY @"57bfec0ce0f55a7eff0033df"
//wx
#define WXUM_ID   @"wx14208a0019f53212"
#define WXUM_KEY  @"6a59ef5df537264847000e1e96f7a16a"
//qq
#define QQUM_ID   @"1105580761"
#define QQUM_KEY  @"HGiEX2ZJSVGLfyds"

//iOS: App ID: 1105580761 AppKey: HGiEX2ZJSVGLfyds
//
//AppID: wx14208a0019f53212
//AppSecret: 6a59ef5df537264847000e1e96f7a16a


#define CopyLink @"CopyLink"//复制链接
#define CreateBarcode @"CreateBarcode"//创建二维码

#define CancelShare @"CancelShare"//取消 分享

#define CustomShareBtnTag 100



#define UPLOADINFO  @"uploadInfo"//请求 老师 端 请求加的
#define COMMONAPI   @"commonApi"//请求 公共 端 请求加的


#define SERVER @"server"//新的api 请求时需要传的

#define MD5KEY    @"md5key"//
#define HTTPTOKEN @"token"//
#define LOGINOUT_CODE  @"6"  //当resultCode以6开头时说明 token过期  应该推到登录界面
/***************************************************************************************/
#define TabbarHeight 49
#define NavHeight 64
#define FFHeight 44


#define PXW(w)  ((w)*(ScreenSizeWidth/1080.0))
#define PXH(h)  ((h)*(ScreenSizeHeight/1920.0))


#define IsIOS7              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define ISIOS8              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


#define   BACKBTNFRAME      (ScreenSizeHeight<667 ? CGRectMake(0, 0, 10, 18):CGRectMake(0, 0, 14, 24))

#define ScreenSizeWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenSizeHeight    ([UIScreen mainScreen].bounds.size.height)

#define ProductName         [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]

#define Version             [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

#define ShortVersion        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/***************************************************************************************/
#define APISECRETKEY        @"apihaoxizo3i4ard33so9"

#define g_App               ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define NSValueToString(a)  (([[NSString stringWithFormat:@"%@",a] isEqualToString:@"<null>"])||([[NSString stringWithFormat:@"%@",a] isEqualToString:@"(null)"]))?@"":[NSString stringWithFormat:@"%@",a]

#define CENTERHOME @"PATHMENU"

#define RONGNEWMESALERT @"RONGNEWMESALERT"

//通知
/***************************************************************************************/


#define CloseWebAPP @"CloseWebAPP"//H5+关闭app



/***************************************************************************************/




#define REDPOINT @"GETNEWREDPOINT"
#ifndef __OPTIMIZE__


//#ifdef DEBUG
//#define NSLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt"\n\n"), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#else
//#define NSLog( s, ... )
//#endif

#define NSLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt"\n\n"), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define NSLog(...) {}

#endif
