//
//  LocationViewController.h
//  weexDemo
//
//  Created by yang shuo on 2017/2/28.
//  Copyright © 2017年 JLRC. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, EventType) {
    EventTypeTwoCode,
    EventTypeGPS,
    EventTypePhoto,
    EventTypeToWeex,
};

@interface LocationViewController : UIViewController

@property (strong, nonatomic) NSString *URLString;

@end
