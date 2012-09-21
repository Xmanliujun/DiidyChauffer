//
//  LocationDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "DrivePosition.h"
#import "MapAnnotion.h"
#import "CouponDelegate.h"
@interface LocationDemoViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate> {
    BMKMapView* _mapView;
    
    BMKSearch* _search;
    
    BOOL locationPeson;
    BOOL readonly;
    BOOL firstLoaded;
    UIView                          *_markerView;
    UIImageView                     *_markerTip;
    UIImageView                     *_markerShadow;
    CLLocationCoordinate2D          location;
    CLLocationCoordinate2D         choseLocation;
    UILabel                         *textLabel;
    UIView                          *_glassMenuView;
    
    
    MapAnnotion * mapAnnon;
    DrivePosition * drivePositin;
    
    NSString * driveName;
    NSString * driverMobile;
    double _long;
    double _lat;
    
}
@property (nonatomic, readwrite) BOOL readonly;
@property(nonatomic,assign)id<CouponDelegate>LocationDelegate;
@property (nonatomic, retain) MapAnnotion       *mapAnnon;

//- (void) initWithTitle:(NSString *)drive withSubtitle:(NSString *)mobile withLatitude:(double)lat withLongtitude:(double)lng;
//-(void)backToTheOriginalPosition;

@end

