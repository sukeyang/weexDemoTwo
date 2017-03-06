//
//  BaseViewController.h
//  weexDemo
//
//  Created by yangshuo on 17/3/6.
//  Copyright © 2017年 JLRC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (copy, nonatomic) AppBasicBlock callBlock;

- (void)setUpBasicBlock:(AppBasicBlock)block;
@end
