//
//  DriveLocationViewController.m
//  DiidyChauffer
//
//  Created by diidy on 12-9-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DriveLocationViewController.h"


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


@synthesize readonly,mapAnnon,LocationDelegate;
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

- (void) initWithTitle:(NSString *)drive withSubtitle:(NSString *)mobile withLatitude:(double)lat withLongtitude:(double)lng
{//39.915101, 116.403981  
    driveName = [drive retain];
    driverMobile = [mobile retain];
    _lat =lat;
    _long = lng;

    driveAnnotation = [[BMKPointAnnotation alloc]init];
	CLLocationCoordinate2D coor;
	coor.latitude = lat;
	coor.longitude = lng;
	 driveAnnotation.coordinate = coor;
	
	 driveAnnotation.title = @"司机";
	 driveAnnotation.subtitle = @"呼叫我";
	[_mapView addAnnotation: driveAnnotation];
    
}

-(void)backToTheOriginalPosition
{
    BMKCoordinateSpan span;
	
    span.latitudeDelta = 0.01f; //zoom level
    span.longitudeDelta = 0.01f; //zoom level
    
    NSLog(@"%f",location.latitude);
    NSLog(@"%f",location.longitude);
    
    BMKCoordinateRegion region;
    region.span = span;
    region.center = location;
    
     _mapView.showsUserLocation=YES;
    [_mapView setRegion:region animated:YES];
    
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
        
        CLLocationCoordinate2D center;
        center = result.geoPt;
        NSLog(@"%f",center.latitude);
        
        item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.geoPt;
        item.title = result.strAddr;
        [_mapView addAnnotation:item];
        [item release];
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
        
       
//                       NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//                      [_mapView removeAnnotations:array];
//                        array = [NSArray arrayWithArray:_mapView.overlays];
//                    [_mapView removeOverlays:array];
                
                        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
                       
                            pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
                        
                        BOOL flag = [_search reverseGeocode:pt];
                        
                        if (!flag) {
                           NSLog(@"search failed!");
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
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSLog(@"diOYONG");
	if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
		BMKPinAnnotationView *newAnnotation = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"]autorelease];   
		newAnnotation.pinColor = BMKPinAnnotationColorPurple;   
		newAnnotation.animatesDrop = YES;
		newAnnotation.draggable = YES;
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self action:@selector(telDrive:) forControlEvents:UIControlEventTouchUpInside];
        [newAnnotation setCanShowCallout:YES]; //点击能否显示
        [newAnnotation setRightCalloutAccessoryView:rightButton];
		return newAnnotation;   
	}
    
    
        
   
	return nil;
}


#pragma Button Call
-(void)selectTheCurrentLocation:(id)sender
{
   // [LocationDelegate selectTheCurrentLocationOnLine:textLabel.text];
    
}

-(void)telDrive:(id)sender
{ 
    
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:driverMobile];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
    [callWebview release];

}
#pragma mark - System Approach
- (void)viewDidLoad {
    [super viewDidLoad];
    
   _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 340)];
    _mapView.delegate = self;
	
	_mapView.showsUserLocation = YES;
    [_mapView setZoomEnabled: YES];
    [_mapView setScrollEnabled:YES];
    
    [self.view addSubview:_mapView];
    
     
    _search = [[BMKSearch alloc]init];
	_search.delegate = self;
	
}

