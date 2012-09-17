//
//  MapViewController.h
//  EnterpriseIM
//
//  Created by Tjatse on 12-6-4.
//  Copyright (c) 2012年 MceSky. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import "MapLocationDelegate.h"
#import "ASIHTTPRequest.h"
#import "DriverPostion.h"
@class MyMapAnnotation;

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate, MKReverseGeocoderDelegate,UIAlertViewDelegate> {
	
	IBOutlet MKMapView              *mapView;
    CLLocationManager               *locationManager;
    UIView                          *_markerView;
    UIImageView                     *_markerTip;
    UIImageView                     *_markerShadow;
    UIView                          *_glassMenuView;
    MKReverseGeocoder               *_mkGeocoder;
    CLGeocoder                      *_clGeocoder;
    CLLocationCoordinate2D          location;
    BOOL                            firstLoaded;
    
    UIButton                        *_buttonSubmit;
    MyMapAnnotation                 *annotation;
    
    NSObject<MapLocationDelegate>   *delegate;
    
    __block ASIHTTPRequest          *requestToGoogleMap;
   //  __block ASIHTTPRequest          *requestToGoogleMap;
    
    BOOL                            readonly;
    UILabel *textLabel;
    
    DriverPostion *drivePosition;
    NSString * driveName;
    NSString * driverMobile;
    double _long;
    double _lat;
    
}
@property (nonatomic, retain) IBOutlet MKMapView    *mapView;
@property (nonatomic, retain) CLLocationManager     *locationManager;
@property (nonatomic, retain) NSObject<MapLocationDelegate>     *delegate;
@property(nonatomic,assign)id<MapLocationDelegate>LocationDelegate;
@property (nonatomic, readwrite) BOOL               readonly;
@property (nonatomic, retain) MyMapAnnotation       *annotation;

- (void) initWithTitle:(NSString *)drive withSubtitle:(NSString *)mobile withLatitude:(double)lat withLongtitude:(double)lng;
-(void)backToTheOriginalPosition;
@end
