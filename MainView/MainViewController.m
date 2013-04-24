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
#import<MessageUI/MFMailComposeViewController.h>
#import "CONST.h"
#import "custom_tabbar.h"
#import "PriceViewController.h"
#import "Reachability.h"
#import "MobClick.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize version;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -Button
-(void)selectSctl2:(id)sender
{
    
    UISegmentedControl* sss = (UISegmentedControl*)sender;
    if(sss.selectedSegmentIndex==0){
        
        
    }else if(sss.selectedSegmentIndex==1){
    }else if(sss.selectedSegmentIndex==2){
        
    }else if(sss.selectedSegmentIndex==3){
        
    }
}

-(void)promptingView:(UIButton*)sender
{
    if(sender.tag ==200)
    {
        [MobClick event:@"m01"];
        PriceViewController * priceview = [[PriceViewController alloc] init];
        UINavigationController * prcieNa=[[UINavigationController alloc] initWithRootViewController:priceview];
        [self presentViewController:prcieNa animated:NO completion:nil];
        [priceview release];
        [prcieNa release];
        
       
    }else if(sender.tag==201){
        
        UIActionSheet *menu = [[[UIActionSheet alloc]
                                initWithTitle:@"分享"
                                delegate:self
                                cancelButtonTitle:@"取消"
                                destructiveButtonTitle:@"通过短信"
                                otherButtonTitles:nil] autorelease];
        [menu showInView:[UIApplication sharedApplication].keyWindow];

    }else {
        
        if([ShareApp.logInState isEqualToString:@"s"]){
            
            [MobClick event:@"m07_s003"];
            MoreViewController * more =[[MoreViewController alloc] init];
            more.whereLand = @"MainLand";
            UINavigationController * moreNav=[[UINavigationController alloc] initWithRootViewController:more];
            [self presentModalViewController:moreNav animated:NO];
            [more release];
            [moreNav release];
            
        }else {
            
            NotLoggedViewController * notLog = [[NotLoggedViewController alloc] init];
            UINavigationController * notLogNav=[[UINavigationController alloc] initWithRootViewController:notLog];
            [self presentModalViewController:notLogNav animated:NO];
            [notLog release];
            [notLogNav release];
            
        }
    }
}

-(void)displaySMSComposerSheet
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate =self;
    NSString *smsBody =[NSString stringWithFormat:@"嘀嘀代驾真不错,不打电话也能轻松找代驾。客户端下载地址: https://itunes.apple.com/us/app/di-di-dai-jia/id587269030?ls=1&mt=8 或拨打 4006960666"];
    picker.body=smsBody;
    [self presentModalViewController:picker animated:NO];
    [picker release];
}


-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==0){
        
         [MobClick event:@"m08_sh01"];
        Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
        
        if (messageClass != nil) {
            // Check whether the current device is configured for sending SMS messages
            if ([messageClass canSendText]) {
                
                [self displaySMSComposerSheet];
            }
            else {
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@""message:@"设备不支持短信功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
        }
        else {
        }
    
    }else {
        // [actionSheet release];
    }
    
}

-(void)goNextView:(UIButton *)sender
{
        
    if (![ShareApp connectedToNetwork]) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"联网失败,请稍后再试"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }else{

        if(sender.tag ==100){
          
            NSLog(@"100");
            
            [MobClick event:@"m03"];

            TelAboutViewController * chau = [[[TelAboutViewController alloc] init] autorelease];
            ShareApp.pageManageMent = @"chauffer";
            UINavigationController * na = [[[UINavigationController alloc] initWithRootViewController:chau] autorelease];
        
            OnLineAboutViewController * online = [[[OnLineAboutViewController alloc] init] autorelease];
            online.possible = YES;
            online.coupossible = YES;
            UINavigationController * onlineNa = [[[UINavigationController alloc] initWithRootViewController:online] autorelease];
        
            MathViewController *math = [[[MathViewController alloc] init] autorelease];
            UINavigationController * mathNa = [[[UINavigationController alloc] initWithRootViewController:math] autorelease];
        
            NSArray *viewControllerArray = [[[NSArray alloc] initWithObjects:na,onlineNa, mathNa, nil] autorelease];
        
            custom_tabbar * tabController  = [[custom_tabbar alloc] init];
            tabController.viewControllers = viewControllerArray;
            tabController.selectedIndex = 1;
            [ShareApp.window setRootViewController:tabController];

        }else if (sender.tag ==110) {
        
            NSLog(@"110");

            if([ShareApp.logInState isEqualToString:@"s"]){
                
                [MobClick event:@"m04"];
                ManageMentViewController * mange = [[ManageMentViewController alloc] init];
                mange.manageStat = YES;
                UINavigationController * mangeNa =[[UINavigationController alloc] initWithRootViewController:mange];
                [self presentModalViewController:mangeNa animated:NO];
                [mange release];
                [mangeNa release];
            
            }else {
            
                LandingViewController * land = [[LandingViewController alloc] init];
                UINavigationController * landNa = [[UINavigationController alloc] initWithRootViewController:land];
                ShareApp.pageManageMent = @"manage";
                [self presentModalViewController:landNa animated:NO];
                [land release];
                [landNa release];
            
            }
        }else if(sender.tag ==111){
        
            NSLog(@"111");

            if([ShareApp.logInState isEqualToString:@"s"]){
                
                [MobClick event:@"m05"];

                CouponViewController * coupon = [[CouponViewController alloc] init];
                UINavigationController * couponNa = [[UINavigationController alloc] initWithRootViewController:coupon];
                coupon.couponStat = YES;
                [self presentModalViewController:couponNa animated:NO];
                [coupon release];
                [couponNa release];
            
            }else {
            
                LandingViewController * land = [[LandingViewController alloc] init];
                UINavigationController * landNa = [[UINavigationController alloc] initWithRootViewController:land];
                ShareApp.pageManageMent = @"coupon";
                [self presentModalViewController:landNa animated:NO];
                [landNa release];
                [land release];
            
            }
        }else {
       
            NSLog(@"112");

            if([ShareApp.logInState isEqualToString:@"s"]){
                
                [MobClick event:@"m06"];
                
                DriverViewController * driver = [[DriverViewController alloc] init];
                UINavigationController * driverNa = [[UINavigationController alloc] initWithRootViewController:driver];
                [self presentModalViewController:driverNa animated:NO];
                [driverNa release];
                [driver release];
            
            }else {
                
                [MobClick event:@"m09_u002"];

                LandingViewController * land = [[LandingViewController alloc] init];
                UINavigationController * landNa = [[UINavigationController alloc] initWithRootViewController:land];
                ShareApp.pageManageMent = @"Driver";
                [self presentModalViewController:landNa animated:NO];
                [landNa release];
                [land release];

            }
        }
    }
}


