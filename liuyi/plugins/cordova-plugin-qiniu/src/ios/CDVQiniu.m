//
//  CDVQiniu.m
//  ZuTIonic
//
//  Created by 潘欣 on 2016/12/27.
//
//

#import "CDVQiniu.h"
#import "QiniuSDK.h"//七牛
@implementation CDVQiniu
- (void)uploadImage:(CDVInvokedUrlCommand*)command
{
    if ( command ) {
        //dic
        NSDictionary* dic = [command.arguments objectAtIndex:0];
        
        NSString *str_token=dic[@"token"];//七牛对应的token
        NSString *str_picPath=dic[@"urlPath"];//文件在本地对应的路径
        NSString *str_domain=dic[@"domain"];//文件在服务器远程存储的域名  可能为空
        /*
         picCfg =     {
         maxHeight = 1080;
         maxSize = 300;
         maxWidth = 1920;
         };*/
        NSDictionary *dic_picCfg=dic[@"picCfg"];//压缩图片的标准
        
        ///var/mobile/Containers/Data/Application/7534DA6C-C64F-4E30-9FA5-94B0A213F4C9/Library/head.jpg?version=1469851231572
        if ([str_picPath hasPrefix:@"file://"]) {
            str_picPath=[str_picPath substringFromIndex:7];
        }
        //去除 后缀
        NSArray *arr=[str_picPath componentsSeparatedByString:@"?"];
        str_picPath=[arr firstObject];
        
        //
        UIImage *image_origin=[[UIImage alloc]initWithContentsOfFile:str_picPath];
        //
        NSData *compressData =[Tool imageData:image_origin andDic:dic_picCfg];
        
        //        NSString * md5Data=[Tool md5FileData:compressData];
        //        NSString * filesize=[NSString stringWithFormat:@"%ld",compressData.length];
        
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        
        
        QNUploadOption *upOption=[[QNUploadOption alloc]initWithProgressHandler:^(NSString *key, float percent) {
        }];
        
        [upManager putData:compressData key:nil token:str_token
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      
                      if (resp) {//成功
                          // 我们要从七牛上下载的文件的网址  url
                          NSString *str_picUrl;
                          if ([Tool strIsNULL:NSValueToString(str_domain)]) {
                              str_picUrl=[NSString stringWithFormat:@"%@/%@",QiniuURLPrefix,resp[@"key"]];
                          }else{
                              str_picUrl=[NSString stringWithFormat:@"http://%@/%@",str_domain,resp[@"key"]];
                          }
                          
                          //返回结果
                          CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:str_picUrl];
                          
                          [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                      }else{//失败
                          CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
                          
                          [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                      }
                      
                      
                  } option:upOption];
        
    }
}
@end
