/**
 * Created by Weex.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the Apache Licence 2.0.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import "WXEventModule.h"
#import "ViewController.h"
#import <WeexSDK/WXBaseViewController.h>

@implementation WXEventModule
//WX_EXPORT_METHOD(@selector(openURL:callback:))
WX_EXPORT_METHOD(@selector(openURL:callback:))
@synthesize weexInstance;

//这个openURL 对应的是weex.js文件中的openURL的方法。js调用openURL则通过runtime执行到native的这个openURL方法
//items: [{
//content: "扫码",
//methodName: "qrcode"
//}, {
//content: "GPS",
//methodName: "gps"
//}, {
//content: "获取session",
//methodName: "getSession"
//}, {
//content: "相册",
//methodName: "album"
//}, {
//content: "地图",
//methodName: "map"
//}]

- (void)openURL:(NSString *)url {
    NSString *newURL = url;
    if ([url hasPrefix:@"//"]) {
        newURL = [NSString stringWithFormat:@"http:%@", url];
    } else if (![url hasPrefix:@"http"]) {
        // relative path
        newURL = [NSURL URLWithString:url relativeToURL:weexInstance.scriptURL].absoluteString;
    }
    
    UIViewController *controller = [[ViewController alloc] init];
//    ((ViewController *)controller).url = [NSURL URLWithString:newURL];
//    [[weexInstance.viewController navigationController] pushViewController:controller animated:YES];
}

- (void)openURL:(NSString *)url callback:(WXModuleCallback)callback {
    NSString *newURL = url;
    if ([url hasPrefix:@"//"]) {
        newURL = [NSString stringWithFormat:@"http:%@", url];
    } else if (![url hasPrefix:@"http"]) {
        newURL = [NSURL URLWithString:url relativeToURL:weexInstance.scriptURL].absoluteString;
    }
    
//    if (@"") {
//        <#statements#>
//    }
//    UIViewController *controller = [[WXDemoViewController alloc] init];
//    ((WXDemoViewController *)controller).url = [NSURL URLWithString:newURL];
//    [[weexInstance.viewController navigationController] pushViewController:controller animated:YES];
    callback(@{@"result":@"success"});
//    https://github.com/alibaba/weex/issues/1083
//    https://github.com/alibaba/weex/issues/866
//    https://github.com/alibaba/weex/issues/1337
//    https://github.com/weexteam/article/issues/67
//    https://github.com/alibaba/weex/issues/1356
//    https://github.com/weexteam/article/issues/17
}

@end

