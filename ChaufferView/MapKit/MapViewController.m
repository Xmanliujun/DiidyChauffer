//
//  MapViewController.m
//  EnterpriseIM
//
//  Created by Tjatse on 12-6-4.
//  Copyright (c) 2012年 MceSky. All rights reserved.
//

#import "MapViewController.h"
#import "MyMapAnnotation.h"


#define NAV_BAR_HEIGHT          44.0
#define NAV_BAR_BLANK_BUTTON    60.0
#define NAV_BAR_BUTTON_MARGIN   7.0
#define NAV_BAR_BUTTON_WIDTH    44.0
#define NAV_BAR_BUTTON_HEIGHT   30.0

#define WIDTH_GLASSMENU_MIN     75
#define WIDTH_GLASSMENU_MAX     300

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize readonly;
@synthesize mapView;
@synthesize locationManager;
@synthesize delegate;
@synthesize annotation;
@synthesize LocationDelegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) initWithTitle:(NSString *)drive withSubtitle:(NSString *)mobile withLatitude:(double)lat withLongtitude:(double)lng
{
    
    
    driveName = [drive retain];
    driverMobile = [mobile retain];
    _lat =lat;
    _long = lng;
    drivePosition = [[DriverPostion alloc] initWithTitle:driveName withSubtitle:driverMobile withLatitude:_lat withLongtitude:_long];
    
    NSLog(@"%f",lng);
    NSLog(@"%f",lat);
    [mapView addAnnotation:drivePosition];
   
}
-(void)backToTheOriginalPosition
{
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01f; //zoom level
    span.longitudeDelta = 0.01f; //zoom level
    
    NSLog(@"%f",location.latitude);
    NSLog(@"%f",location.longitude);
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = location;
    
    // map.showsUserLocation=NO;
    [mapView setRegion:region animated:YES];


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // [self loadNavButton];
    
	[mapView setMapType:MKMapTypeStandard];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
    
	mapView.showsUserLocation = NO;
	//[mapView setRegion:region animated:YES]; 
	[mapView setDelegate:self];
    if(self.readonly){
        [_buttonSubmit setHidden:YES];
        [self setCurrentLocation];
        if(self.annotation.address == nil || [self.annotation.address length] == 0){
            self.annotation.address = @"搜索中...";
        }
        
        [mapView addAnnotation:self.annotation];
        return;
    }
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    locationManager.distanceFilter = 1000;
    [locationManager startUpdatingLocation];
    
    Class clgClass = NSClassFromString(@"CLGeocoder");
    if(clgClass != nil){
        if(!_clGeocoder){
            _clGeocoder = [[clgClass alloc] init];
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    if(_clGeocoder != nil){
        [_clGeocoder cancelGeocode];
    }

    if(_mkGeocoder != nil){
        [_mkGeocoder cancel];
    }
    if(requestToGoogleMap != nil && [requestToGoogleMap isExecuting]){
        [requestToGoogleMap cancel];
        [requestToGoogleMap release];
        requestToGoogleMap = nil;
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc{
    [mapView release];
    [locationManager release];
    
    if(_clGeocoder != nil){
        [_clGeocoder cancelGeocode];
        [_clGeocoder release];
        _clGeocoder  = nil;
    }
    
    if(_mkGeocoder != nil){
        [_mkGeocoder cancel];
        [_mkGeocoder release];
        _mkGeocoder = nil;
    }
    [_markerView release];
    [_glassMenuView release];
    [_buttonSubmit release];
    
    [super dealloc];
}
#pragma mark -Nav Button
-(void)setSubmitEnable:(BOOL)enabled{
    if(!enabled){
        _buttonSubmit.alpha = 0.5;
        _buttonSubmit.enabled = NO;
    }else{
        _buttonSubmit.alpha = 1;
        _buttonSubmit.enabled = YES;
    }
}
-(void)actionSubmit:(id)sender{
    
    if(_clGeocoder != nil){
        [_clGeocoder cancelGeocode];
    }
    
    if(_mkGeocoder != nil){
        [_mkGeocoder cancel];
    }
    if(requestToGoogleMap != nil && [requestToGoogleMap isExecuting]){
        [requestToGoogleMap cancel];
    }
    if(annotation){
        [self.delegate postLocation:[annotation retain]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -Marker init
-(void)createMarker{
    if(!_markerView){
        CGRect f = self.mapView.frame;
        _markerView = [[UIView alloc] initWithFrame:CGRectMake(f.origin.x + f.size.width/2 - 16,
                                                               f.origin.y + f.size.height/2 - 16, 
                                                               32, 36)];
        _markerView.backgroundColor = [UIColor clearColor];
        _markerTip = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
        [_markerTip setImage:[UIImage imageNamed:@"btn_map_current1.png"]];
        [_markerView addSubview:_markerTip];
        
        _markerShadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 32, 32, 4)];
      //  [_markerShadow setImage:[UIImage imageNamed:@"u923_normal.png"]];
       // [_markerView addSubview:_markerShadow];
        
        [self glassMenuWithLoadingStyle];
        
        [self.view addSubview:_markerView];
    }
}
-(void)animateMarker:(void (^)())completed
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [_markerTip setFrame:CGRectMake(0, -16, 32, 32)];
                         [_markerShadow setFrame:CGRectMake(16, 34, 0, 0)];
                     } 
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              [_markerTip setFrame:CGRectMake(0, 0, 32, 32)];
                                              [_markerShadow setFrame:CGRectMake(0, 32, 32, 4)];
                                          } 
                                          completion:^(BOOL finished) {
                                              completed();
                                          }];
                     }];
}
-(void)glassMenuWithLoadingStyle{
    if(_glassMenuView) {
        [_glassMenuView removeFromSuperview];
        _glassMenuView = nil;
    }
//    UIImage *glassMenuImgLeft = [UIImage imageNamed:@"main_map_loinbg_fold.9.png"];
//    UIImage *glassMenuImgRight = [UIImage imageNamed:@"main_map_loinbg_fold.9.png"];
//    UIImage *glassMenuImgMid = [UIImage imageNamed:@"main_map_loinbg_fold.9.png"];
   
   
    
    _glassMenuView = [[UIView alloc] initWithFrame:CGRectMake(-21, -70, 74, 80)];
    _glassMenuView.backgroundColor = [UIColor clearColor];
       
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicatorView setFrame:CGRectMake(26, 26, 20, 20)];
    indicatorView.hidesWhenStopped = YES;
    [indicatorView startAnimating];
    [_glassMenuView addSubview:indicatorView];
    [indicatorView release];
    
    _markerView.backgroundColor = [UIColor clearColor];
    [_markerView addSubview:_glassMenuView];
}
-(void)glassMenuWithContent:(NSString *)text{
    
    if(_glassMenuView) {
        [_glassMenuView removeFromSuperview];
        _glassMenuView = nil;
    }
    
    CGSize fontSize = [text sizeWithFont:[UIFont systemFontOfSize:12]];
    CGFloat width = 0;
    if(fontSize.width + 30 < WIDTH_GLASSMENU_MIN){
        width = WIDTH_GLASSMENU_MIN;
    }
    else if(fontSize.width + 30 > WIDTH_GLASSMENU_MAX){
        width = WIDTH_GLASSMENU_MAX;
    }else {
        width = fontSize.width + 30;
    }
   // CGFloat borderWidth = width/2 - 11;
    CGRect f = self.mapView.frame;
    NSLog(@" x: %f   y:%f",f.origin.x,f.origin.y);
    _markerView = [[UIView alloc] initWithFrame:CGRectMake(f.origin.x + f.size.width/2 ,
                                                           f.origin.y + f.size.height/2, 
                                                           200, 80)];
    //    UIImage *glassMenuImgLeft = [UIImage imageNamed:@"btn_map_current1.png"];
//    UIImage *glassMenuImgRight = [UIImage imageNamed:@"right_orange.png"];
    UIImage *glassMenuImgMid = [UIImage imageNamed:@"main_map_loinbg_fold.9.png"];
    
    UIImageView * new = [[UIImageView alloc] initWithImage:glassMenuImgMid];
    new.frame =CGRectMake(0, 0, 200, 60);
    new.userInteractionEnabled = YES;
    
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newButton.frame = CGRectMake(140, 5, 60, 40);
    [newButton setImage:[UIImage imageNamed:@"u118_normal.png"] forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(selectTheCurrentLocation:) forControlEvents:UIControlEventTouchUpInside];
    _glassMenuView = [[UIView alloc] initWithFrame:CGRectMake(60, 95, 200, 60)];
    
   //  _glassMenuView = [[UIView alloc] initWithFrame:CGRectMake(f.origin.x + f.size.width/2-100, f.origin.y + f.size.height/2 -10-60, 200, 60)];
     NSLog(@"glass  %f",_glassMenuView.frame.origin.y);

//    UIImageView *imgViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, borderWidth, 80)];
//    glassMenuImgLeft = [glassMenuImgLeft stretchableImageWithLeftCapWidth:26 topCapHeight:0];
//    [imgViewLeft setImage:glassMenuImgLeft];  
//   // [_glassMenuView addSubview:imgViewLeft];
//    [imgViewLeft release];
//    
//    UIImageView *imgViewMid = [[UIImageView alloc] initWithFrame:CGRectMake(borderWidth, -5, 22, 80)];
//    [imgViewMid setImage:glassMenuImgMid];  
//   // [_glassMenuView addSubview:imgViewMid];
//    [imgViewMid release];
//    
//    UIImageView *imgViewRight = [[UIImageView alloc] initWithFrame:CGRectMake(borderWidth + 22, 0, borderWidth, 80)];
//    glassMenuImgRight = [glassMenuImgRight stretchableImageWithLeftCapWidth:12 topCapHeight:0];
//    [imgViewRight setImage:glassMenuImgRight];  
//    //[_glassMenuView addSubview:imgViewRight];
//    [imgViewRight release];
    _glassMenuView.backgroundColor = [UIColor clearColor];
    textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _glassMenuView.frame.size.width - 50, 60)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.numberOfLines = 0;
    [textLabel setFont:[UIFont systemFontOfSize:12]];
    [textLabel setTextColor:[UIColor whiteColor]];
    [textLabel setTextAlignment:UITextAlignmentCenter];
    [textLabel setText:text];
    [new addSubview:textLabel];
    [textLabel release];   
    [new addSubview:newButton];
    [_glassMenuView addSubview:new];
   
   [self.view addSubview:_glassMenuView];
   // [_markerView addSubview:_glassMenuView];
    
}

