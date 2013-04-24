//
//  DriveLocationViewController.m
//  DiidyChauffer
//
//  Created by diidy on 12-9-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DriveLocationViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#define NAV_BAR_HEIGHT          44.0
#define NAV_BAR_BLANK_BUTTON    60.0
#define NAV_BAR_BUTTON_MARGIN   7.0
#define NAV_BAR_BUTTON_WIDTH    44.0
#define NAV_BAR_BUTTON_HEIGHT   30.0

#define WIDTH_GLASSMENU_MIN     75
#define WIDTH_GLASSMENU_MAX     300

@interface DriveLocationViewController ()

@end

@implementation DriveLocationViewController


@synthesize readonly,mapAnnon,LocationDelegate,seedrive;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

-(id)init
{
    self = [super init];
    if (self) {
        
      
        
        if (dataArray) {
            
            [dataArray removeAllObjects];
            
        }else{
            
            dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        }
        
        if (mobileArray) {
            
            [mobileArray removeAllObjects];
            
        }else{
        
            mobileArray = [[NSMutableArray alloc] initWithCapacity:0];
        }
        
        if (annArray) {
            
            [annArray removeAllObjects];
            
        }else{
            
            annArray = [[NSMutableArray alloc] initWithCapacity:0];
        }

        
    }
    return self;
}


- (void) initWithTitle:(NSString *)drive withSubtitle:(NSString *)mobile withCLLocation:(NSString *)locati WithTag:(int)tag
{
  
    [dataArray addObject:locati];
    [mobileArray addObject:mobile];
    
    NSArray * geoArray= [locati componentsSeparatedByString:@","];
    double Latitude = [[geoArray objectAtIndex:1] doubleValue];
    double Longtitude = [[geoArray objectAtIndex:0] doubleValue];
    
    driveName = [drive retain];
    driverMobile = [mobile retain];

    BMKCoordinateSpan span;
	
    span.latitudeDelta = 0.01f; //zoom level
    span.longitudeDelta = 0.01f; //zoom level
    
    BMKCoordinateRegion region;
    region.span = span;
    region.center.latitude = Latitude;
    region.center.longitude = Longtitude;
    
    //_mapView.showsUserLocation=YES;
    [_mapView setRegion:region animated:YES];
    
    MapPointAnnotion* driveAnnotation = [[MapPointAnnotion alloc]init];
    driveAnnotation.tag = tag;
    CLLocationCoordinate2D coor;
    coor.latitude = Latitude;
    coor.longitude = Longtitude;
    driveAnnotation.coordinate = coor;
        
    driveAnnotation.title = drive;
    driveAnnotation.subtitle = @"呼叫我";
        
    [_mapView selectAnnotation:driveAnnotation animated:NO];
    [_mapView addAnnotation: driveAnnotation];
     [annArray addObject:driveAnnotation];
    [driveAnnotation release];
        
}

-(void)backToTheOriginalPosition
{
    
    if (![ShareApp connectedToNetwork]) {
        
       
    }else{
       
        self.seedrive = YES;
         _mapView.showsUserLocation=YES;
    
    }
}
- (void)setCurrentLocation{
    
    BMKCoordinateRegion region ;
    region.center = mapAnnon.coordinate;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [_mapView setRegion:region animated:YES];
}

-(void)cantLocateAlert:(NSString *)errorMsg{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" 
                                                        message:errorMsg 
                                                       delegate:self
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
    
    if (error == 0) {
        
        item = [[MapPointAnnotion alloc]init];
        item.tag =100;
		item.coordinate = result.geoPt;
		item.title =@"我的位置";
        item.subtitle= result.strAddr;
		[_mapView addAnnotation:item];
		
    }
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{

    if (userLocation != nil) {
		
        CLLocationCoordinate2D center;
        center.latitude = userLocation.location.coordinate.latitude;
        center.longitude = userLocation.location.coordinate.longitude;
        location = center;
        
        BMKCoordinateSpan span;
        span.latitudeDelta = 0.01f; //zoom level
        span.longitudeDelta = 0.01f; //zoom level
        
        BMKCoordinateRegion region;
        region.span = span;
        region.center = userLocation.location.coordinate;
        
         _mapView.showsUserLocation=NO;
         if (self.seedrive) {
             
             [_mapView setRegion:region animated:YES];
             // NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
             if (item) {
                 
                [_mapView removeAnnotation:item];
                 item=nil;
                 
             }
            
             //                        array = [NSArray arrayWithArray:_mapView.overlays];
             //                      [_mapView removeOverlays:array];
             
             CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
             
             pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
             
             BOOL flag = [_search reverseGeocode:pt];
             
             if (!flag) {
                 
                 NSLog(@"search failed!");
                 
            }else{
         
         }
         
//                      // NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//                      [_mapView removeAnnotation:item];
////                        array = [NSArray arrayWithArray:_mapView.overlays];
////                      [_mapView removeOverlays:array];
//         
//                        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
//                       
//                            pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
//                        
//                        BOOL flag = [_search reverseGeocode:pt];
//                        
//                        if (!flag) {
//                            
//                           NSLog(@"search failed!");
             
            }
        
        }
}

- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
	if (error != nil)
        
		NSLog(@"locate failed: %@", [error localizedDescription]);
    
	else {
        
		NSLog(@"locate failed");
        
	}
    
    
    NSString *errorMessage;
    
    errorMessage = @"定位失败";
    
    [self cantLocateAlert:errorMessage];
	
}

- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView{

   
//    BMKUserLocation *userLocation = mapView.userLocation;
//    userLocation.title = @"我的位置";
//    [_mapView addAnnotation:userLocation];
    
}

-(void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for (int i= 0; i<[views count]; i++) {

        BMKAnnotationView *ss = [views objectAtIndex:i];
        if ([ss.annotation.title isEqualToString:@"我的位置"]) {
            
        }else{
       
            [_mapView selectAnnotation:ss.annotation animated:NO];
        }
        
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
   if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        MapPointAnnotion* pointAnnotation=(MapPointAnnotion*)annotation;
        NSString *AnnotationViewID = [NSString stringWithFormat:@"iAnnotation-%i",pointAnnotation.tag+1];
       
		BMKPinAnnotationView *newAnnotation = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID]autorelease];
        if (pointAnnotation.tag !=100) {
            
            newAnnotation.pinColor = BMKPinAnnotationColorPurple;
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            rightButton.tag=pointAnnotation.tag+40;
            [rightButton addTarget:self action:@selector(telDrive:) forControlEvents:UIControlEventTouchUpInside];
            [newAnnotation setCanShowCallout:YES]; //点击能否显示
            [newAnnotation setRightCalloutAccessoryView:rightButton];
            
        }else{
            
            newAnnotation.pinColor = BMKPinAnnotationColorRed;
        }
		newAnnotation.animatesDrop = NO;
		newAnnotation.draggable = NO;
    
       
		return newAnnotation;   
	}    
    return nil;
}

#pragma Button Call
-(void)selectTheCurrentLocation:(id)sender
{
   // [LocationDelegate selectTheCurrentLocationOnLine:textLabel.text];
    
}
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
   // [_mapView selectAnnotation:driveAnnotation animated:NO];
   // view.selected = YES;
  // [_mapView selectAnnotation:view.annotation animated:NO];
    
}

-(void)seeDrive:(int)buttonMA
{
    self.seedrive = YES;
    NSArray * geoArray= [[dataArray objectAtIndex:buttonMA] componentsSeparatedByString:@","];
   
    double Latitude = [[geoArray objectAtIndex:1] doubleValue];
    double Longtitude = [[geoArray objectAtIndex:0] doubleValue];
    
    BMKCoordinateSpan span;
	
    span.latitudeDelta = 0.01f; //zoom level
    span.longitudeDelta = 0.01f; //zoom level
    
    BMKCoordinateRegion region;
    region.span = span;
    region.center.latitude = Latitude;
    region.center.longitude = Longtitude;
    
    //_mapView.showsUserLocation=YES;
    [_mapView setRegion:region animated:YES];
  
    MapPointAnnotion* driveAnnotation = [annArray objectAtIndex:buttonMA];
    [_mapView selectAnnotation:driveAnnotation animated:NO];
    
    
}
-(void)telDrive:(UIButton*)sender
{
    NSLog(@"%@",[mobileArray objectAtIndex:sender.tag-40]);
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSString * telMobile = [NSString stringWithFormat:@"tel:%@",[mobileArray objectAtIndex:sender.tag-40]];
    NSURL *telURL =[NSURL URLWithString:telMobile];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
    [callWebview release];

}
#pragma mark - System Approach
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.seedrive=YES;
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 360)];
    _mapView.delegate = self;
    //_mapView.exclusiveTouch = YES;
	_mapView.showsUserLocation = YES;
    _mapView.userInteractionEnabled = YES;
   // [_mapView setZoomEnabled: YES];
    [_mapView setScrollEnabled:YES];
    [self.view addSubview:_mapView];
    
    _search = [[BMKSearch alloc]init];
	_search.delegate = self;
	
}
-(void)viewDidDisappear:(BOOL)animated
{
    _mapView.showsUserLocation = NO;
    
}

- (void)dealloc {
    
    if (_mapView) {
        
         _mapView.delegate=nil;
        [_mapView release];

        
    }
    _search.delegate=nil;
   
    [annArray release];
    [mobileArray release];
    [dataArray release];
    [item release];
    [_search release];
    [drivePositin release];
    [driveName release];
    [driverMobile release];
    [mapAnnon release];
    //[_markerView release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
     return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }


@end
