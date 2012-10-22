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
#import "MapPointAnnotion.h"
@interface LocationDemoViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate> {
    BMKMapView* _mapView;
    
    BMKSearch* _search;
    MapAnnotion * mapAnnon;
    DrivePosition * drivePositin;
    MapPointAnnotion* item ;
    BOOL locationPeson;
    BOOL readonly;
    BOOL firstLoaded;
    BOOL UpdateUserLocation;
    BOOL firstCreat;
    BOOL firstMenue;
   
    UIView                          *_markerView;
    UIImageView                     *_markerTip;
    UIImageView                     *_markerShadow;
    CLLocationCoordinate2D          location;
    CLLocationCoordinate2D         choseLocation;
    UILabel                         *textLabel;
    UIView                          *_glassMenuView;

}
@property(nonatomic,retain)NSString*path;
@property (nonatomic, readwrite) BOOL readonly;
@property(nonatomic,assign)id<CouponDelegate>LocationDelegate;
@property (nonatomic, retain) MapAnnotion       *mapAnnon;
@property(nonatomic,assign)CLLocationCoordinate2D possibleLoca;
@property(nonatomic,assign)BOOL possible;
@property(nonatomic,retain)NSString*nowCityName;
-(void)backToTheOriginalPosition;
- (id) initWithPossible:(BOOL)possibleM withLocation:(CLLocationCoordinate2D )Latitudelong withCityName:(NSString*)cityNa;

@end

