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
#import "MapViewController.h"



@interface LocationViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property (assign,nonatomic) EventType mEventType;
@property (nonatomic, readwrite, strong) WXSDKInstance *instance;
@property (strong, nonatomic) UIButton *keyBordButton;
@property (strong, nonatomic) WeexModel *weexModel;
@property (strong, nonatomic) UILabel *showText;
@property (strong, nonatomic) UIImageView *imageView;
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
        self.showText.text = @"sessionID";
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
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:contentlab.frame];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    self.imageView.hidden = YES;
    
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
    MapViewController *scanViewController = [[MapViewController alloc] init];
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
             [self handleEventTypeGPS];
            break;
        case EventTypePhoto:
            [self handlePhoto];
            break;
        case EventTypeToWeex:
            
            break;
        case EventTypeToSesssion:
            
            break;
        case EventTypeToMap:
             [self handleEventTypeGPS];
            break;
        default:
            break;
    }
}

- (void)handlePhoto {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //相机
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            if([CommonBaseTools isAvailableCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.allowsEditing = YES;
                [self presentViewController:picker animated:YES completion:nil];
            } else {
//                AppShowTipInfo(@"无法调用摄像头,请检查设置!");
            }
        } else {
            return;
        }
        //相册
    } else if (buttonIndex == 1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            picker.navigationBar.translucent = NO;
            picker.navigationBar.barTintColor = AppColor(@"298def");
            [self presentViewController:picker animated:YES completion:nil];
        } else {
//            AppShowTipInfo(@"无法调用摄像头,请检查设置!");
            return;
        }
        //返回
    } else {
        return;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.imageView.hidden = NO;
    self.imageView.image = image;
//    UIImage *ima = [UIImage fixOrientation:image];
//    UIImage *img = [UIImage imageWithImage:ima scaledToSize:CGSizeMake(100, 100)];
    NSData *m_selectImage ;
    m_selectImage = UIImageJPEGRepresentation(image, 0.01);
    ;
    self.weexModel.weexContent = m_selectImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    UploadParam *upload = [[UploadParam alloc]init];
//    upload.filename = @"userIcon.jpg";
//    upload.name = @"userKey";
//    upload.mimeType = @"image/jpg";
//    upload.data = m_selectImage;
//    upload.m_image = ima;
//    
//    @weakify(self);
//    UpLoadPickerImageAPI *api = [[UpLoadPickerImageAPI alloc] init];
//    api.m_uploadImage = upload;
//    AppShowTipInfo(@"上传头像中..");
//    //    api.showWaitHubInView = self.view;
//    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        @strongify(self);
//        _userModel.userIcon = request.responseJSONObject[@"message"];
//        NSData *data  = [NSKeyedArchiver archivedDataWithRootObject:_userModel];
//        [CommonTools setDataValueForConfigurationKey:UserModel withValue:data];
//        self.pickImage = ima;
    
//        [_tableView reloadData];
//        [MBProgressHUD showSuccess:@"修改成功!" toView:self.view ];
//    } failure:^(__kindof YTKBaseRequest *request) {
//        
//    }];
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
