//
//  MapViewController.m
//  weexDemo
//
//  Created by yangshuo on 17/3/6.
//  Copyright © 2017年 JLRC. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "BasicMapAnnotation.h"

@interface MapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic, retain) MKMapView* mapView;
@property(nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, AppScreenWidth, AppScreenWidth)];
    self.mapView.delegate = self;
    self.mapView.userInteractionEnabled = YES;
    [self.view addSubview:self.mapView];
    self.mapView.mapType = MKMapTypeStandard;
    
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    self.locationManager = [CLLocationManager new];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.distanceFilter = 30;
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager startUpdatingLocation];
}

- (void)dealloc {
    [self stopSingificantChangeUpdates];
}

- (void)stopSingificantChangeUpdates {
    if(_locationManager){
        [_locationManager stopUpdatingLocation];
    }
    _locationManager.delegate = nil;
    _mapView.delegate = nil;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self.locationManager stopUpdatingLocation];
    
    NSString *strLat = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.latitude];
    NSString *strLng = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.longitude];
    NSLog(@"Lat: %@  Lng: %@", strLat, strLng);
    
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    NSDictionary *dict = @{@"latitude":@(coordinate.latitude),@"longitude":@(coordinate.longitude)};
    NSString *valueString = [dict yy_modelToJSONString];
    
    if (self.callBlock) {
        self.callBlock(valueString);
    }
    
}

- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error {
    [manager stopUpdatingLocation];
    switch([error code]) {
        case kCLErrorDenied:
            [self openGPSTips];
            break;
        case kCLErrorLocationUnknown:
            break;
        default:
            break;
    }
}

- (void)openGPSTips{
    UIAlertView *alet = [[UIAlertView alloc] initWithTitle:@"当前定位服务不可用" message:@"请到“设置->隐私->定位服务”中开启定位" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alet show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    NSLog(@"0--------------------%@",userLocation);

  
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    
}

- (void)mapView:(MKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews {
    //    NSLog(@"%@ ----- %@", self, NSStringFromSelector(_cmd));
    //    NSLog(@"overlayViews: %@", overlayViews);
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    //    NSLog(@"%@ ----- %@", self, NSStringFromSelector(_cmd));
    MKOverlayView* overlayView = nil;
    if([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView* m_routeLineView= [[MKPolylineView alloc] initWithPolyline:overlay] ;
        m_routeLineView.fillColor = AppColor(@"057dff");
        m_routeLineView.strokeColor = AppColor(@"057dff");
        m_routeLineView.lineWidth = 8;
        
        //虚线开关
        MKPolyline *lineoverlay = (MKPolyline *)overlay;
        if([lineoverlay.title isEqualToString:@"1"]){
            lineoverlay.title = nil;
            m_routeLineView.lineDashPhase = 20;
            NSArray* array = [NSArray arrayWithObjects:[NSNumber numberWithInt:20],[NSNumber numberWithInt:20],nil];
            m_routeLineView.lineDashPattern = array;
            
        }else{
            lineoverlay.title = nil;
            m_routeLineView.lineDashPhase = 0;
            m_routeLineView.lineDashPattern = nil;
        }
        
        overlayView = m_routeLineView;
    }
    
    return overlayView;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BasicMapAnnotation class]]) {
        BasicMapAnnotation *basicMapAnnotation = (BasicMapAnnotation *)annotation;
        MKAnnotationView *annotationView =[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:@"CustomAnnotation"] ;
            annotationView.canShowCallout = YES;
        }
        
        if(basicMapAnnotation.tag == 111){
            annotationView.image = [UIImage imageNamed:@"common.bundle/move/startPoint.png"];
        }else if(basicMapAnnotation.tag == 110){
            annotationView.image = [UIImage imageNamed:@"common.bundle/move/endPoint.png"];
        }
        
        return annotationView;//[annotationView autorelease];
    }else{
        
        
    }
    
    return nil;
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
