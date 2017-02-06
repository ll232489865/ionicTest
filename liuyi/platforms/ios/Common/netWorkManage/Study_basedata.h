//
//  Study_basedata.h
//  SoftWay
//
//  Created by lianghuigui on 15/7/23.
//  Copyright (c) 2015年 lianghuigui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Study_basedata : NSObject
{
    NSMutableDictionary*   m_Dictionary;
}
@property (nonatomic ,readonly)NSString* errorCode; // 增加的错误信息返回字段
@property (nonatomic,strong)NSMutableDictionary*  m_Dictionary;

-(id)initWithJsonObject:(id)aJson;  // 用json对象初始化

-(id)init;

@end