-(void)selectTheCurrentLocation:(id)sender
{
    
    [LocationDelegate selectTheCurrentLocationOnLine:textLabel.text];

}
#pragma mark -Core Location Delegate Methods

-(void)displaysTheCurrentPosition:(NSString*)currentTitle currntLocation:(MKCoordinateRegion)currentRegin
{

    DisplayMapAnnotation *ann = [[DisplayMapAnnotation alloc] init]; 
	ann.title = @"我的位置";
	ann.subtitle = currentTitle; 
	ann.coordinate = currentRegin.center; 
	[mapView addAnnotation:ann];

}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    location = [newLocation coordinate];
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01f; //zoom level
    span.longitudeDelta = 0.01f; //zoom level
    
    NSLog(@"%f",location.latitude);
    NSLog(@"%f",location.longitude);
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = location;
    
    // map.showsUserLocation=NO;
    [mapView setRegion:region animated:YES];
    [mapView regionThatFits:region];    
    firstLoaded = YES;
    
    if(_clGeocoder){
        [_clGeocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            NSLog(@"%@",placemarks);if([placemarks count] > 0 && error == nil){
                
                CLPlacemark *mark = (CLPlacemark *)[placemarks objectAtIndex:0];
                NSDictionary *addressDic = mark.addressDictionary;
                
                NSString *address = [NSString stringWithFormat:@"%@", [addressDic objectForKey:@"Name"]];
                [self displaysTheCurrentPosition:address currntLocation:region];
            }
        }];
    }else{
        _mkGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:location];
        [_mkGeocoder setDelegate:self];
        [_mkGeocoder start];
    }
     
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    
    NSString *errorMessage;
    if ([error code] == kCLErrorDenied){
        errorMessage = @"被拒绝访问";
    }
    
    if ([error code] == kCLErrorLocationUnknown) {
        errorMessage = @"无法获取位置";
    }
    
    [self cantLocateAlert:errorMessage];
    
}

