//
//  Tool.m
//  ZuTing
//
//  Created by 潘欣 on 16/7/13.
//  Copyright © 2016年 PEN. All rights reserved.
//

#import "Tool.h"
#include <stdint.h>
#include <stdio.h>

// Core Foundation
#include <CoreFoundation/CoreFoundation.h>

// Cryptography
#include <CommonCrypto/CommonDigest.h>

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,
                                      size_t chunkSizeForReadingData) {
    
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) goto done;
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
    }
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                  (UInt8 *)buffer,
                                                  (CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject,
                      (const void *)buffer,
                      (CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault,
                                       (const char *)hash,
                                       kCFStringEncodingUTF8);
    
done:
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}
@implementation Tool


/** 拼接版本号 */
+(NSString *)appendVersionString
{
    //    版本号：2.1.0_12_YYYYMMDDHHMISS_CHNNL,
    //    其中
    //    2.1.0是对外版本号，
    //    12是versioncode，代表版本大小，版本的新旧是根据这个字段来的
    //    YYYYMMDDHHMISS是时间戳,
    //    CHNNL代表端的信息
    //
    //    代码算法，数据库相关操作
    //    注意：比较版本的新旧是按照数据库的id来比较－默认认为最后上传的版本肯定是最新的版本
    //    如果没有版本号规范的在线版本，不升级
    //    如果传过来的版本在版本号规范的在线版本中不存在，强制升级
    //    如果传过来的版本不是版本号规范的在线版本中的最新版本，非强制升级
    //    如果传过来的版本是版本号规范的在线版本中的最新版本，不升级
    
    NSString *str_append=[NSString stringWithFormat:@"%@_%@_%@_student",ShortVersion,VersionCode,@"20160830180000"];
    
    return str_append;
}

+(UIView *)configViewWithViewFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor andImgW:(CGFloat)imgW andImgH:(CGFloat)imgH andImg:(UIImage *)image andLabText:(NSString *)textStr andLabTextColor:(UIColor *)textColor andLabTextFont:(NSInteger)font
{
    UIView *view_Background=[[UIView alloc]initWithFrame:frame];
    view_Background.backgroundColor=backgroundColor;
    
    if (image) {
        CGFloat ivW=imgW;
        CGFloat ivH=imgH;
        CGFloat ivY=0;
        UIImageView *iv_Img=[[UIImageView alloc]initWithFrame:CGRectMake(0, ivY, ivW, ivH)];
        iv_Img.image=image;
        //
        UILabel *lab_Text=[UILabel labelframe:CGRectMake(CGRectGetMaxX(iv_Img.frame)+5, ivY, ivW, ivH)
                                   labelTitle:textStr
                                        color:textColor
                                         font:font
                                textAlignment:NSTextAlignmentCenter];
        [lab_Text sizeToFit];
        //
        CGFloat viewW=iv_Img.frame.size.width+lab_Text.frame.size.width+5;
        CGFloat viewH;
        
        if (ivH>lab_Text.frame.size.height) {
            viewH=ivH;
            lab_Text.frame=CGRectMake(lab_Text.frame.origin.x, (ivH-lab_Text.frame.size.height)/2, lab_Text.frame.size.width, lab_Text.frame.size.height);
        }else{
            viewH=lab_Text.frame.size.height;
            iv_Img.frame=CGRectMake(iv_Img.frame.origin.x, (lab_Text.frame.size.height-ivH)/2, iv_Img.frame.size.width, iv_Img.frame.size.height);
        }
        CGFloat viewX=(frame.size.width-viewW)/2;
        CGFloat viewY=(frame.size.height-viewH)/2;
        
        UIView *view_b=[[UIView alloc]initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
        
        lab_Text.userInteractionEnabled=YES;
        iv_Img.userInteractionEnabled=YES;
        view_b.userInteractionEnabled=YES;
        view_Background.userInteractionEnabled=YES;
        
        [view_b addSubview:lab_Text];
        [view_b addSubview:iv_Img];
        [view_Background addSubview:view_b];
    }else{
        //
        UILabel *lab_Text=[UILabel labelframe:CGRectMake(0, 0, 20, 20)
                                   labelTitle:textStr
                                        color:textColor
                                         font:font
                                textAlignment:NSTextAlignmentCenter];
        [lab_Text sizeToFit];
        //
        CGFloat viewW=lab_Text.frame.size.width;
        CGFloat viewH=20;
        CGFloat viewX=(frame.size.width-viewW)/2;
        CGFloat viewY=(frame.size.height-viewH)/2;
        
        lab_Text.frame=CGRectMake(viewX, viewY, viewW, viewH);
        
        lab_Text.userInteractionEnabled=YES;
        view_Background.userInteractionEnabled=YES;
        
        [view_Background addSubview:lab_Text];
    }
    return view_Background;
}

//拼接成 逗号隔开的字符串
+(NSMutableString *)arrToStrWith:(NSMutableArray *)arr
{
    NSMutableString *str=[[NSMutableString alloc]init];
    for (int i=0; i<arr.count; i++) {
        if (i==arr.count-1) {
            [str appendString:[NSString stringWithFormat:@"%@",arr[i]]];
        }else{
            [str appendString:[NSString stringWithFormat:@"%@,",arr[i]]];
        }
    }
    return str;
}


+(UIImage *)imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return img;
}

