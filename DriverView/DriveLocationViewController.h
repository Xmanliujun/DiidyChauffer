//
//  DriveLocationViewController.h
//  DiidyChauffer
//
//  Created by diidy on 12-9-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "DrivePosition.h"
#import "MapAnnotion.h"
#import "CouponDelegate.h"
#import "MapPointAnnotion.h"
@interface DriveLocationViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate>
{
    BMKMapView* _mapView;
    BMKSearch* _search;
    MapAnnotion * mapAnnon;
    DrivePosition * drivePositin;
    MapPointAnnotion* item;
   // MapPointAnnotion* driveAnnotation;
    BOOL locationPeson;
    BOOL readonly;
    BOOL firstLoaded;
    
    CLLocationCoordinate2D          location;
      
    NSString * driveName;
    NSString * driverMobile;
    
    NSMutableArray*dataArray;
    NSMutableArray*mobileArray;
     NSMutableArray*annArray;
   
}

@property (nonatomic, readwrite) BOOL readonly;

@property (nonatomic, readwrite) BOOL seedrive;
@property(nonatomic,assign)id<CouponDelegate>LocationDelegate;
@property (nonatomic, retain) MapAnnotion *mapAnnon;

- (void) initWithTitle:(NSString *)drive withSubtitle:(NSString *)mobile withCLLocation:(NSString*)locati WithTag:(int)tag;
-(void)backToTheOriginalPosition;
-(void)seeDrive:(int)buttonMA;
@end
