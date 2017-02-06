//
//  Study_basedata.m
//  SoftWay
//
//  Created by lianghuigui on 15/7/23.
//  Copyright (c) 2015年 lianghuigui. All rights reserved.
//

#import "Study_basedata.h"

@implementation Study_basedata
@synthesize m_Dictionary;

- (NSString*)errorCode{
    
    return [m_Dictionary objectForKey:@"errorCode"];
}


-(id)initWithJsonObject:(id)aJson
{
    if (self == [super init]) {
        m_Dictionary = (NSMutableDictionary*)aJson;
        
        
        [m_Dictionary copy];
    }
    
    return self;
}

-(id)init {
    if ( self == [super init] ) {
        m_Dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

@end