/** 给图片加水印 */
+(UIImage *)addWaterMark:(UIImage *)image
{
    UIImageView *iv_original=[[UIImageView alloc]initWithImage:image];
    
    if (image.size.width>=image.size.height) {
        iv_original.frame=CGRectMake(0, 0, ScreenSizeWidth, (image.size.height/image.size.width)*ScreenSizeWidth);
    }else{
        iv_original.frame=CGRectMake(0, 0, (image.size.width/image.size.height)*ScreenSizeHeight,ScreenSizeHeight);
    }
    
    CGFloat w=30;
    CGFloat h=30;
    CGFloat x=iv_original.frame.size.width-w;
    CGFloat y=iv_original.frame.size.height-h;
    
    UIImageView *iv_waterMark=[[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    iv_waterMark.image=ImageNamed(@"icon_waterMark");
    
    [iv_original addSubview:iv_waterMark];
    
    return [Tool imageFromView:iv_original];
}



+(NSData *)imageData:(UIImage *)image andDic:(NSDictionary *)dic
{
    /*
     picCfg =     {
     maxHeight = 1080;
     maxSize = 300;
     maxWidth = 1920;
     };*/
    CGFloat MAXH=[NSValueToString(dic[@"maxHeight"]) integerValue]*1.0;
    CGFloat MAXW=[NSValueToString(dic[@"maxWidth"]) integerValue]*1.0;


    CGFloat MAXFileSize=[NSValueToString(dic[@"maxSize"]) integerValue]*1024.0;
    
    CGSize img_oldSize=image.size;
    CGSize img_newSize;
    
    if (img_oldSize.height>MAXH||img_oldSize.width>MAXW) {
        if (img_oldSize.height>=img_oldSize.width) {
            CGFloat w=(MAXH/(img_oldSize.height*1.0))*img_oldSize.width;
            img_newSize=CGSizeMake(w, MAXH);
        }else{
            CGFloat h=(MAXW/(img_oldSize.width*1.0))*img_oldSize.height;
            img_newSize=CGSizeMake(MAXW, h);
        }
    }else{
        img_newSize=img_oldSize;
    }
    
    
    //size 为CGSize类型，即你所需要的图片尺寸
    UIGraphicsBeginImageContext(img_newSize);
    
    [image drawInRect:CGRectMake(0, 0, img_newSize.width, img_newSize.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    NSData *data=UIImageJPEGRepresentation(scaledImage, 1.0);
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    while ([data length] > MAXFileSize && compression > maxCompression) {
        compression -= 0.01;
        data = UIImageJPEGRepresentation(scaledImage, compression);
    }
    
    return data;
}



+(BOOL)judgeLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6&&[pass length]<=12){
        NSString * regex = @"^[0-9A-Za-z]{6,12}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}
+(BOOL)codeLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 1&&[pass length]<=6){
        NSString * regex = @"^[0-9A-Za-z]{1,6}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

/**
 *  处理UILabel换行
 *
 *  @param label        需要换行的UILabel
 *  @param widthOfLabel 限制的宽度
 *
 *  @return 换行后的高度
 */
+ (CGFloat)lineBreak:(UILabel *)label width:(CGFloat)widthOfLabel{
    
    NSString *text = label.text;
    
    NSDictionary * attribute = [NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil];
    
    if (IsIOS7) {
        CGRect size = [text boundingRectWithSize:CGSizeMake(widthOfLabel, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attribute context:nil];
        
        return size.size.height + 2;
    } else {
        CGSize new = [text sizeWithFont:label.font constrainedToSize:CGSizeMake(ScreenSizeWidth - 170, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return new.height + 2;
    }
    
}


+ (NSString*)md5:(NSString *)inputStr {
    const char *cStr = [inputStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
//MD5文件加密
+(NSString *)md5FileData:(NSData *)fileData{
    
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [[NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                    digest[0], digest[1],
                    digest[2], digest[3],
                    digest[4], digest[5],
                    digest[6], digest[7],
                    digest[8], digest[9],
                    digest[10], digest[11],
                    digest[12], digest[13],
                    digest[14], digest[15]] lowercaseString];
    return s;
    
}

+ (NSString *)computeMD5HashOfFileInPath:(NSString *) filePath
{
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)filePath, FileHashDefaultChunkSizeForReadingData);
}

+ (long long)fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//判空操作的代码
+ (NSString*)strOrEmpty:(NSString*)str{
    return (str==nil?@"":str);
}

/****************************************************************************************************/
/**
 *  判断字符串是否为空
 */
+(BOOL)strIsNULL:(NSString *)str
{
    if ([str isEqualToString:@""]||str.length==0||[[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        return YES;
    }else{
        return NO;
    }
}
/****************************************************************************************************/

// 数据文件路径
+ (NSString *)dataFilePath:(NSString *)str {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:str];
}

//判断电话号码
+ (BOOL)validatePhone:(NSString *)phone {
    NSString *emailRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:phone];
}

//判断email
+ (BOOL)validateEmail:(NSString *)email {
    //    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//判断是否是汉字
+ (BOOL)isOrChinese:(NSString *)chinese{
    
    NSString * textStr=@"^[\u4e00-\u9fa5]+$";//[\u4e00-\u9fa5]+
    NSPredicate * chineseTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", textStr];
    return [chineseTest evaluateWithObject:chinese];
}

+ (NSDate*)getShortDateFormString:(NSString*)str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter dateFromString:str];
}

+ (NSDate*)getDateFormString:(NSString*)str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:str];
}

+ (NSDate*)getDateAndTimeFormString:(NSString*)str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter dateFromString:str];
}

+ (NSDate*)getTimeFormString:(NSString*)str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    return [formatter dateFromString:str];
}


+ (NSString*)getStringFormDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

+ (NSString*)getStringFormDateAndTime:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}
+ (NSString*)getStringMonthAndDayFormDate:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd"];
    return [formatter stringFromDate:date];
}

