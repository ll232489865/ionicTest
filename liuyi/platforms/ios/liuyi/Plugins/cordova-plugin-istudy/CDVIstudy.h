#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>

@interface CDVIstudy : CDVPlugin


- (void)getSecrityCode:(CDVInvokedUrlCommand*)command;



- (void)verify:(CDVInvokedUrlCommand*)command;


- (void)getHeader:(CDVInvokedUrlCommand*)command;

- (void)encrypt:(CDVInvokedUrlCommand*)command;



- (void)generateMd5:(CDVInvokedUrlCommand*)command;


- (void)getDeviceInfo:(CDVInvokedUrlCommand*)command;




@end