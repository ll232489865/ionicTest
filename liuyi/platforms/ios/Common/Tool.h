//
//  Tool.h
//  ZuTing
//
//  Created by 潘欣 on 16/7/13.
//  Copyright © 2016年 PEN. All rights reserved.
//

#import <Foundation/Foundation.h>
// In bytes
#define FileHashDefaultChunkSizeForReadingData 4096


// Extern
#if defined(__cplusplus)
#define FILEMD5HASH_EXTERN extern "C"
#else
#define FILEMD5HASH_EXTERN extern
#endif

//---------------------------------------------------------
// Function declaration
//---------------------------------------------------------

FILEMD5HASH_EXTERN CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,
                                                         size_t chunkSizeForReadingData);

@interface Tool : NSObject
+(BOOL)judgeLegal:(NSString *)pass;
+(BOOL)codeLegal:(NSString *)pass;


/** 拼接版本号 */
+(NSString *)appendVersionString;


/** 底部 按钮 */
+(UIView *)configViewWithViewFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor andImgW:(CGFloat)imgW andImgH:(CGFloat)imgH andImg:(UIImage *)image andLabText:(NSString *)textStr andLabTextColor:(UIColor *)textColor andLabTextFont:(NSInteger)font;

/** 拼接成 逗号隔开的字符串 */
+(NSMutableString *)arrToStrWith:(NSMutableArray *)arr;

/** 把view 转化 成 图片 */
+(UIImage *)imageFromView:(UIView *)view;

/** 给图片加水印 */
+(UIImage *)addWaterMark:(UIImage *)image;


//压缩图片
+(NSData *)imageData:(UIImage *)image andDic:(NSDictionary *)dic;


/**
 *  处理UILabel换行
 *
 *  @param label        需要换行的UILabel
 *  @param widthOfLabel 限制的宽度
 *
 *  @return 换行后的高度
 */

+ (CGFloat)lineBreak:(UILabel *)label width:(CGFloat)widthOfLabel;


+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;


/**
 *  MD5加密
 */
+ (NSString *)md5:(NSString *)inputStr;
+(NSString *)md5FileData:(NSData *)fileData;
/**
 *  MD5文件加密
 */
+(NSString *)computeMD5HashOfFileInPath:(NSString *) filePath;

/**
 * 文件大小
 */
+ (long long)fileSizeAtPath:(NSString*) filePath;

/**
 *  判断字符串是否为空
 */
+ (NSString*)strOrEmpty:(NSString*)str;
/**************************************************************************************/

/**
 *  判断字符串是否为空
 */
+(BOOL)strIsNULL:(NSString *)str;
/**************************************************************************************/
/**
 *  数据文件路径
 */
+ (NSString *)dataFilePath:(NSString *)_str;

/**
 *  判断电话号码
 */
+ (BOOL)validatePhone:(NSString *)phone;

/**
 *  判断email
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  判断是否是汉字
 */
+ (BOOL)isOrChinese:(NSString *)chinese;


/**
 *  时间格式
 */
+ (NSDate*)getShortDateFormString:(NSString*)str;
+ (NSDate*)getDateFormString:(NSString*)str;

+ (NSDate*)getDateAndTimeFormString:(NSString*)str;
+ (NSDate*)getTimeFormString:(NSString*)str;

+ (NSString*)getStringFormDate:(NSDate*)date;
+ (NSString*)getStringFormDateAndTime:(NSDate*)date;
+ (NSString*)getStringTimeAndWeekFormDate:(NSDate*)date;

+ (NSString*)getStringMonthAndDayFormDate:(NSDate*)date;
+ (NSString*)getShortStringTimeAndWeekFormDate:(NSDate*)date;

// 数组格式化成字符串
+ (NSString*)arrayChangeToString:(NSArray*)array withSplit:(NSString*)split;

+ (NSArray*)changeStringToArray:(NSString*)string;
+ (UIColor *) getColor:(NSString *)str;

/**************************************************************************************/
//文件操作相关

//返回DocumentPath
+(NSString *)DocumentPath;

//根据路径创建文件夹
+(void)createFileWith:(NSString *)path;

//根据路径删除文件夹
+(void)deleteFileWith:(NSString *)path;


//根据13位的时间戳获取时间
+ (NSString*)getDayStringFromTimeStamp:(NSString*)str;

/*!
 * @brief 把格式化的JSON格式的字符串转换成数组
 * @param jsonString JSON格式的字符串
 * @return 返回数组
 */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;

/** 加了换行的json  */
+(NSString *)arrToJSON:(NSArray *)JSONArr;

/** 原始json  */
+(NSString *)arrToRawJSON:(NSArray *)JSONArr;

/** 加了换行的json  */
+(NSString *)ToJSON:(id )json;

/** 原始json 有斜杠  */
+(NSString *)ToRawJSON:(id )json;

/** string转object */
+ (id)jsonStringToObject:(NSString *)jsonString;

/**************************************************************************************/

@end