- (void)dealloc {
    [_search release];
    [drivePositin release];
    [driveName release];
    [driverMobile release];
    [_mapView release];
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

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma NO  Use
//-(void)createMarker{
//    
//    
//    if(!_markerView){
//        CGRect f = _mapView.frame;
//        NSLog(@"saxxx%f %f",f.origin.x,f.origin.y);
//        _markerView = [[UIView alloc] initWithFrame:CGRectMake(f.origin.x + f.size.width/2,
//                                                               f.origin.y + f.size.height/2, 
//                                                               32, 36)];
//        _markerView.backgroundColor = [UIColor clearColor];
//        _markerTip = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
//        [_markerTip setImage:[UIImage imageNamed:@"btn_map_current1.png"]];
//        [_markerView addSubview:_markerTip];
//        
//        _markerShadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 32, 32, 4)];
//        //  [_markerShadow setImage:[UIImage imageNamed:@"u923_normal.png"]];
//        // [_markerView addSubview:_markerShadow];
//        
//        [self glassMenuWithLoadingStyle];
//        
//        [self.view addSubview:_markerView];
//    }
//}

//-(void)animateMarker:(void (^)())completed
//{
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         [_markerTip setFrame:CGRectMake(0, -16, 32, 32)];
//                         [_markerShadow setFrame:CGRectMake(16, 34, 0, 0)];
//                     } 
//                     completion:^(BOOL finished) {
//                         
//                         [UIView animateWithDuration:0.2
//                                          animations:^{
//                                              [_markerTip setFrame:CGRectMake(0, 0, 32, 32)];
//                                              [_markerShadow setFrame:CGRectMake(0, 32, 32, 4)];
//                                          } 
//                                          completion:^(BOOL finished) {
//                                              completed();
//                                          }];
//                     }];
//}
//-(void)glassMenuWithLoadingStyle{
//    if(_glassMenuView) {
//        [_glassMenuView removeFromSuperview];
//        _glassMenuView = nil;
//    }
//    NSLog(@"中心   %f",_mapView.center.x);
//    _glassMenuView = [[UIView alloc] initWithFrame:CGRectMake(-15, -50, 60, 60)];
//    _glassMenuView.backgroundColor = [UIColor blackColor];
//    
//    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    [indicatorView setFrame:CGRectMake(26, 26, 20, 20)];
//    indicatorView.hidesWhenStopped = YES;
//    [indicatorView startAnimating];
//    [_glassMenuView addSubview:indicatorView];
//    [indicatorView release];
//    
//    _markerView.backgroundColor = [UIColor clearColor];
//    [_markerView addSubview:_glassMenuView];
//}
//-(void)glassMenuWithContent:(NSString *)text{
//    
//    if(_glassMenuView) {
//        [_glassMenuView removeFromSuperview];
//        _glassMenuView = nil;
//    }
//    
//    CGSize fontSize = [text sizeWithFont:[UIFont systemFontOfSize:12]];
//    CGFloat width = 0;
//    if(fontSize.width + 30 < WIDTH_GLASSMENU_MIN){
//        width = WIDTH_GLASSMENU_MIN;
//    }
//    else if(fontSize.width + 30 > WIDTH_GLASSMENU_MAX){
//        width = WIDTH_GLASSMENU_MAX;
//    }else {
//        width = fontSize.width + 30;
//    }
//    // CGFloat borderWidth = width/2 - 11;
//    CGRect f = _mapView.frame;
//    _markerView = [[UIView alloc] initWithFrame:CGRectMake(f.origin.x + f.size.width/2 ,
//                                                           f.origin.y + f.size.height/2, 
//                                                           200, 80)];
//    UIImage *glassMenuImgMid = [UIImage imageNamed:@"main_map_loinbg_fold.9.png"];
//    
//    UIImageView * newinmage = [[UIImageView alloc] initWithImage:glassMenuImgMid];
//    newinmage.frame =CGRectMake(0, 0, 200, 60);
//    newinmage.userInteractionEnabled = YES;
//    
//    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    newButton.frame = CGRectMake(140, 5, 60, 40);
//    [newButton setImage:[UIImage imageNamed:@"u118_normal.png"] forState:UIControlStateNormal];
//    [newButton addTarget:self action:@selector(selectTheCurrentLocation:) forControlEvents:UIControlEventTouchUpInside];
//    _glassMenuView = [[UIView alloc] initWithFrame:CGRectMake(f.origin.x + f.size.width/2-86, f.origin.y + f.size.height/2-53, 200, 60)];
//    _glassMenuView.backgroundColor = [UIColor clearColor];
//    textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _glassMenuView.frame.size.width - 50, 60)];
//    textLabel.backgroundColor = [UIColor clearColor];
//    textLabel.numberOfLines = 0;
//    [textLabel setFont:[UIFont systemFontOfSize:12]];
//    [textLabel setTextColor:[UIColor whiteColor]];
//    [textLabel setTextAlignment:UITextAlignmentCenter];
//    [textLabel setText:text];
//    [newinmage addSubview:textLabel];
//    [textLabel release];   
//    [newinmage addSubview:newButton];
//    [_glassMenuView addSubview:newinmage];
//    
//    [self.view addSubview:_glassMenuView];
//    
//    
//}

//-(void)searchAddress:(CLLocationCoordinate2D)centerLocation {
//    
//    [self animateMarker:^{
//        [self glassMenuWithLoadingStyle];
//        if(_search != nil){
//            
//            CLLocation *l = [[CLLocation alloc] initWithLatitude:centerLocation.latitude longitude:centerLocation.longitude];
//            CLLocationCoordinate2D pt = (CLLocationCoordinate2D){39.915101, 116.403981};
//            //mapAnnon = [[MapAnnotion alloc] initWithCoordinate:l.coordinate andAddress:@""];
//            drivePositin = [[DrivePosition alloc] initWithTitle:@"beijing" withSubtitle:@"12222222" withLatitude:pt.latitude withLongtitude:pt.longitude];
//            
//            BOOL flag = [_search reverseGeocode:pt];
//            
//            if (!flag) {
//                [self glassMenuWithContent:@"无法定位当前位置"];
//            }
//        }}];
//    
//}


@end
