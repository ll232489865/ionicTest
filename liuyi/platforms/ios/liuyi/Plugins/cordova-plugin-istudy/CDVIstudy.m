#import "CDVIstudy.h"
#import <Cordova/CDV.h>

#import <AlipaySDK/AlipaySDK.h>
#import "RSADataVerifier.h"
#import <Security/Security.h>
#import "Base64Data.h"
#import "SecKeyWrapper.h"

#import "GlobalDefine.h"

#import <AdSupport/AdSupport.h>//广告标识符



@implementation CDVIstudy




- (void)getSecrityCode:(CDVInvokedUrlCommand*)command
{
    //rsa加密
    NSString *_serverGreeting=[command.arguments objectAtIndex:0];
    
    int value = arc4random();
    NSString *random = [NSString stringWithFormat:@"%d",value];
    NSString *handshakeCode = [NSString stringWithFormat:@"%@&%@",_serverGreeting,random];
    NSString *secrityCode = [GlobalDefine encryptWithString:handshakeCode];
    
    //返回结果
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:secrityCode];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



- (void)verify:(CDVInvokedUrlCommand*)command;
{
     NSDictionary* pDic = [command.arguments objectAtIndex:0];
    
     NSString *str_greeting=pDic[@"serverGreeting"];
    
     NSString *str_serverSigin=pDic[@"serverSign"];
    
     //服务器验签 使用ali 的验签方法
     RSADataVerifier *verifier = [[RSADataVerifier alloc] initWithPublicKey:PUBLICKEY];
     BOOL rsaBOOL = [verifier verifyString:str_greeting withSign:str_serverSigin];
    
     //返回结果
     CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:rsaBOOL];
    
     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}







/* log a message */
-(void)getHeader:(CDVInvokedUrlCommand *)command
{    
    //    // input
    //    {
    //        headers =     {
    //            header1 = header1;
    //            header2 = header2;
    //        };
    //        params =     {
    //            age = 1;
    //            gender = man;
    //            name = huangxuefeng;
    //        };
    //        path = list;
    //    }
    //    // compute checksum
    //    // output
    //    headers =     {
    //        header1 = header1;
    //        header2 = header2;
    //        timestamp = 1222222; // nowtime
    //        token = xxxxx; // 登录后的token
    //        checksum = xxxxx; // md5
    //    }



     NSDictionary* pDic = [command.arguments objectAtIndex:0];
    
     NSDictionary *dic_headers=pDic[@"headers"];
    
     NSDictionary *dic_params=pDic[@"params"];
    
     NSString *str_path=pDic[@"path"];
     if ([Tool strIsNULL:NSValueToString(str_path)]) {
         str_path=@"";
     }
     //token 和MD5 key
     NSDictionary *dic_session=pDic[@"session"];
     NSString *str_token=dic_session[@"token"];
     NSString *str_md5Key=dic_session[@"md5key"];
    
     //保存MD5KEY token
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     [defaults setObject:str_md5Key forKey:MD5KEY];
     [defaults setObject:str_token forKey:HTTPTOKEN];
     [defaults synchronize];
     //拼接
    
     //1.timestamp
     NSString * nowTime=[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000];
    
     //2.token
     NSMutableDictionary *Dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:
                               nowTime,@"timestamp",
                               str_token,@"token",nil];
    
     //3.header
     for (id key in [dic_headers allKeys]) {
         id value=[dic_headers objectForKey:key];
         if ([Tool strIsNULL:NSValueToString(value)]) {
             value=@"";
         }
         [Dic setObject:value forKey:key];
     }
    
     //4.
     NSMutableDictionary *dic_checksum=[NSMutableDictionary dictionary];
    
     //4.1 dic_headers
     for (id key in [dic_headers allKeys]) {
         id value=[dic_headers objectForKey:key];
         if ([Tool strIsNULL:NSValueToString(value)]) {
             value=@"";
         }
         [dic_checksum setObject:value forKey:key];
     }
     //4.2 dic_params
     for (id key in [dic_params allKeys]) {
         id value=[dic_params objectForKey:key];
         if ([Tool strIsNULL:NSValueToString(value)]) {
             value=@"";
         }
         [dic_checksum setObject:value forKey:key];
     }
     //4.3 timestamp  token
     [dic_checksum setObject:nowTime forKey:@"timestamp"];
     [dic_checksum setObject:str_token forKey:@"token"];
    
     NSString *checksumStr=[self splitWithDic:dic_checksum];
    
     NSString *checksum=[Tool md5:[NSString stringWithFormat:@"%@&%@%@",str_path,checksumStr,str_md5Key]];
    
     [Dic setObject:checksum forKey:@"checksum"];
    
     //5.
     NSMutableArray *arr_checksumHeader=[NSMutableArray array];
    
     for (id key in [dic_headers allKeys]) {
         [arr_checksumHeader addObject:key];
     }
     [arr_checksumHeader addObject:@"timestamp"];
     [arr_checksumHeader addObject:@"token"];
    
     NSString *checksumHeadersStr=[Tool arrToRawJSON:arr_checksumHeader];
     [Dic setObject:checksumHeadersStr forKey:@"checksum-headers"];
    
     // 返回类型为JSON，JS层在取值是需要按照JSON进行获取
     CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:Dic];
    
     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
 }