+ (NSString*)getStringTimeAndWeekFormDate:(NSDate*)date {
    if (!date) {
        return nil;
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps;
    comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy/MM/dd"];
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendString:[formatter stringFromDate:date]];
    switch (weekday) {
        case 1:
            [string appendString:@"(周日)"];
            break;
        case 2:
            [string appendString:@"(周一)"];
            break;
        case 3:
            [string appendString:@"(周二)"];
            break;
        case 4:
            [string appendString:@"(周三)"];
            break;
        case 5:
            [string appendString:@"(周四)"];
            break;
        case 6:
            [string appendString:@"(周五)"];
            break;
        case 7:
            [string appendString:@"(周六)"];
            break;
            
        default:
            break;
    }
    return string;
}

+ (NSString*)getShortStringTimeAndWeekFormDate:(NSDate*)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps;
    comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd"];
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendString:[formatter stringFromDate:date]];
    switch (weekday) {
        case 1:
            [string appendString:@"(周日)"];
            break;
        case 2:
            [string appendString:@"(周一)"];
            break;
        case 3:
            [string appendString:@"(周二)"];
            break;
        case 4:
            [string appendString:@"(周三)"];
            break;
        case 5:
            [string appendString:@"(周四)"];
            break;
        case 6:
            [string appendString:@"(周五)"];
            break;
        case 7:
            [string appendString:@"(周六)"];
            break;
            
        default:
            break;
    }
    return string;
}



