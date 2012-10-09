//
//  LocationDemoViewController.m
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import "LocationDemoViewController.h"

#define NAV_BAR_HEIGHT          44.0
#define NAV_BAR_BLANK_BUTTON    60.0
#define NAV_BAR_BUTTON_MARGIN   7.0
#define NAV_BAR_BUTTON_WIDTH    44.0
#define NAV_BAR_BUTTON_HEIGHT   30.0

#define WIDTH_GLASSMENU_MIN     75
#define WIDTH_GLASSMENU_MAX     300
@implementation LocationDemoViewController
@synthesize readonly,mapAnnon,LocationDelegate,path;
@synthesize possible,possibleLoca;
//-(void)backToTheOriginalPosition
//{
//    
//    
//}
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
#pragma mark-reverseGeocode
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
       if (error == 0) {
           CLLocationCoordinate2D center;
           center = result.geoPt;
           if (UpdateUserLocation) {
               if (firstMenue) {
                   if ([result.poiList count]!=0) {
                       BMKPoiInfo * info= [result.poiList objectAtIndex:0];
                       [self glassMenuWithContent:info.name];
                   }else{
                       [self glassMenuWithContent:result.strAddr];
                   }
                       firstMenue = NO;
               }
               BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
               item.coordinate = center;
               item.title = result.strAddr;
               [_mapView addAnnotation:item];
               [item release];
            } else {
                if ([result.poiList count]!=0) {
                    BMKPoiInfo * info= [result.poiList objectAtIndex:0];
                    [self glassMenuWithContent:info.name];
                }else{
                    [self glassMenuWithContent:result.strAddr];
                }
                
            }             
    }
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{

	if (userLocation != nil) {
        if (self.possible) {
            UpdateUserLocation = YES;
            locationPeson = YES;
            
            NSLog(@"location：%f long：%f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
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
            
            _mapView.showsUserLocation=YES;
            [_mapView setRegion:region animated:YES];
            
            NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
            [_mapView removeAnnotations:array];
            array = [NSArray arrayWithArray:_mapView.overlays];
            [_mapView removeOverlays:array];
            
            CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
            
            pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
            
            if(firstCreat){
                [self createMarker];
                if(location.latitude == 0 && location.longitude == 0) return;
                [self searchAddress:mapView.centerCoordinate];
                firstCreat = NO;
            }            
            //        BOOL flag = [_search reverseGeocode:pt];
            //                        
            //        if (!flag) {
            //            NSLog(@"search failed!");
            //        }
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
	if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
		BMKPinAnnotationView *newAnnotation = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"]autorelease];  
        newAnnotation.frame = CGRectMake(0, 0, 30, 30);
		newAnnotation.pinColor = BMKPinAnnotationColorRed;   
		newAnnotation.animatesDrop = YES;
		newAnnotation.draggable = YES;
        return newAnnotation;   
	}
	return nil;
}

- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
   
    if(!firstLoaded) return;
    UpdateUserLocation = NO;    
    if(location.latitude != 0 && location.longitude != 0){
        [_glassMenuView removeFromSuperview];
        _glassMenuView = nil;
        if(mapAnnon != nil){
            [mapAnnon release], mapAnnon = nil;
        }
    }
}
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    CLLocationCoordinate2D center;
    center.latitude = mapView.centerCoordinate.latitude;
    center.longitude = mapView.centerCoordinate.longitude;
    location = center;
    if (UpdateUserLocation)return;
    if(!firstLoaded) return;
    else [self createMarker];
    
    if(location.latitude == 0 && location.longitude == 0) return;
    [self searchAddress:mapView.centerCoordinate];
    
    locationPeson = NO;
}



#pragma mark-customize
-(void)createMarker{
  
    if(!_markerView){
       CGRect f = _mapView.frame;
        
        _markerView = [[UIView alloc] initWithFrame:CGRectMake(f.origin.x + f.size.width/2,
                                                               f.origin.y + f.size.height/2, 
                                                               32, 36)];
        _markerView.backgroundColor = [UIColor clearColor];
        _markerTip = [[UIImageView alloc] initWithFrame:CGRectMake(-16, -16, 32, 32)];
        [_markerTip setImage:[UIImage imageNamed:@"btn_map_current1.png"]];
        [_markerView addSubview:_markerTip];
        [_markerTip release];
        
        _markerShadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 32, 32, 4)];
        
        [self glassMenuWithLoadingStyle];
        
        [self.view addSubview:_markerView];
    }
}