#pragma mark-
#pragma mark--- 头拼串
-(NSString *)splitWithDic:(NSMutableDictionary *)dic
{
    NSMutableArray *arr=[NSMutableArray array];
    for (id obj in [dic allKeys]) {
        NSString *str=[NSString stringWithFormat:@"%@=%@",obj,[dic objectForKey:obj]];
        [arr addObject:str];
    }
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *myDataArray = [NSArray arrayWithArray:arr];
    NSArray *resultArray = [myDataArray sortedArrayUsingDescriptors:descriptors];
    
    //    参数1=xxx&timestamp=xxx&。。。
    NSMutableString *str=[[NSMutableString alloc]init];
    
    for (int i=0; i<resultArray.count; i++) {
        if (i==resultArray.count-1) {
            [str appendString:resultArray[i]];
        }else{
            [str appendFormat:@"%@&",resultArray[i]];
        }
    }
    return str;
}


- (void)encrypt:(CDVInvokedUrlCommand*)command
{
    //rsa加密
    NSString *str_handshakeCode=[command.arguments objectAtIndex:0];
    
    NSString *str_secrityCode = [GlobalDefine encryptWithString:str_handshakeCode];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:str_secrityCode];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



- (void)generateMd5:(CDVInvokedUrlCommand*)command
{
    NSString *str_md5=[command.arguments objectAtIndex:0];

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[Tool md5:str_md5]];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}


- (void)getDeviceInfo:(CDVInvokedUrlCommand*)command
{
    
    NSString *netstatus = [self getNetWorkStates];
    //app设备的唯一标识符
    NSString * str_idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    
    CGRect bounds = [GlobalDefine mainBounds];//获取手机分辨率
    NSString *bound = [NSString stringWithFormat:@"(%f,%f)",bounds.size.width,bounds.size.height];
    NSString *telephony = [GlobalDefine telephony];//获取手机的运营商
    NSString *version = [GlobalDefine currentSystemVersion];//iPhone 操作系统
    NSString *devInfo = [GlobalDefine systemInfoDevice];//获取设备是iPhone几
    //获取当前App版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];//app 版本
    
    NSMutableDictionary * exprmae=nil;
    exprmae=[NSMutableDictionary dictionaryWithObjectsAndKeys:
             str_idfa,@"devId",
             bound,@"res",
             telephony,@"isp",
             version,@"os",
             devInfo,@"model",
             app_Version,@"appVer",
             netstatus,@"network",
             nil];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:exprmae];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
#pragma mark-
#pragma mark--- 获取使用网络
-(NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                {
                    state = @"WIFI";
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}




@end