#pragma mark-Self Call

-(void)creatMainView
{
    NSArray * promptingArray =[NSArray arrayWithObjects:@"价格",@"分享",@"更多", nil];
    NSArray * imageArray = [NSArray arrayWithObjects:@"driver_find_u.png",@"driver_look_u.png",@"order_check_u.png",@"coupon_u.png", nil];
    NSArray * secondArray = [NSArray arrayWithObjects:@"driver_find_d.png",@"driver_look_d.png",@"order_check_d.png",@"coupon_d.png", nil];
    
    for(int i = 0;i<2;i++)
        for(int j = 0;j<2;j++){
            
            UIImage * mainImage = [UIImage imageNamed:[imageArray objectAtIndex:i*2+j]];
            UIImage * secondImage = [UIImage imageNamed:[secondArray objectAtIndex:i*2+j]];
            UIButton*  mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
            mainButton.alpha = 0.7;
            mainButton.tag = 100.0+j+i*10.0;
            mainButton.frame=CGRectMake(30.0f+j*140.0f,(80.0f+i*140.0f), 120.0f,120.0f);
            [mainButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [mainButton setImage:mainImage forState:UIControlStateNormal];
            [mainButton setImage:secondImage forState:UIControlStateHighlighted];
            [mainButton addTarget:self action:@selector(goNextView:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview: mainButton];
            
        }
    
    NSArray * bottonImageArray = [NSArray arrayWithObjects:@"1-1.png",@"2-1.png",@"3-1.png",nil];
    NSArray * bSecondArray = [NSArray  arrayWithObjects:@"1-2.png",@"2-2.png",@"3-2.png", nil];
    
    for(int i= 0;i<3;i++){
        
        UIImage * bottonImage = [UIImage imageNamed:[bottonImageArray objectAtIndex:i]];
        UIImage * secondBottonImage = [UIImage imageNamed:[bSecondArray objectAtIndex:i]];
        
        UIButton*  promptingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        promptingButton.tag = 200+i;
        promptingButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        promptingButton.frame=CGRectMake(40.0f+i*80.0f,390.0f,80.0f, 40.0f);
        [promptingButton setImage:bottonImage forState:UIControlStateNormal];
        [promptingButton setImage:secondBottonImage forState:UIControlStateHighlighted];
        [promptingButton setTitle:[promptingArray objectAtIndex:i]forState:UIControlStateNormal];
        [promptingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [promptingButton addTarget:self action:@selector(promptingView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:promptingButton];
    }
}

-(void)checkForNewVersion{

    aboutDiidy = [[AboutDiiDyViewController alloc] init];
    [aboutDiidy checkNewVersion];
    aboutDiidy.delegate = self;
}
-(void)completeDownLoadVerson:(int)returenNews withVerson:(NSString *)newVerson
{
   
    if (returenNews==0) {
        
    }else{
        
        NSString * nerVer = [NSString stringWithFormat:@"检测到%@新版本",newVerson];
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:nerVer
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"更新新版本",nil ];
        [alert show];
        [alert release];
        
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        NSString *webLink = @"http://itunes.apple.com/us/app/di-di-dai-jia/id587269030?ls=1&mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webLink]];
        
    }else
    {
       
    
    }

}
#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImageView *mainImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bg.png"]];
    mainImageView.frame = self.view.bounds;
    [self.view addSubview:mainImageView];
    [mainImageView release];
   
    [self creatMainView];
   
    if (self.version) {
        
         [self checkForNewVersion];
    }
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);  
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSDictionary * dictStat = [dict objectForKey:@"statusDict"];
    NSString * status = [dictStat objectForKey:@"status"];
    ShareApp.logInState = status;
    ShareApp.mobilNumber = [dictStat objectForKey:@"telephone"];
    
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [aboutDiidy cancelConnection];

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
}
-(void)dealloc
{  
   
    [super dealloc];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