-(void)animateMarker:(void (^)())completed
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [_markerTip setFrame:CGRectMake(-16, -32, 32, 32)];
                         [_markerShadow setFrame:CGRectMake(16, 34, 0, 0)];
                     } 
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              [_markerTip setFrame:CGRectMake(-16, -16, 32, 32)];
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
    CGRect f = _mapView.frame;
     _glassMenuView = [[UIView alloc] initWithFrame:CGRectMake(f.origin.x + f.size.width/2-86-16, f.origin.y + f.size.height/2-53-16, 200, 60)];
    _glassMenuView.backgroundColor = [UIColor clearColor];
    UIImage *glassMenuImgMid = [UIImage imageNamed:@"main_map_loinbg_fold.9.png"];
    
    UIImageView * newinmage = [[UIImageView alloc] initWithImage:glassMenuImgMid];
    newinmage.frame =CGRectMake(0, 0, 200, 60);
    newinmage.userInteractionEnabled = YES;
   
    textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, _glassMenuView.frame.size.width - 50, 60)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont fontWithName:@"Arial" size:12];
    [textLabel setTextColor:[UIColor whiteColor]];
    [textLabel setTextAlignment:UITextAlignmentCenter];
    [textLabel setText:@"信息加载中..."];
    [newinmage addSubview:textLabel];
    [textLabel release];   

    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicatorView setFrame:CGRectMake(90,5, 20, 20)];
    indicatorView.hidesWhenStopped = YES;
    [indicatorView startAnimating];
    [newinmage addSubview:indicatorView];
    [_glassMenuView addSubview:newinmage];
    
    [newinmage release];
    [indicatorView release];
    
    _markerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_glassMenuView];

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
    CGRect f = _mapView.frame;
    _markerView = [[UIView alloc] initWithFrame:CGRectMake(f.origin.x + f.size.width/2 ,
                                                           f.origin.y + f.size.height/2, 
                                                           200, 80)];
    UIImage *glassMenuImgMid = [UIImage imageNamed:@"main_map_loinbg_fold.9.png"];
    UIImageView * newinmage = [[UIImageView alloc] initWithImage:glassMenuImgMid];
    newinmage.frame =CGRectMake(0, 0, 200, 60);
    newinmage.userInteractionEnabled = YES;
    
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newButton.frame = CGRectMake(5,5,190,40);
    newButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
    [newButton setTitle:@"                                >" forState:UIControlStateNormal];
    [newButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(selectTheCurrentLocation:) forControlEvents:UIControlEventTouchUpInside];
    
    _glassMenuView = [[UIView alloc] initWithFrame:CGRectMake(f.origin.x + f.size.width/2-86-16, f.origin.y + f.size.height/2-53-16, 200, 60)];
    _glassMenuView.backgroundColor = [UIColor clearColor];
   
    UILabel* pickupLable = [[UILabel alloc] initWithFrame:CGRectMake(40, -1,120, 30)];
    pickupLable.backgroundColor = [UIColor clearColor];
    pickupLable.font = [UIFont fontWithName:@"Arial" size:14];
    [pickupLable setTextColor:[UIColor whiteColor]];
    [pickupLable setTextAlignment:NSTextAlignmentCenter];
    [pickupLable setText:@"到这儿接我"];
    [newinmage addSubview:pickupLable];
    [pickupLable release];
    textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,20, _glassMenuView.frame.size.width - 30, 30)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont fontWithName:@"Arial" size:12];
    [textLabel setTextColor:[UIColor whiteColor]];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setText:text];
    [newinmage addSubview:textLabel];
    [textLabel release];   
    [newinmage addSubview:newButton];
    [_glassMenuView addSubview:newinmage];
    
    [self.view addSubview:_glassMenuView];
    [_glassMenuView release];
    [newinmage release];
    
}

-(void)searchAddress:(CLLocationCoordinate2D)centerLocation {
   
    [self animateMarker:^{
        [self glassMenuWithLoadingStyle];
        if(_search != nil){
           BOOL flag = [_search reverseGeocode:centerLocation];
            
            if (!flag) {
                NSLog(@"search failed!");
                [self glassMenuWithContent:@"无法定位当前位置"];
            }
        }}];
    
}



#pragma   mark - Button And NSNotification
-(void)selectTheCurrentLocation:(id)sender
{
    [LocationDelegate selectTheCurrentLocationOnLine:textLabel.text CLLocation:location];
    
}


-(void)selectedCityName:(NSNotification*)notify
{
    
    locationPeson = YES;
    
    NSDictionary *dict = notify.userInfo;
//    
//    NSString *cityName = [dict objectForKey:@"City"];
//    
//    NSString * address = [dict objectForKey:@"Address"];
    NSString* lation =[dict objectForKey:@"lation"];
    NSString * locations = [dict objectForKey:@"longitue"];
    
    NSLog(@"%@",lation);
    NSLog(@"%@",locations);
    
    CLLocationCoordinate2D cityLocation;
    cityLocation.latitude = [lation floatValue];
    cityLocation.longitude = [locations floatValue];

    BMKCoordinateSpan span;
    span.latitudeDelta = 0.01f; //zoom level
    span.longitudeDelta = 0.01f; //zoom level
    
    BMKCoordinateRegion region;
    region.span = span;
    region.center = cityLocation;
    NSLog(@"%f  %f ",cityLocation.latitude,cityLocation.longitude );
    // map.showsUserLocation=NO;
    
    [_mapView setRegion:region animated:YES];
    
//    [self createMarker];
//    [self glassMenuWithContent:address];
    
     
//       
//        if(cityLocation.latitude == 0 && cityLocation.longitude == 0) return;
//        [self searchAddress:cityLocation];
//        locationPeson = NO;
    
}

#pragma mark - System Approach
- (void)viewDidLoad {
    [super viewDidLoad];
    
    firstLoaded = YES;
    UpdateUserLocation =NO;
    firstCreat = YES;
    firstMenue = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedCityName:) name:@"SELECTCITY" object:nil];
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 360)];
    _mapView.delegate = self;
	
	_mapView.showsUserLocation = YES;
    [_mapView setZoomEnabled: YES];
    [_mapView setScrollEnabled:YES];
    
    _search = [[BMKSearch alloc]init];
	_search.delegate = self;
    [self.view addSubview:_mapView];
    if (self.possible) {
        
        BMKCoordinateSpan span;
        span.latitudeDelta = 0.01f; //zoom level
        span.longitudeDelta = 0.01f; //zoom level
        
        BMKCoordinateRegion region;
        region.span = span;
        region.center =self.possibleLoca;
        [_mapView setRegion:region animated:YES];
        [self createMarker];
        [self searchAddress:self.possibleLoca];
    }
}

- (void)dealloc {
    
    [_search release];
    [_markerView release];
    [_mapView release];
    [path retain];
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

@end
