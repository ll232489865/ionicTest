//
//  Y_X_DataInterfance.h
//  TestNetWorkingDemo
//
//  Created by lianghuigui on 15/7/14.
//  Copyright (c) 2015年 lianghuigui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"


/** 1.URL */
#define ZuTingURL @"http://192.168.1.10:9090/zuting_api"//测试
//#define ZuTingURL @"http://api.guizong.org/zuting_api"//正式

/** 2.七牛 */
#define QiniuURLPrefix @"http://oaa4szy4p.bkt.clouddn.com"//测试
#define QiniuTMP @"http://obqiw98x7.bkt.clouddn.com"//测试tmp
//#define QiniuURLPrefix @"http://storage.guizong.org"//正式
//#define QiniuTMP @"http://tmpstorage.guizong.org"//正式 tmp


/** 3.版本号 */
#define VersionCode @"4" //每个 版本加1     4:版本是 1.2.0

/** 4.TalkingData KEY */
//#define TALKINGDATAKEY  @"5628B3ABFD69B6CD5D8B998B86CE5B0D"//正式的
#define TALKINGDATAKEY  @"E02863BA593451DEBE628D9588898474"//测试的


/** 5.融云 KEY */
//#define RONGAPPKEY @"pwe86ga5ee5d6"//正式
#define RONGAPPKEY @"ik1qhw09119jp"//测试

//////////////////////////////////////////////////////////////////////////////////////////
//是否是强制升级
#define IsMndtry @"isMndtry"

//字典 用户基本信息和融云token
#define RONGYUNTOKEN @"RONGYUNTOKEN"


/** 信鸽 */
#define XINGEAPPID @"2200217116"
#define XINGEAPPKEY @"I4545PNB6GUP"

#define PUBLICKEY          @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC0ic/H/zy8TnSZaz9Zd95/DgdPhmg9zewRvIhTAUMUhpvaBliuZYZSbo8/dLuzGsZ8/e5L++f/Qf7HQ+HA/dWwd/MWcUU/bY/Up5jTkJMzNKGV4kqDIeYFkMBYdyvX1H4wqrhVMjEHmN++DBC2i2/1IUHbn8xxq71SvzQS8P7tpQIDAQAB"
#define GETDATA @"GET"
#define POSTDATA @"POST"


#define iPhone_5_5s_SE [[UIScreen mainScreen]bounds].size.height == 568
#define iPhone_6_6s_7 [[UIScreen mainScreen]bounds].size.height == 667
#define iPhone_6p_6sp_7p [[UIScreen mainScreen]bounds].size.height == 736



//1.0  Http公共头名称
// 必须 --key
extern const NSString* YX_KEY_CLIENTVERSION;//客户端版本号
extern const NSString* YX_KEY_DEVICETYPE;
extern const NSString* YX_KEY_REQUESTTIME;
//extern const NSString* YX_KEY_BUSERID;
//extern const NSString* YX_KEY_CHANNELID;
extern const NSString* YX_KEY_DEVICENTOKEN;
extern const NSString* YX_KEY_LOGINTIME;
extern const NSString* YX_KEY_USERID;
extern const NSString* YX_KEY_CHECKCODE;
//extern const NSString* YX_KEY_UUID;
//VALUE
extern const NSString* YX_VALUE_CLIENTVERSION;
extern const NSString* YX_VALUE_DEVICETYPE;
extern const NSString* YX_VALUE_USERID;
extern const NSString* YX_VALUE_CHECKCODE;
//extern const NSString* YX_VALUE_BUSERID;
//extern const NSString* YX_VALUE_CHANNELID;
extern const NSString* YX_VALUE_DEVICENTOKEN;
//extern const NSString* YX_VALUE_UUID;

extern const NSString *ISTUDY_UPGRADEINFO;//强制升级
extern const NSString *GUIZONG_AVTARBYUUID;//获取聊天头像
extern const NSString *GUIZONG_LIVEDETAIL;//直播详情

@interface Y_X_DataInterfance : NSObject
+(void) initialize;
+(NSMutableDictionary *)commonParams ;
+(void) setCommonParam:(id)key value:(id)value;
+(id) commonParam:(id) key;

@end
