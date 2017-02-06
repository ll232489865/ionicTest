//
//  GlobalDefine.m
//  ChannelIOS
//
//  Created by 潘欣 on 15/9/19.
//  Copyright (c) 2015年 想学就学. All rights reserved.
//

#import "GlobalDefine.h"
#import "sys/utsname.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import <dlfcn.h>
#import <sys/socket.h>
#import <sys/sysctl.h>



#import <AlipaySDK/AlipaySDK.h>
#import "RSADataVerifier.h"
#import <Security/Security.h>
#import "Base64Data.h"
#import "SecKeyWrapper.h"
@implementation GlobalDefine
//手机号码有效性校验
+(BOOL)checkPhoneNumber:(NSString *)number{
    if ([number length] == 0)
    {
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:number];
    
    if (!isMatch)
    {
        return NO;
    }
    return YES;
}
+ (BOOL)checkIDCard:(NSString *)str
{
    return checkIDfromchar((char *)[str UTF8String]);
}
//验证身份证是否有效
int checkIDfromchar (const char *sPaperId)
{
    long lSumQT =0;
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    //加权因子
    char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    //校验码
    if( 18 != strlen(sPaperId))
    return 0;
    //检验长度
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(sPaperId[i]) && !(('X' == sPaperId[i] || 'x' == sPaperId[i]) && 17 == i) )
        {
            return 0;
        }
    } //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (sPaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != sPaperId[17] )
    {
        return 0;
    }
    return 1;
}

+(BOOL)checkCode:(NSString *)number{
    if ([number length] == 0)
    {
        return NO;
    }
    NSString *regex = @"^[1-9]\\d{5}(?!\\d)$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:number];
    
    if (!isMatch)
    {
        return NO;
    }
    return YES;
}

+(NSString *)timeInterval:(NSString *)interval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:zone];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval longLongValue]/1000];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *time = [formatter stringFromDate:date];
    return time;
}

+(NSString *)getTimeInterval:(NSString *)interval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:zone];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval longLongValue]/1000];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *time = [formatter stringFromDate:date];
    return time;
}
//这个只是不显示年月日
+(NSString *)getYearandMonth:(NSString *)interval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:zone];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval longLongValue]/1000];
    [formatter setDateFormat:@"YYYYMMddHHmm"];
//    NSLog(@"dddddddd");
    NSString *time = [formatter stringFromDate:date];
    return time;
}
+(NSString *)getHHmm:(NSString *)interval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:zone];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval longLongValue]/1000];
    [formatter setDateFormat:@"HH:mm"];
    NSString *time = [formatter stringFromDate:date];
    return time;
}

+(NSString *)getMonthAndDay:(NSString *)interval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:zone];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval longLongValue]/1000];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *time = [formatter stringFromDate:date];
    return time;
}

+(NSString *)translation:(NSString *)arebic

{   NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    NSLog(@"%@",str);
    NSLog(@"%@",chinese);
    return chinese;
}



+(NSString *)getWeekTime
{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    NSLog(@"%d----%d",weekDay,day);
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1;
    if (weekDay == 1)
    {
        firstDiff = -6;
        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay+1;//这个地方原本是 8 - weekDay，因为业务要求，要多加一天
    }
    NSLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    NSLog(@"%@=======%@",firstDay,lastDay);
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@",firstDay,lastDay];
    
    return dateStr;
    
}
+(NSString *)dateWithYearMonthDay:(NSDate *)date
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
+(NSString *)YearMonthDayline:(NSDate *)date
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(void)showImage:(UIImageView *)avatarImageView saveBtn:(UIButton *)btn{
    CGRect oldframe;
    if (avatarImageView.image) {
        UIImage *image=avatarImageView.image;
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
        backgroundView.backgroundColor=[UIColor blackColor];
        backgroundView.alpha=0;
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
        imageView.image=image;
        imageView.tag=1;
        [backgroundView addSubview:imageView];
        [backgroundView addSubview:btn];
        [window addSubview:backgroundView];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
        [backgroundView addGestureRecognizer: tap];
        
        [UIView animateWithDuration:0.3 animations:^{
            imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
            backgroundView.alpha=1;
        } completion:^(BOOL finished) {
            
        }];
    }
}
+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame= CGRectMake(124, 90, 72, 72);//这里位置就是头像的原来的位置
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}



