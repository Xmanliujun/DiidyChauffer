//
//  AppDelegate.m
//  DiidyChauffer
//
//  Created by diidy on 12-9-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LocationDemoViewController.h"

#import "MainViewController.h"
#import "NoviceGuidanceViewController.h"
#import "Reachability.h"
@implementation AppDelegate

@synthesize reachable;
@synthesize window = _window,phoneVerion,deviceName,uniqueString,logInState;
@synthesize pageManageMent,mobilNumber;

- (void)dealloc
{
    self.logInState =nil;
    self.uniqueString =nil;
    self.deviceName = nil;
    self.reachable = nil;
    [mobilNumber release];
    [pageManageMent release];
    [_window release];
    [super dealloc];
}

-(void)getDeviceInformation{
    
    self.uniqueString = [[NSProcessInfo processInfo] globallyUniqueString];//标识号
    
    self.deviceName = [[UIDevice currentDevice] name];
    float  verion = [[[UIDevice currentDevice] systemVersion] floatValue];//操作系统
    self.phoneVerion = verion;
    
    Reachability * r =[Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            self.reachable = @"没有网络连接";
            break;
            
        case ReachableViaWiFi:
            self.reachable = @"使用WiFi网络";
            break;
        case ReachableViaWWAN:
            self.reachable = @"使用3G/GPRS网络";
            break;
            
    }
    
    
}
-(void)ShowHelpNavigation
{
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *firstUseApp = [userDefaults objectForKey:@"FirstUseApp"] ;
    if(firstUseApp == nil)
    {
        [userDefaults setValue:@"1" forKey:@"FirstUseApp"];     
        [userDefaults synchronize];
        NoviceGuidanceViewController* guide = [[NoviceGuidanceViewController alloc] init];
        guide.noviceGuidan = @"main";
        self.window.rootViewController = guide;
        [guide release];
        
    }
    
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
	BOOL ret = [_mapManager start:@"96F593C80D691D61026489D7624FA74B5D18C089" generalDelegate:nil];
    
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    
       
    
    [self getDeviceInformation];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *firstUseApp = [userDefaults objectForKey:@"FirstUseApp"] ;
    if(firstUseApp == nil)
    {
        //第一次进入， 显示新手导航
        [self ShowHelpNavigation];
        
    }
    else
    {
        MainViewController * main = [[MainViewController alloc] init];
        self.window.rootViewController = main;
        [main release];
        
    }

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
