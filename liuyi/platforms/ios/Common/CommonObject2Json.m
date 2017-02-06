//
//  CommonObject2Json.m
//  ZuTing
//
//  Created by 白菜 on 16/9/21.
//  Copyright © 2016年 PEN. All rights reserved.
//

#import "CommonObject2Json.h"
#import <objc/runtime.h>

@implementation CommonObject2Json

+(NSString *)converClassToJSON:(id)item
{
    if (item) {
        NSData *jsonData = [self getJSON:item options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonText = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        return jsonText;
    }
    return nil;
}


+(NSArray *)converClassArrayToJSON:(NSArray *)arr_class {
    
    if (arr_class && arr_class.count > 0) {
        
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        
        for (id model in arr_class) {
            NSData *jsonData = [self getJSON:model options:NSJSONWritingPrettyPrinted error:nil];
//            NSString *jsonText = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSError *error;
            id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
            [arr addObject:object];
        }
        return arr;
    }
    return nil;
}




+(NSDictionary *)converClassDicToJSON:(NSDictionary *)dic_class {
    
    if (dic_class && dic_class.count > 0) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        for (id model in dic_class.allKeys) {
            NSData *jsonData = [self getJSON:dic_class[model] options:NSJSONWritingPrettyPrinted error:nil];
//            NSString *jsonText = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSError *error;
            id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
            
            [dic setObject:object forKey:model];
        }
        return dic;
    }
    return nil;
}









//////////////
+ (NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}


+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
}

+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if ([obj isKindOfClass:[UIImage class]]) {
        NSData *data_img=UIImagePNGRepresentation(obj);
        
        NSData *base64Data = [data_img base64EncodedDataWithOptions:0];
//        NSLog(@"%@", [NSString stringWithUTF8String:[base64Data bytes]]);
        NSString *str_base64=[NSString stringWithUTF8String:[base64Data bytes]];
        
        
        return NSValueToString(str_base64);
    }
    
    if ([obj isKindOfClass:[NSData class]]) {
        
        NSData *base64Data = [obj base64EncodedDataWithOptions:0];
//        NSLog(@"%@", [NSString stringWithUTF8String:[base64Data bytes]]);
        NSString *str_base64=[NSString stringWithUTF8String:[base64Data bytes]];
        
//        NSString *str=[[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding];

//        NSString* encodeResult = [obj base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//        
//        NSLog(@"encodeResult:%@",encodeResult);
//        NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:encodeResult options:0];
//        
//        NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
//        
//        NSLog(@"%@",decodeStr);
        
        return NSValueToString(str_base64);
    }
    
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}


@end
