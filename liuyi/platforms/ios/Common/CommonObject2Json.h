//
//  CommonObject2Json.h
//  ZuTing
//
//  Created by 白菜 on 16/9/21.
//  Copyright © 2016年 PEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonObject2Json : NSObject


+(NSString *)converClassToJSON:(id)item;

+(NSArray *)converClassArrayToJSON:(NSArray *)arr_class;

+(NSDictionary *)converClassDicToJSON:(NSDictionary *)dic_class;

+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;



@end