+ (NSString*)arrayChangeToString:(NSArray*)array withSplit:(NSString*)split {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0 ; i < array.count; i++) {
        [string appendString:[array objectAtIndex:i]];
        if (i != array.count - 1) {
            [string appendString:split];
        }
    }
    return string;
}

+ (NSArray*)changeStringToArray:(NSString*)string {
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@","];
    return [string componentsSeparatedByCharactersInSet:characterSet];
}
+ (UIColor *) getColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue,alph;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    
    if (str.length>7) {
        range.location=7;
        [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&alph];
        color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alph/255.0f];
    }
    return color;
}
/**************************************************************************************/
//文件操作相关
+(NSString *)DocumentPath
{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return path;
}

+(void)createFileWith:(NSString *)path
{
    NSFileManager * fm = [NSFileManager defaultManager];
    NSError * error = nil;
    //创建一个文件或目录
    //创建一个目录[PATH stringByAppendingPathComponent:@"files/MIDDLE/file3"]
    [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    //第一个参数，创建的目录的路径
    //第二个参数，如果添NO，当缺少中间目录时，报错。如果添YES，缺少中间目录时，自动创建中间目录
    //第三个参数，设置新创建目录的属性，如果传nil，使用默认属性
    if (error) {
        NSLog(@"%@", error);
    }
    //    //判断一个文件是否存在，判断是否是目录
    //    if ([fm fileExistsAtPath:path]) {
    //        NSLog(@"创建文件夹ok");
    //    }else{
    //        NSLog(@"创建文件夹over");
    //    }
}

+(void)deleteFileWith:(NSString *)path
{
    NSFileManager * fm = [NSFileManager defaultManager];
    //删除文件或目录
    [fm removeItemAtPath:path error:nil];
}


//根据13位的时间戳获取时间
+ (NSString*)getDayStringFromTimeStamp:(NSString*)str {
    NSString *endtTime = [NSString stringWithFormat:@"%@", str];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[endtTime longLongValue]/1000];
    return [self getStringFormDate:confromTimesp];
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成数组
 * @param jsonString JSON格式的字符串
 * @return 返回数组
 */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr=[NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return arr;
}

+(NSString *)arrToJSON:(NSArray *)JSONArr
{
    NSString *json;
    if ([NSJSONSerialization isValidJSONObject:JSONArr])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:JSONArr options:NSJSONWritingPrettyPrinted error:&error];
        json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"json data:%@",json);
    }
    return json;
}

/** 原始json  */
+(NSString *)arrToRawJSON:(NSArray *)JSONArr
{
    NSString *json;
    if ([NSJSONSerialization isValidJSONObject:JSONArr])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:JSONArr options:nil error:&error];
        
        
        
        json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return json;
}



+(NSString *)ToJSON:(id )json
{
    NSString *str_json;
    if ([NSJSONSerialization isValidJSONObject:json])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
        json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return str_json;
}

/** 原始json  */
+(NSString *)ToRawJSON:(id )json
{
    NSString *str_json;
    if ([NSJSONSerialization isValidJSONObject:json])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:nil error:&error];
        str_json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return str_json;
}


+(id)jsonStringToObject:(NSString *)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    return object;
}

@end