+(NSString *)getUuid
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    return result;
}
//获取手机分辨率
+(CGRect)mainBounds
{
    CGRect rect_screen = [UIScreen mainScreen].bounds;
    NSLog(@"width--%.0f---height---%.0f",rect_screen.size.width,rect_screen.size.height);
    return rect_screen;
}
//获取手机的运营商
+(NSString *)telephony
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    return mCarrier;
}

#pragma mark - iPhone 操作系统
+(NSString *)currentSystemVersion// 9.2.1
{
    NSString *strModel =  [[UIDevice currentDevice] systemVersion];
    return strModel;
}

#pragma mark - 获取设备是iPhone几
+(NSString *)systemInfoDevice// 5s 6 6s
{
    NSString *device = @"";
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"]) {
        NSLog(@"iPhone 1G");
        device = @"iPhone 1G";
    }else if ([deviceString isEqualToString:@"iPhone1,2"])
    {
        NSLog(@"iPhone 3G");
        device = @"iPhone 3G";
    }else if ([deviceString isEqualToString:@"iPhone2,1"])
    {
        NSLog(@"iPhone 3GS");
        device = @"iPhone 3GS";
    }else if ([deviceString isEqualToString:@"iPhone3,1"])
    {
        NSLog(@"iPhone 4");
        device = @"iPhone 4";
    }else if ([deviceString isEqualToString:@"iPhone3,2"])
    {
        NSLog(@"Verizon iPhone 4");
        device = @"Verizon iPhone 4";
    }else if ([deviceString isEqualToString:@"iPhone4,1"])
    {
        NSLog(@"iPhone 4S");
        device = @"iPhone 4S";
    }else if ([deviceString isEqualToString:@"iPhone5,1"]||[deviceString isEqualToString:@"iPhone5,2"])
    {
        NSLog(@"iPhone 5");
        device = @"iPhone 5";
    }else if ([deviceString isEqualToString:@"iPhone5,3"]||[deviceString isEqualToString:@"iPhone5,4"])
    {
        NSLog(@"iPhone 5C");
        device = @"iPhone 5C";
    }else if ([deviceString isEqualToString:@"iPhone6,1"]||[deviceString isEqualToString:@"iPhone6,2"])
    {
        NSLog(@"iPhone 5S");
        device = @"iPhone 5S";
    }else if ([deviceString isEqualToString:@"iPhone7,1"])
    {
        NSLog(@"iPhone 6 Plus");
        device = @"iPhone 6 Plus";
    }else if ([deviceString isEqualToString:@"iPhone7,2"])
    {
        NSLog(@"iPhone 6");
        device = @"iPhone 6";
    }else if ([deviceString isEqualToString:@"iPhone8,1"])
    {
        NSLog(@"iPhone 6s");
        device = @"iPhone 6s";
    }else if ([deviceString isEqualToString:@"iPhone8,2"])
    {
        NSLog(@"iPhone 6s Plus");
        device = @"iPhone 6s Plus";
    }else if ([deviceString isEqualToString:@"iPod1,1"])//这个地方是iPod
    {
        NSLog(@"iPod Touch 1G");
        device = @"iPod Touch 1G";
    }else if ([deviceString isEqualToString:@"iPod2,1"])
    {
        NSLog(@"iPod Touch 2G");
        device = @"iPod Touch 2G";
    }else if ([deviceString isEqualToString:@"iPod3,1"])
    {
        NSLog(@"iPod Touch 3G");
        device = @"iPod Touch 3G";
    }else if ([deviceString isEqualToString:@"iPod4,1"])
    {
        NSLog(@"iPod Touch 4G");
        device = @"iPod Touch 4G";
    }else if ([deviceString isEqualToString:@"iPod4,1"])
    {
        NSLog(@"iPod Touch 5G");
        device = @"iPod Touch 5G";
    }else if ([deviceString isEqualToString:@"iPad1,1"])//这个地方开始是ipad
    {
        NSLog(@"iPad");
        device = @"iPad";
    }else if ([deviceString isEqualToString:@"iPad2,1"])
    {
        NSLog(@"iPad 2 (WiFi)");
        device = @"iPad 2 (WiFi)";
    }else if ([deviceString isEqualToString:@"iPad2,2"])
    {
        NSLog(@"iPad 2 (GSM)");
        device = @"iPad 2 (GSM)";
    }else if ([deviceString isEqualToString:@"iPad2,3"])
    {
        NSLog(@"iPad 2 (电信3G)");
        device = @"iPad 2 (电信3G)";
    }else if ([deviceString isEqualToString:@"iPad2,4"])
    {
        NSLog(@"iPad 2 (32nm)");
        device = @"iPad 2 (32nm)";
    }else if ([deviceString isEqualToString:@"iPad2,5"])
    {
        NSLog(@"iPad mini (WiFi)");
        device = @"iPad mini (WiFi)";
    }else if ([deviceString isEqualToString:@"iPad2,6"])
    {
        NSLog(@"iPad mini (GSM)");
        device = @"iPad mini (GSM)";
    }else if ([deviceString isEqualToString:@"iPad2,7"])
    {
        NSLog(@"iPad mini (电信3G)");
        device = @"iPad mini (电信3G)";
    }else if ([deviceString isEqualToString:@"iPad4,4"]||[deviceString isEqualToString:@"iPad4,5"]||[deviceString isEqualToString:@"iPad4,6"])
    {
        NSLog(@"iPad mini 2");
        device = @"iPad mini 2";
    }else  if ([deviceString isEqualToString:@"iPad4,7"]||[deviceString isEqualToString:@"iPad4,8"]||[deviceString isEqualToString:@"iPad4,9"])
    {
        NSLog(@"iPad mini 3");
        device = @"iPad mini 3";
    }else if ([deviceString isEqualToString:@"iPad3,1"])
    {
        NSLog(@"iPad 3(WiFi)");
        device = @"iPad 3(WiFi)";
    }else if ([deviceString isEqualToString:@"iPad3,2"])
    {
        NSLog(@"iPad 3(电信3G)");
        device = @"iPad 3(电信3G)";
    }else if ([deviceString isEqualToString:@"iPad3,3"])
    {
        NSLog(@"iPad 3(4G)");
        device = @"iPad 3(4G)";
    }else if ([deviceString isEqualToString:@"iPad3,4"])
    {
        NSLog(@"iPad 4 (WiFi)");
        device = @"iPad 4 (WiFi)";
    }else if ([deviceString isEqualToString:@"iPad3,5"])
    {
        NSLog(@"iPad 4 (4G)");
        device = @"iPad 4 (4G)";
    }else if ([deviceString isEqualToString:@"iPad3,6"])
    {
        NSLog(@"iPad 4 (电信3G)");
        device = @"iPad 4 (电信3G)";
    }else if ([deviceString isEqualToString:@"iPad4,1"]||[deviceString isEqualToString:@"iPad4,2"]||[deviceString isEqualToString:@"iPad4,3"])
    {
        NSLog(@"iPad Air");
        device = @"iPad Air";
    }else if ([deviceString isEqualToString:@"iPad5,3"]||[deviceString isEqualToString:@"iPad5,4"])
    {
        NSLog(@"iPad Air 2");
        device = @"iPad Air 2";
    }else if ([deviceString isEqualToString:@"i386"]||[deviceString isEqualToString:@"x86_64"])
    {
        NSLog(@"Simulator");
        device = @"Simulator";
    }
    return device;
}


