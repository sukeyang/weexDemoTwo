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
#import "WeexModel.h"
#import "WXScannerVC.h"
#import "AppDelegate.h"

@interface LocationViewController ()

@property (assign,nonatomic) EventType mEventType;
@property (nonatomic, readwrite, strong) WXSDKInstance *instance;
@property (strong, nonatomic) UIButton *keyBordButton;
@property (strong, nonatomic) WeexModel *weexModel;
@property (strong, nonatomic) UILabel *showText;

@end

@implementation LocationViewController

- (WeexModel *)weexModel {
    if (_weexModel) {
        return _weexModel;
    }
    _weexModel = [[WeexModel alloc] init];
    
    return _weexModel;
}

- (void)setURLString:(NSString *)URLString {
    _URLString = URLString;
    if ([@"qrcode" isEqualToString:URLString]) {
        self.mEventType = EventTypeTwoCode;
    } else if ([@"gps" isEqualToString:URLString]) {
        self.mEventType = EventTypeGPS;
    } else if ([@"getSession" isEqualToString:URLString]) {
        self.mEventType = EventTypeToSesssion;
    } else if ([@"map" isEqualToString:URLString]) {
        self.mEventType = EventTypeToMap;
    } else if ([@"album" isEqualToString:URLString]) {
        self.mEventType = EventTypePhoto;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weexModel.weexName = _URLString;
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"传回JS" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _keyBordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _keyBordButton.frame = CGRectMake(0, 0, 100, 40);
    _keyBordButton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_keyBordButton];
    [_keyBordButton setTitleColor:AppColor(@"333333") forState:UIControlStateNormal];
//    _keyBordButton.backgroundColor = [UIColor redColor];
    [_keyBordButton addTarget:self action:@selector(btnClickHiden:) forControlEvents:UIControlEventTouchUpInside];
    _keyBordButton.center = CGPointMake(AppScreenWidth/2.0, 100);
    
    UILabel* contentlab = [[UILabel alloc] initWithFrame:CGRectMake(0, _keyBordButton.frameBottom +20, AppScreenWidth,100)];
    contentlab.backgroundColor = [UIColor grayColor];
    contentlab.numberOfLines = 0;
    contentlab.textColor =AppColor(@"333333");
    [self.view addSubview:contentlab];
    _showText = contentlab;
    
    
    [_keyBordButton setTitle:_URLString forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [WeexManager sharedInstance].callback(@"111111111",YES);
//    });
//     _instance =  [WeexManager sharedInstance].mWXSDKInstance;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_instance fireGlobalEvent:@"geolocation" params:@{@"key":@"value,,,geolocation"}];
//
//    });
}

- (void)rightItemClick:(id)sender {
    if (_showText.text.length) {
         _weexModel.weexContent = _showText.text;
    }
    NSDictionary *dict = [_weexModel yy_modelToJSONObject];
    NSString *jsonString = [dict yy_modelToJSONString];
    [WeexManager sharedInstance].callback(jsonString,YES);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleTwoCode {
    @weakify(self);
    WXScannerVC *scanViewController = [[WXScannerVC alloc] init];
    [scanViewController setUpBasicBlock:^(NSString *content) {
        @strongify(self);
        self.showText.text = content;
    }];
    [self.navigationController pushViewController:scanViewController animated:YES];
}

- (void)handleEventTypeGPS {
    @weakify(self);
    WXScannerVC *scanViewController = [[WXScannerVC alloc] init];
    [scanViewController setUpBasicBlock:^(NSString *content) {
        @strongify(self);
        self.showText.text = content;
    }];
    [self.navigationController pushViewController:scanViewController animated:YES];
}

- (void)btnClickHiden:(UIButton *)btn {
    switch (self.mEventType) {
        case EventTypeTwoCode:
            [self handleTwoCode];
            break;
        case EventTypeGPS:
            
            break;
        case EventTypePhoto:
            
            break;
        case EventTypeToWeex:
            
            break;
        case EventTypeToSesssion:
            
            break;
        case EventTypeToMap:
            
            break;
        default:
            break;
    }
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
