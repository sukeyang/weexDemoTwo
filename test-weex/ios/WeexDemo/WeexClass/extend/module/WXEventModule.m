/**
 * Created by Weex.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the Apache Licence 2.0.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import "WXEventModule.h"
#import "LocationViewController.h"
#import <WeexSDK/WXBaseViewController.h>
#import "WeexManager.h"

@implementation WXEventModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(echo:callback:))
WX_EXPORT_METHOD(@selector(openURL:callback:))

//这个openURL 对应的是weex.js文件中的openURL的方法。js调用openURL则通过runtime执行到native的这个openURL方法
- (void)openURL:(NSString *)url callback:(WXModuleKeepAliveCallback)callback {
    NSString *newURL = url;
    if ([url hasPrefix:@"//"]) {
        newURL = [NSString stringWithFormat:@"http:%@", url];
    } else if (![url hasPrefix:@"http"]) {
        // relative path
//        newURL = [NSURL URLWithString:url relativeToURL:weexInstance.scriptURL].absoluteString;
    }
    LocationViewController *controller = [[LocationViewController alloc] init];
    controller.URLString = newURL;
    [[weexInstance.viewController navigationController] pushViewController:controller animated:YES];
//    callback(@{@"result":@"nat->js: success"});
    [WeexManager sharedInstance].callback = callback;
//     callback(@"123",YES);
}

- (void)echo:(NSString *)param callback:(WXModuleKeepAliveCallback)callback {
    callback(@"123",YES);// 此处设置true，该回调function 可以多次回调执行，可以写循环测试.
}

@end