- (void)setCurrentLocation{
    
    MKCoordinateRegion region ;
    
    region.center = annotation.coordinate;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [mapView setRegion:region animated:YES];
}
#pragma mark - MapView
-(void)cantLocateAlert:(NSString *)errorMsg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" 
                                                        message:errorMsg 
                                                       delegate:self
                                              cancelButtonTitle:@"确定" 
                                              otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}
-(void)mapViewDidFailLoadingMap:(MKMapView *)theMapView withError:(NSError *)error
{
    [self cantLocateAlert:@"无法加载地图"];
}
-(void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [self cantLocateAlert:@"无法定位当前位置"];
}

-(MKAnnotationView *)mapView:(MKMapView *)theMapView 
           viewForAnnotation:(id <MKAnnotation>)theAnnotation 
{
    
    if ([theAnnotation isKindOfClass:[DriverPostion class]]) {
        NSString *mapID = @"MyMapID";
        MKPinAnnotationView *v = 
        (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:mapID];
        if (v == nil) {
            v = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:mapID] autorelease];
            // 创建一个 MKPinAnnotationView大头针
            // MKPinAnnotationView : MKAnnotationView
            // 区别2个.1 可以设置颜色 2. 动画
            [v setPinColor:MKPinAnnotationColorGreen];
            [v setAnimatesDrop:YES];
            
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
            [v setCanShowCallout:YES]; //点击能否显示
            [v setRightCalloutAccessoryView:rightButton];
            // callout 把rightButton显示为右边的callout
            
        }
        return v;

    }
    
    MKPinAnnotationView *pinViewUser = nil; 
	if([theAnnotation isKindOfClass:[DisplayMapAnnotation class]]) 
	{
		static NSString *defaultPinID = @"com.eim.pin";
		pinViewUser = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if ( pinViewUser == nil ) pinViewUser = [[[MKPinAnnotationView alloc]
										  initWithAnnotation:theAnnotation reuseIdentifier:defaultPinID] autorelease];
        
        pinViewUser.draggable = YES;
		pinViewUser.pinColor = MKPinAnnotationColorGreen; 
		pinViewUser.canShowCallout = YES;
		pinViewUser.animatesDrop = YES;
        return pinViewUser;
    } 
    MKAnnotationView *pinView = nil; 
    if([theAnnotation isKindOfClass:[MyMapAnnotation class]]) 
    {
        static NSString *defaultPinID = @"com.eim.pin";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if (!pinView) {
            pinView = [[[MKAnnotationView alloc] initWithAnnotation:annotation 
                                                    reuseIdentifier:defaultPinID] autorelease]; 
            UIImage *image = [UIImage imageNamed:@"btn_map_current1.png"];
            [pinView setFrame:CGRectMake(0, 0, 32, 36)];
            pinView.image = image;
            pinView.userInteractionEnabled = YES;
            
            UIImageView *iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_map_current1.png"]];
            [iconImage setFrame:CGRectMake(0, 0, 32, 32)];
            pinView.leftCalloutAccessoryView = iconImage;
            [iconImage release];
            
            pinView.opaque = YES;
            pinView.draggable = NO;
            pinView.canShowCallout = YES;
            if([annotation.subtitle isEqualToString:@"搜索中..."]){
                [self searchAddress:annotation.coordinate];
            }
            return pinView;
        }else{
            pinView.annotation = theAnnotation;
        }
    } 
    return pinView;
}
- (void)mapView:(MKMapView *)theMapView didAddAnnotationViews:(NSArray *)views {
    
    for (MKAnnotationView *av in views) {
        if([av.annotation isKindOfClass:[MyMapAnnotation class]]){
            [theMapView selectAnnotation:av.annotation animated:YES]; 
        }
    }
}
-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    if(self.readonly) return;
    if(!firstLoaded) return;
    
    if(location.latitude != 0 && location.longitude != 0){
        [_glassMenuView removeFromSuperview];
        _glassMenuView = nil;
        
        [self setSubmitEnable:NO];
        if(annotation != nil){
            [annotation release], annotation = nil;
        }
    }
}
-(void)mapView:(MKMapView *)theMapView regionDidChangeAnimated:(BOOL)animated{
   
    NSLog(@"变变变");
    if(self.readonly) return;
    if(!firstLoaded) return;
    else [self createMarker];
    
    if(location.latitude == 0 && location.longitude == 0) return;
    [self searchAddress:theMapView.centerCoordinate];
}
-(void)searchAddress:(CLLocationCoordinate2D)centerLocation {
    [self animateMarker:^{
        [self glassMenuWithLoadingStyle];
        
        if(_clGeocoder != nil){
            
            CLLocation *l = [[CLLocation alloc] initWithLatitude:centerLocation.latitude longitude:centerLocation.longitude];
            
            //annotation = [[MyMapAnnotation alloc] initWithCoordinate:l.coordinate andAddress:@""];
            
            [self setSubmitEnable:YES];
            [_clGeocoder reverseGeocodeLocation:l completionHandler:^(NSArray *placemarks, NSError *error) {
                NSLog(@"error: %@, placemarks count: %d", error.localizedDescription, [placemarks count]);
                
                if([placemarks count] > 0 && error == nil){
                    
                    CLPlacemark *mark = (CLPlacemark *)[placemarks objectAtIndex:0];
                    NSDictionary *addressDic = mark.addressDictionary;
                    
                    NSString *address = [NSString stringWithFormat:@"%@", [addressDic objectForKey:@"Name"]];
                    NSLog(@"%f",mapView.region.center.latitude);
                    NSLog(@"address: %@", address);
                    [annotation setAddress:address];
                    [self glassMenuWithContent:address];
                    
                    
                }else {
                    //[annotation release];
                    
                    [self glassMenuWithContent:@"无法定位当前位置"];
                    
                }
                
            }];
        }else{
            if(_mkGeocoder != nil){
                [_mkGeocoder cancel];
            }
            _mkGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:centerLocation];
            [_mkGeocoder setDelegate:self];
            [_mkGeocoder start];
            
            [self setSubmitEnable:YES];
            annotation = [[MyMapAnnotation alloc] initWithCoordinate:_mkGeocoder.coordinate andAddress:@""];
        }
    }];
}
#pragma mark -Geocoder
-(void)requestGoogleMap:(MKReverseGeocoder *)geocoder{
    
    if(requestToGoogleMap != nil && [requestToGoogleMap isExecuting]){
        [requestToGoogleMap cancel];
        [requestToGoogleMap release];
        requestToGoogleMap = nil;
    }
//   NSString *fetchURL = [NSString stringWithFormat:GEOCODER_URL, 
//                          [NSString stringWithFormat:@"%f", geocoder.coordinate.latitude], 
//                          [NSString stringWithFormat:@"%f", geocoder.coordinate.longitude]];
   // NSURL *url = [NSURL URLWithString:fetchURL];
  //  requestToGoogleMap = [[ASIHTTPRequest alloc] initWithURL:url];
    
    annotation = [[MyMapAnnotation alloc] initWithCoordinate:geocoder.coordinate andAddress:@""];
    
    [self setSubmitEnable:YES];
    [requestToGoogleMap setFailedBlock:^{
        
        NSLog(@"reverse geocoder error: %@", [[requestToGoogleMap error] localizedDescription]);
        [self glassMenuWithContent:@"无法定位当前位置"];
        
        [requestToGoogleMap release];
        requestToGoogleMap = nil;
        
    }];
    
    [requestToGoogleMap setCompletionBlock:^{
        NSDictionary *retVals = [[requestToGoogleMap responseString] objectFromJSONString];
        NSArray *placemarks = [retVals objectForKey:@"Placemark"];
        
        if(placemarks != nil && [placemarks count] > 0){
            
            NSDictionary *placemark = [placemarks objectAtIndex:0];
            NSString *address = [placemark objectForKey:@"address"];
            [annotation setAddress:address];
            if(self.readonly){
                [mapView removeAnnotations:mapView.annotations];
                [mapView addAnnotation:annotation];
                [mapView selectAnnotation:annotation animated:YES];
            }else{
                [self glassMenuWithContent:address];
            }
            
            
        }else{
            
            [self glassMenuWithContent:@"无法定位当前位置"];
            
        }
        [requestToGoogleMap release];
        requestToGoogleMap = nil;
    }];
    [requestToGoogleMap startAsynchronous];
}
-(void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    if([error.domain isEqualToString: NSURLErrorDomain]){
        [self requestGoogleMap:geocoder];
    }else{
        [self glassMenuWithContent:@"无法定位当前位置"];
    }
}
-(void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    if(placemark != nil){
        
        NSDictionary *addressDic = placemark.addressDictionary;
        if(addressDic == nil || (NSNull *)addressDic == [NSNull null]){
            [self requestGoogleMap:geocoder];
        }else{
            NSString *address = [addressDic objectForKey:@"Name"];
            if(address == nil || (NSNull *)address == [NSNull null]){
                [self requestGoogleMap:geocoder];
            }else{
                //annotation = [[MyMapAnnotation alloc] initWithCoordinate:geocoder.coordinate andAddress:address];
                [annotation setAddress:address];
                if(self.readonly){
                    [mapView removeAnnotations:mapView.annotations];
                    [mapView addAnnotation:annotation];
                    [mapView selectAnnotation:annotation animated:YES];
                }else{
                    [self glassMenuWithContent:address];
                }
            }
        }
        
    }else {
        
        [annotation release];
        [self glassMenuWithContent:@"无法定位当前位置"];
    }
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSString * drive = [NSString stringWithFormat:@"%@:%@",driveName,driverMobile];
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle: drive
                                                   message:nil
                                                  delegate:self 
                                         cancelButtonTitle:@"取消" 
                                         otherButtonTitles:@"拨打",nil];
    [alert show];
    [alert release];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==1) {
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:@"tel:4006960666"];
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    }
    
}
@end
