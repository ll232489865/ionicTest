//
//  GlobalDefine.h
//  ChannelIOS
//
//  Created by 潘欣 on 15/9/19.
//  Copyright (c) 2015年 想学就学. All rights reserved.

// 一些自定义的方法会在这里
#import <Foundation/Foundation.h>

@interface GlobalDefine : NSObject
//验证手机号码
+(BOOL)checkPhoneNumber:(NSString *)number;
//验证身份证是否有效
+ (BOOL)checkIDCard:(NSString *)str;

//验证邮政编码
+(BOOL)checkCode:(NSString *)number;

//时间戳转换成日期
+(NSString *)getTimeInterval:(NSString *)interval;

//把阿拉伯数字装换成 中文
+(NSString *)translation:(NSString *)arebic;
// 获取当前周的周一和周日的时间
+(NSString *)getWeekTime;
+(NSString *)timeInterval:(NSString *)interval;

+(NSString *)getYearandMonth:(NSString *)interval;

//根据nsdate得到时间
+(NSString *)dateWithYearMonthDay:(NSDate *)date;

//点击图片变大
+(void)showImage:(UIImageView *)avatarImageView saveBtn:(UIButton *)btn;
//获取消失和分钟
+(NSString *)getHHmm:(NSString *)interval;
//获取月和日
+(NSString *)getMonthAndDay:(NSString *)interval;
+(NSString *)YearMonthDayline:(NSDate *)date;





+(NSString *)getUuid;
//获取手机分辨率
+(CGRect)mainBounds;
//获取手机的运营商
+(NSString *)telephony;
#pragma mark - iPhone 操作系统
+(NSString *)currentSystemVersion;// 9.2.1
#pragma mark - 获取设备是iPhone几
+(NSString *)systemInfoDevice;// 5s 6 6s


//加密
+(NSString *)encryptWithString:(NSString *)content;
+(NSMutableArray *)accesstokenAndserverGreet:(NSString *)data;

//只能输入字母和数字
+ (BOOL)validateUserPasswd:(NSString *)str;
@end
