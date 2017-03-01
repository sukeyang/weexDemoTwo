//
//  WeexManager.h
//  TextDemo
//
//  Created by yangshuo on 16/12/26.
//  Copyright © 2016年 JLRC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>
#import <TBWXDevtool/WXDevtool.h>


@interface WeexManager : NSObject

+ (instancetype)sharedInstance;

+ (void)setUp;

@property (copy, nonatomic) WXModuleKeepAliveCallback callback;

@end
