//
//  AppDelegate.m
//  DiidyChauffer
//
//  Created by diidy on 12-9-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LocationDemoViewController.h"
#import "MobClick.h"
#import "CONST.h"
#import "MainViewController.h"
#import "NoviceGuidanceViewController.h"
#import "Reachability.h"


#import "QFDatabase.h"
#import "FMDatabase.h"
#import "FMDatabasePool.h"
@implementation AppDelegate

@synthesize reachable;
@synthesize window = _window,phoneVerion,deviceName,uniqueString,logInState;
@synthesize pageManageMent,mobilNumber;
@synthesize mDatabase;
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

-(void)creatDatabase
{

    mDatabase = [[QFDatabase alloc] init];
    [mDatabase openDatabase:DATABASE_TYPE_FMDB];
}
- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    //    [MobClick setAppVersion:@"2.0"]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
   // [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
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
-(void)showLogInState
{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);  
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] init];
    //定义第一个插件的属性
    NSMutableDictionary *plugin1 = [[NSMutableDictionary alloc]init];
    [plugin1 setObject:@"r"forKey:@"status"];
    [plugin1 setObject:@"" forKey:@"telephone"];
    //设置属性值
    [dictplist setObject:plugin1 forKey:@"statusDict"];
    
    //写入文件
    [dictplist writeToFile:plistPath atomically:YES];

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    [self umengTrack];
    [self creatDatabase];
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
	BOOL ret = [_mapManager start:@"96F593C80D691D61026489D7624FA74B5D18C089" generalDelegate:self];
    
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
        [self showLogInState];
        
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
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
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
