//
//  Y_X_DataInterfance.m
//  TestNetWorkingDemo
//
//  Created by lianghuigui on 15/7/14.
//  Copyright (c) 2015年 lianghuigui. All rights reserved.
//

#import "Y_X_DataInterfance.h"
const NSString* YX_KEY_CLIENTVERSION=@"Clientversion";//客户端版本号
const NSString* YX_KEY_DEVICETYPE=@"Devicetype";//设备类型 1：浏览器设备 2：pc设备 3：Android设备 4：ios设备 5：windows phone设备
const NSString* YX_KEY_REQUESTTIME=@"Requesttime";//请求时的时间戳
const NSString* YX_KEY_DEVICENTOKEN=@"Devicetoken";
const NSString* YX_KEY_LOGINTIME=@"Logintime";//登录时间
const NSString* YX_KEY_USERID=@"Userid";//用户ID
const NSString* YX_KEY_CHECKCODE=@"Checkcode";//校验码
const NSString* YX_KEY_CLIENTINFO=@"Clientinfo";
const NSString* YX_KEY_ISDEBUG=@"Isdebug";


const NSString* YX_VALUE_CLIENTVERSION=@"1.0";
const NSString* YX_VALUE_DEVICETYPE=@"4";
const NSString* YX_VALUE_USERID=@"0";
const NSString* YX_VALUE_CHECKCODE=@"";
const NSString* YX_VALUE_DEVICENTOKEN=@"";
const NSString* YX_VALUE_LOGINTIME=@"";
const NSString* YX_VALUE_CLIENTINFO=@"teacher";
const NSString* YX_VALUE_ISDEBUG=@"0";
//const NSString* YX_VALUE_UUID=@"";

const NSString *ISTUDY_UPGRADEINFO              = @"/app/upgrade/info";//强制升级
const NSString *GUIZONG_AVTARBYUUID             = @"/account/info/byuuid";//获取聊天头像
const NSString *GUIZONG_LIVEDETAIL              = @"/live/detal";//直播详情
static NSMutableDictionary* commonParams;

@implementation Y_X_DataInterfance
+(void) initialize{
    commonParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                    YX_VALUE_CLIENTVERSION,YX_KEY_CLIENTVERSION,
                    YX_VALUE_DEVICETYPE,YX_KEY_DEVICETYPE,
                    YX_VALUE_USERID,YX_KEY_USERID,
                    YX_VALUE_DEVICENTOKEN,YX_KEY_DEVICENTOKEN,
                    YX_VALUE_CHECKCODE,YX_KEY_CHECKCODE,
                    YX_VALUE_LOGINTIME,YX_KEY_LOGINTIME,
                    YX_VALUE_CLIENTINFO,YX_KEY_CLIENTINFO,
                    YX_VALUE_ISDEBUG,YX_KEY_ISDEBUG,
                    nil];
}

// 获取数据字典
+(NSMutableDictionary *)commonParams {
    return commonParams;
}
// 向公用字典中添加字段
+(void) setCommonParam:(id)key value:(id)value{
    [commonParams setValue:value forKey:key];
}
// 查找key对应的一个对象
+(id) commonParam:(id) key{
    return [commonParams objectForKey:key];
}
@end