+(NSString *)encryptWithString:(NSString *)content
{
    NSData *publicKey = [NSData dataFromBase64String:PUBLICKEY];
    NSData *usernamm = [content dataUsingEncoding: NSUTF8StringEncoding];
    NSData *newKey= [SecKeyWrapper encrypt:usernamm publicKey:publicKey];
    Byte * testByte = (Byte *)[newKey bytes];
    for(int i=0;i<[newKey length];i++)
    {
        printf("%d ,",testByte);
    }
    NSString *result = [newKey base64EncodedString];
    
    NSLog(@"显示加密文件：%@",result);
    return result;
}


+(NSMutableArray *)accesstokenAndserverGreet:(NSString *)data
{
    NSMutableArray *array = [NSMutableArray new];
    int dataLength = data.length;
    int curIndex = 0;
    NSString *segment = @"";
    while (curIndex<dataLength) {
        int nextIndex = curIndex + 116;
        if (nextIndex>dataLength) {
            segment = [data substringWithRange:NSMakeRange(curIndex, dataLength - curIndex)];
        } else {
            segment = [data substringWithRange:NSMakeRange(curIndex, 116)];
        }
        [array addObject:segment];
        curIndex = nextIndex;
    }
    return array;
}




//判断只能输入 字母 数字
+ (BOOL) validateUserPasswd : (NSString *) str
{                                                                           //^[a-zA-Z][a-zA-Z0-9]
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]//[\u4e00-\u9fa5]
                                              initWithPattern:@"^[A-Za-z0-9]+$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}
@end
