//
//  MainViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TelAboutViewController.h"
#import "ManageMentViewController.h"
#import "CouponViewController.h"
#import "DriverViewController.h"
#import "MoreViewController.h"
#import "LandingViewController.h"
#import "AppDelegate.h"
#import "OnLineAboutViewController.h"
#import "MathViewController.h"
#import "NotLoggedViewController.h"


#import "custom_tabbar.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)creatPriceView
{
    UIImage *priceImage =[UIImage imageNamed:@"u101_normal.png"];
    priceImageView = [[UIImageView alloc] initWithImage:priceImage];
    priceImageView.userInteractionEnabled = YES;
    priceImageView.frame = CGRectMake(37.0,-316.0 , 246.0, 316.0);
    
    UIButton* telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    telButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    telButton.frame=CGRectMake(20.0, 260.0, 200.0, 30.0);
    [telButton setBackgroundImage:[UIImage imageNamed:@"u106_normal.png"] forState:UIControlStateNormal];
    [telButton setTitle:@"400-8888-8888电话查询" forState:UIControlStateNormal];
    [telButton addTarget:self action:@selector(telephoneInquiries:) forControlEvents:UIControlEventTouchUpInside];
    [priceImageView addSubview:telButton];
    [self.view addSubview:priceImageView];
}
-(void)creatMainView
{
    NSArray * promptingArray =[NSArray arrayWithObjects:@"价格",@"分享",@"更多", nil];
    NSArray * imageArray = [NSArray arrayWithObjects:@"driver_find_u.png",@"order_check_u.png",@"coupon_u.png",@"driver_look_u.png", nil];
    NSArray * secondArray = [NSArray arrayWithObjects:@"driver_find_d.png",@"order_check_d.png",@"coupon_d.png",@"driver_look_d.png", nil];
    
    for(int i = 0;i<2;i++)
        for(int j = 0;j<2;j++){
            UIImage * mainImage = [UIImage imageNamed:[imageArray objectAtIndex:i*2+j]];
            UIImage * secondImage = [UIImage imageNamed:[secondArray objectAtIndex:i*2+j]];
            UIButton*  mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
            mainButton.alpha = 0.7;
            mainButton.tag = 100.0+j+i*10.0;
            mainButton.frame=CGRectMake(60.0+j*120,100.0+i*120, 100.0,100.0);
            [mainButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [mainButton setImage:mainImage forState:UIControlStateNormal];
            [mainButton setImage:secondImage forState:UIControlStateHighlighted];
            [mainButton addTarget:self action:@selector(goNextView:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview: mainButton];
            
        }
    [self.navigationController setToolbarHidden:NO];
    [self.navigationController.toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
   
    
    
    
       
    
    
    
    backSctl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(15, 354, 260, 44)];

    
    [backSctl insertSegmentWithTitle:@"价格" atIndex:0 animated:YES];
    [backSctl insertSegmentWithTitle:@"分享" atIndex:1 animated:YES];
    [backSctl insertSegmentWithTitle:@"更多" atIndex:2 animated:YES];    
    backSctl.segmentedControlStyle = UISegmentedControlStyleBar;
    backSctl.tintColor = [UIColor whiteColor];
    
    backSctl.momentary = YES;
    backSctl.multipleTouchEnabled = NO;//不启用多点触摸
    [backSctl addTarget:self action:@selector(selectSctl2:) forControlEvents:UIControlEventValueChanged];
    
    backSctl.selectedSegmentIndex = 0;
    backSctl.momentary = NO;
    [self.view addSubview:backSctl];
    
    UIButton*  serverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    serverButton.tag = 301;
    [serverButton setBackgroundImage:[UIImage imageNamed:@"main_left.png"] forState:UIControlStateNormal];
    serverButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [serverButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    serverButton.frame=CGRectMake(0.0,400.0, 70.0, 56.0);
    [serverButton addTarget:self action:@selector(pushPromptingView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serverButton];
    
    UIImage * footImage = [UIImage imageNamed:@"u108_normal.png"];
    UIImageView * footImageView = [[UIImageView alloc] initWithImage:footImage];
    footImageView.frame = CGRectMake(-240.0, 400.0, 240.0, 40.0);
    footImageView.tag = 300;
    footImageView.userInteractionEnabled = YES;    
    
    for(int i= 0;i<3;i++){
        UIButton*  promptingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        promptingButton.tag = 200+i;
        promptingButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        promptingButton.frame=CGRectMake(15.0+i*75.0,5.0, 60.0, 30.0);
        [promptingButton setBackgroundImage:[UIImage imageNamed:@"u110_normal.png"] forState:UIControlStateNormal];
        [promptingButton setTitle:[promptingArray objectAtIndex:i]forState:UIControlStateNormal];
        [promptingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [promptingButton addTarget:self action:@selector(promptingView:) forControlEvents:UIControlEventTouchUpInside];
        [footImageView addSubview:promptingButton];
    }
    [self.view addSubview:footImageView];
    [footImageView release];
        
}

-(void)selectSctl2:(id)sender
{


UISegmentedControl* sss = (UISegmentedControl*)sender;
if(sss.selectedSegmentIndex==0){
    
    
}else if(sss.selectedSegmentIndex==1){
   }else if(sss.selectedSegmentIndex==2){
    
}else if(sss.selectedSegmentIndex==3){
    
}
}
-(void)pushPriceDescription
{
    if(price ==YES){
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        priceImageView.frame = CGRectMake(37.0,0.0 , 246.0, 316.0);
        [UIView commitAnimations];
        price = NO;
    }else {
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        priceImageView.frame = CGRectMake(37.0,-316.0 , 246.0, 316.0);
        [UIView commitAnimations];
        price = YES;
        
    }
}
-(void)pushPromptingView:(UIButton *)sender
{ 
    
    UIImageView * footImageView = (UIImageView*)[self.view viewWithTag:300];
    UIButton* serverButton= (UIButton *)[self.view viewWithTag:301];
    if(server==YES){
        
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        serverButton.frame = CGRectMake(235.0, 400.0, 70.0, 56.0);
        [serverButton setBackgroundImage:[UIImage imageNamed:@"main_right.png"] forState:UIControlStateNormal];
        footImageView.frame = CGRectMake(0.0, 400.0, 240.0, 40.0);
        [UIView commitAnimations];
        server= NO;
    }else {
        price = YES;
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        serverButton.frame = CGRectMake(0.0, 400.0, 70.0, 56.0);
         priceImageView.frame = CGRectMake(37.0,-316.0 , 246.0, 316.0);
        [serverButton setBackgroundImage:[UIImage imageNamed:@"main_left.png"] forState:UIControlStateNormal];
        footImageView.frame = CGRectMake(-240.0, 400.0, 240.0, 40.0);
        [UIView commitAnimations];
        server=YES;
    }
    
    
}
-(void)promptingView:(UIButton*)sender
{
    if(sender.tag ==200)
    {
        [self pushPriceDescription];
       
    }else if(sender.tag==201){
        
    }else {
        
        
        if([ShareApp.logInState isEqualToString:@"s"]){
            MoreViewController * more =[[MoreViewController alloc] init];
            UINavigationController * moreNav=[[UINavigationController alloc] initWithRootViewController:more];
            [self presentModalViewController:moreNav animated:YES];
            [more release];
            [moreNav release];
        }else {
            NotLoggedViewController * notLog = [[NotLoggedViewController alloc] init];
            UINavigationController * notLogNav=[[UINavigationController alloc] initWithRootViewController:notLog];
            [self presentModalViewController:notLogNav animated:YES];
            [notLog release];
            [notLogNav release];
        }
    }
    
    
    
}
-(void)goNextView:(UIButton *)sender
{
   
    if(sender.tag ==100)
    {
        TelAboutViewController * chau = [[TelAboutViewController alloc] init];
        ShareApp.pageManageMent = @"chauffer";
        
        UINavigationController * na = [[UINavigationController alloc] initWithRootViewController:chau];
       // UITabBarItem * tabBar = [[UITabBarItem alloc]init];
      //  UITabBarItem * tabBar = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"navigationbar_home.png"] tag:1];

        
        //tabBar.title = @"retur";
        // tabBar.badgeValue = @"News";
       // na.tabBarItem = tabBar;
        
        OnLineAboutViewController * online = [[OnLineAboutViewController alloc] init];
       // online.title = @"在线约";
        UINavigationController * onlineNa = [[UINavigationController alloc] initWithRootViewController:online];
        
        MathViewController *math = [[MathViewController alloc] init];
       // math.title = @"算算看";
        UINavigationController * mathNa = [[UINavigationController alloc] initWithRootViewController:math];
       // mathNa.tabBarController.tabBar.tintColor = [UIColor redColor];
        
        
        
        
        NSArray *viewControllerArray = [[[NSArray alloc] initWithObjects:na,onlineNa, mathNa, nil] autorelease];
        
       custom_tabbar * tabController = [[custom_tabbar alloc] init];
        tabController.viewControllers = viewControllerArray;
        
        tabController.selectedIndex = 1;
    
        
        [ShareApp.window setRootViewController:tabController];
        
    }else if (sender.tag ==101) {
        if([ShareApp.logInState isEqualToString:@"s"]){
            
            ManageMentViewController * mange = [[ManageMentViewController alloc] init];
            UINavigationController * mangeNa =[[UINavigationController alloc] initWithRootViewController:mange];
            [self presentModalViewController:mangeNa animated:YES];
            [mange release];
            [mangeNa release];
        }else {
            LandingViewController * land = [[LandingViewController alloc] init];
            UINavigationController * landNa = [[UINavigationController alloc] initWithRootViewController:land];
            ShareApp.pageManageMent = @"manage";
            [self presentModalViewController:landNa animated:YES];
            [land release];
            [landNa release];
        }
    }else if(sender.tag ==110){
        
        if([ShareApp.logInState isEqualToString:@"s"]){
            CouponViewController * coupon = [[CouponViewController alloc] init];
            UINavigationController * couponNa = [[UINavigationController alloc] initWithRootViewController:coupon];
            [self presentModalViewController:couponNa animated:YES];
            [coupon release];
            [couponNa release];
        }else {
            LandingViewController * land = [[LandingViewController alloc] init];
            UINavigationController * landNa = [[UINavigationController alloc] initWithRootViewController:land];
            ShareApp.pageManageMent = @"coupon";
            [self presentModalViewController:landNa animated:YES];
            [landNa release];
            [land release];
        }
    }else {
       
        if([ShareApp.logInState isEqualToString:@"s"]){

            DriverViewController * driver = [[DriverViewController alloc] init];
        
            UINavigationController * driverNa = [[UINavigationController alloc] initWithRootViewController:driver];
            
            [self presentModalViewController:driverNa animated:NO];
            [driverNa release];
            [driver release];
        }else {
            LandingViewController * land = [[LandingViewController alloc] init];
            UINavigationController * landNa = [[UINavigationController alloc] initWithRootViewController:land];
            ShareApp.pageManageMent = @"Driver";
            [self presentModalViewController:landNa animated:YES];
            [landNa release];
            [land release];

        }
    }
    
}

-(void)telephoneInquiries:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel:4006960666"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview]; 
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    server = YES;
    price = YES;
    
    UIImageView *mainImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bg.png"]];
    mainImageView.frame = self.view.bounds;
    [self.view addSubview:mainImageView];
    [mainImageView release];
    [self creatMainView];
    [self creatPriceView];

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)dealloc
{  
    [priceImageView release];
    [super dealloc];
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
