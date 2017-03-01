//
//  LocationViewController.m
//  weexDemo
//
//  Created by yang shuo on 2017/2/28.
//  Copyright © 2017年 JLRC. All rights reserved.
//

#import "LocationViewController.h"
#import "WeexManager.h"
#import <WeexSDK/WeexSDK.h>

@interface LocationViewController ()

@property (assign,nonatomic) EventType mEventType;
@property (nonatomic, readwrite, strong) WXSDKInstance *instance;
@end

@implementation LocationViewController
//return {
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
//}
//},

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [WeexManager sharedInstance].callback(@"111111111",YES);
//    });
     _instance =  [WeexManager sharedInstance].mWXSDKInstance;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_instance fireGlobalEvent:@"geolocation" params:@{@"key":@"value,,,geolocation"}];

    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
