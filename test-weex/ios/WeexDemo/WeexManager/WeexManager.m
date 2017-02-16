//
//  WeexManager.m
//  TextDemo
//
//  Created by yangshuo on 16/12/26.
//  Copyright © 2016年 JLRC. All rights reserved.
//

#import "WeexManager.h"

#import "WXEventModule.h"

@implementation WeexManager

+ (void)setUp {
    //business configuration
    [WXAppConfiguration setAppGroup:@"julong"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    
    //init sdk enviroment
    [WXSDKEngine initSDKEnviroment];
    
    //register custom module and component，optional
//    [WXSDKEngine registerComponent:@"MyView" withClass:[MyViewComponent class]];
    [WXSDKEngine registerModule:@"event" withClass:[WXEventModule class]];
//
//    //register the implementation of protocol, optional
//    [WXSDKEngine registerHandler:[WXNavigationDefaultImpl new] withProtocol:@protocol(WXNavigationProtocol)];
//    
//    //set the log level
    [WXLog setLogLevel:WXLogLevelAll];
}

@end
