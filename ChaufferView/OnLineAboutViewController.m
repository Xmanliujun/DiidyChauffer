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
#import "CONST.h"
#import "Reachability.h"
#import "JSONKit.h"
#import "DIIdyModel.h"
@interface OnLineAboutViewController ()

@end

@implementation OnLineAboutViewController
@synthesize possibleLocation,possible,cityName;
@synthesize getCoupon_request,coupossible;
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
        fillOrder.dataArraya =dataArry;
        fillOrder.total =total;
        fillOrder.landed = YES;
        UINavigationController * fillNa = [[UINavigationController alloc] initWithRootViewController:fillOrder];
        [self presentModalViewController:fillNa animated:NO];
        [fillNa release];
        [fillOrder release];
        
    }else {
        
        FillOrdersViewController * fillOrder = [[FillOrdersViewController alloc] initWithDeparture:text CLLocation:centers];
         fillOrder.landed = NO;
        UINavigationController * fillNa = [[UINavigationController alloc] initWithRootViewController:fillOrder];
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
    NSLog(@"*********** string is %@",searchBar.text);
    
    
    SearchDepartureViewController * search =[[SearchDepartureViewController alloc] init];
    UINavigationController * seachNa = [[UINavigationController alloc] initWithRootViewController:search];
    
    [self presentModalViewController:seachNa animated:NO];
    [seachNa release];
    [search release];
    return NO;
}

#pragma mark-http
-(void)downLoadTheCouponData
{
    
    Reachability * r =[Reachability reachabilityWithHostName:@"www.apple.com"];
    
    if ([r currentReachabilityStatus]==0) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"联网失败,请重试"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }else{
        
//        HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
//        [self.navigationController.view addSubview:HUD];
//        HUD.delegate=self;
//        HUD.labelText=@"正在获取信息...";
//       // HUD.detailsLabelText=@"正在获取信息...";
//        HUD.square=YES;
//        [HUD show:YES];
        
        NSString * baseUrl = [NSString stringWithFormat:COUPON,ShareApp.mobilNumber];
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        HTTPRequest *request = [[HTTPRequest alloc] init];
        
        self.getCoupon_request = request;
        self.getCoupon_request.m_delegate = self;
        self.getCoupon_request.hasTimeOut = YES;
        [request release];
        
        [self.getCoupon_request requestByUrlByGet: baseUrl];
    }
}

//- (void)hudWasHidden:(MBProgressHUD *)hud
//{
//    [HUD removeFromSuperview];
//    [HUD release];
//    HUD = nil;
//    
//}
-(void)closeConnection
{
//    
//    if (HUD){
//        
//        [HUD removeFromSuperview];
//        [HUD release];
//        HUD = nil;
//    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
-(void)requesttimeout
{
    
    [self closeConnection];
    
}
-(void)requFinish:(NSString *)requestString order:(int)nOrder
{
    
    if ([requestString length]==0) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"登陆失败"
                                                       message:@"请检查网络是否连接"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];
        
    }else{
        
        [self parseStringJson:requestString];
    }
    
}
-(void)parseStringJson:(NSString *)str
{

    total = 0;
    [dataArry removeAllObjects];
    
    NSArray* jsonParser =[str objectFromJSONString];
    for (int i = 0; i<[jsonParser count]; i++) {
        DIIdyModel * diidy = [[DIIdyModel alloc] init];
        NSDictionary * diidyDict = [jsonParser objectAtIndex:i];
        diidy.ID = [diidyDict objectForKey:@"id"];
        diidy.name = [diidyDict objectForKey:@"name"];
        diidy.type = [diidyDict objectForKey:@"type"];
        diidy.number = [diidyDict objectForKey:@"number"];
        diidy.close_date = [diidyDict objectForKey:@"close_date"];
        diidy.amount = [diidyDict objectForKey:@"amount"];
        total += [diidy.number intValue];
        [dataArry addObject:diidy];
        [diidy release];
    }
}
-(void)dataRequestCompelte:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    if (dataArry) {
        
        [dataArry removeAllObjects];
        
    }else{
    
        dataArry = [[NSMutableArray alloc] initWithCapacity:0];
    }
        dataArry = [[dict objectForKey:@"array"] retain];
        total = [[dict objectForKey:@"number"] intValue];
        self.coupossible=NO;
}
#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"dddfdfdfdgfgf");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataRequestCompelte:) name:@"COUPONDATA" object:nil];
    dataArry = [[NSMutableArray alloc] initWithCapacity:0];
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
    
    locationDomo = [[LocationDemoViewController alloc] initWithPossible:self.possible withLocation:self.possibleLocation withCityName:self.cityName];
    locationDomo.view.frame =CGRectMake(0.0f, 40.0f, 320.0f, 330.0f);
    locationDomo.LocationDelegate = self;
    [self.view addSubview:locationDomo.view];

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
    
   
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame=CGRectMake(270.0f,330.0f, 31.0f, 30.0f);
    [startButton setBackgroundImage:[UIImage imageNamed:@"my_location_h.png"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"my_location_l.png"] forState:UIControlStateHighlighted];
    [startButton addTarget:self action:@selector(returnStartView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
  
    if (self.coupossible) {
        
        [self downLoadTheCouponData];
    }
}

-(BOOL)respondsToSelector:(SEL)aSelector {
    
    NSLog(@"获取searchbar");
    
    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);  
    return [super respondsToSelector:aSelector];
    
    
}  

-(void)dealloc
{
    
    if (getCoupon_request) {
        
        [self.getCoupon_request closeConnection];
        self.getCoupon_request.m_delegate=nil;
        self.getCoupon_request=nil;
    }
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
