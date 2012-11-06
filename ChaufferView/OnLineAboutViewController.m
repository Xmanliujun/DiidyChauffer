//
//  OnLineAboutViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OnLineAboutViewController.h"
#import "SearchDepartureViewController.h"
#import "AppDelegate.h"
#import "FillOrdersViewController.h"
#import "MainViewController.h"
//#import "MapViewController.h"
#import "LocationDemoViewController.h"
#import "FromPossibleViewController.h"
@interface OnLineAboutViewController ()

@end

@implementation OnLineAboutViewController
@synthesize possibleLocation,possible,cityName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)selectTheCurrentLocationOnLine:(NSString *)text CLLocation:(CLLocationCoordinate2D)centers
{
    
    if([ShareApp.logInState isEqualToString:@"s"]){
        
        FillOrdersViewController * fillOrder = [[FillOrdersViewController alloc] initWithDeparture:text CLLocation:centers];
        UINavigationController * fillNa = [[UINavigationController alloc] initWithRootViewController:fillOrder];
        fillOrder.landed = YES;
        [self presentModalViewController:fillNa animated:NO];
        [fillNa release];
        [fillOrder release];
        
    }else {
        
        FillOrdersViewController * fillOrder = [[FillOrdersViewController alloc] initWithDeparture:text CLLocation:centers];
        UINavigationController * fillNa = [[UINavigationController alloc] initWithRootViewController:fillOrder];
        fillOrder.landed = NO;
        [self presentModalViewController:fillNa animated:NO];
        [fillNa release];
        [fillOrder release];
        
    }

}
#pragma mark- Button 
-(void)returnMainView:(id)sender
{
    MainViewController * main = [[MainViewController alloc] init];
    main.version = NO;
    [ShareApp.window setRootViewController:main];
    [main release];
}
-(void)returnLandingView:(id)sender
{

}
-(void)returnStartView:(id)sender
{
    [locationDomo backToTheOriginalPosition];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    SearchDepartureViewController * search =[[SearchDepartureViewController alloc] init];
    UINavigationController * seachNa = [[UINavigationController alloc] initWithRootViewController:search];
    
    [self presentModalViewController:seachNa animated:NO];
    [seachNa release];
    [search release];
    return NO;
}
#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.navigationItem.hidesBackButton = YES;
    self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
  
    UILabel *centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    centerLable.font = [UIFont fontWithName:@"Arial" size:17];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.text = @"在 线 约";
    self.navigationItem.titleView = centerLable;
    [centerLable release]; 
    
    UIImage * rigthImage =[UIImage imageNamed:@"33.png"];
    UIButton *rigthBarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthBarbutton setBackgroundImage:rigthImage forState:UIControlStateNormal];
    [rigthBarbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rigthBarbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    [rigthBarbutton setTitle:@"主页" forState:UIControlStateNormal];
    rigthBarbutton.frame=CGRectMake(260.0, 7.0, 50.0, 30.0);
    [rigthBarbutton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBarbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];
    
    startAddrSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 41)];  
    startAddrSearchBar.delegate = self;
    startAddrSearchBar.showsBookmarkButton = NO;
    startAddrSearchBar.barStyle = UIBarStyleDefault;  
   // startAddrSearchBar.showsSearchResultsButton = YES;
    startAddrSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;  
    startAddrSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;  
    startAddrSearchBar.placeholder = @"您也可以在此搜索出发地....";  
    startAddrSearchBar.keyboardType =  UIKeyboardTypeDefault;
    

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]];
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, 320, 45);
    [startAddrSearchBar insertSubview:imageView atIndex:1];
    [imageView release];
    [self.view addSubview:startAddrSearchBar]; 
    
    locationDomo = [[LocationDemoViewController alloc] initWithPossible:self.possible withLocation:self.possibleLocation withCityName:self.cityName];
    locationDomo.view.frame =CGRectMake(0.0f, 40.0f, 320.0f, 330.0f);
    locationDomo.LocationDelegate = self;
    [self.view addSubview:locationDomo.view];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame=CGRectMake(270.0f,330.0f, 31.0f, 30.0f);
    [startButton  setBackgroundImage:[UIImage imageNamed:@"my_location_h.png"] forState:UIControlStateNormal];
    [startButton  setBackgroundImage:[UIImage imageNamed:@"my_location_l.png"] forState:UIControlStateHighlighted];
    [startButton  addTarget:self action:@selector(returnStartView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
}
-(BOOL) respondsToSelector:(SEL)aSelector {
    
    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);  
    return [super respondsToSelector:aSelector];  
}  

-(void)dealloc
{
    [cityName release];
    [locationDomo release];
    [topImageView release];
    [startAddrSearchBar release]; 
    [super dealloc];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
