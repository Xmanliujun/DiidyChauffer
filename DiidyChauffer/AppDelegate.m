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
#import "MobClick.h"
#import <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <CommonCrypto/CommonDigest.h>

//#import<CoreTelephony/CTTelephonyNetworkInfo.h>
//
//#import<CoreTelephony/CTCarrier.h>

@implementation AppDelegate
UIBackgroundTaskIdentifier backgroundTask;//写成成员
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
    
    [MobClick setCrashReportEnabled:YES];  // 如果不需要捕捉异常，注释掉此行
    
    //[MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    //    [MobClick setAppVersion:@"2.0"]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    
    [MobClick event:@"main"];
    
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    // [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

//是否接入网络
-(BOOL)connectedToNetwork
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
    
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	//如果不能获取连接标志，则不能连接网络，直接返回
	if (!didRetrieveFlags)
	{
		return NO;
	}
	//根据获得的连接标志进行判断
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	BOOL isWWAN = flags & kSCNetworkReachabilityFlagsIsWWAN;
	return (isReachable && (!needsConnection || isWWAN)) ? YES : NO;
}

-(void)getDeviceInformation{
    
    
    self.uniqueString = [[NSProcessInfo processInfo] globallyUniqueString];//标识号
    
    self.deviceName = [[UIDevice currentDevice] name];
    float  verion = [[[UIDevice currentDevice] systemVersion] floatValue];//操作系统
    self.phoneVerion = verion;
    Reachability * r =[Reachability reachabilityWithHostName:@"www.baidu.com"];
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
    NSMutableDictionary *dictplist = [[[NSMutableDictionary alloc] init] autorelease];
    //定义第一个插件的属性
    NSMutableDictionary *plugin1 = [[[NSMutableDictionary alloc]init] autorelease];
    [plugin1 setObject:@"r"forKey:@"status"];
    [plugin1 setObject:@"" forKey:@"telephone"];
    //设置属性值
    [dictplist setObject:plugin1 forKey:@"statusDict"];
    
    //写入文件
    [dictplist writeToFile:plistPath atomically:YES];
    
}
//void UncaughtExceptionHandler(NSException *exception) {
//
//    NSArray *arr = [exception callStackSymbols];
//
//    NSString *reason = [exception reason];
//
//    NSString *name = [exception name];
//
//
//
//    NSString *urlStr = [NSString stringWithFormat:@"mailto://549110062@qq.com?subject=bug报告&body=感谢您的配合!<br><br><br>"
//
//                        "错误详情:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",
//
//                        name,reason,[arr componentsJoinedByString:@"<br>"]];
//
//
//
//    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//
//    [[UIApplication sharedApplication] openURL:url];
//
//}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [self umengTrack];//友盟
    [self creatDatabase];//数据库
    
    //NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);//捕捉异常
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
	BOOL ret = [_mapManager start:@"0620AE5E420F347628B96739E458B4293E377EAE" generalDelegate:self];
    
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
        
    }else
    {
        MainViewController * main = [[MainViewController alloc] init];
        main.version = YES;
        UINavigationController*mainNa = [[[UINavigationController alloc] initWithRootViewController:main] autorelease];
        [mainNa setNavigationBarHidden:YES];
        self.window.rootViewController = mainNa;
        [self.window addSubview:main.view];
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
    [MobClick appTerminated];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [MobClick appLaunched];
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0))
    {
        // Acquired additional time
        UIDevice *device = [UIDevice currentDevice];
        BOOL backgroundSupported = NO;
        if ([device respondsToSelector:@selector(isMultitaskingSupported)])
        {
            backgroundSupported = device.multitaskingSupported;
        }
        if (backgroundSupported)
        {
            backgroundTask = [application beginBackgroundTaskWithExpirationHandler:^{
                [application endBackgroundTask:backgroundTask];
                backgroundTask = UIBackgroundTaskInvalid;
            }];
        }
    }
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
    [MobClick appTerminated];
    
    
}

- (NSString *)appKey
{
    //Umeng创建应用的key
    return @"504efb8e527015190b0002a2";
}

-(NSString *)channelId
{
    //Umeng渠道号
#ifdef WEB_CHANNEL
    return @"网站主页";
#else
    return @"App Store";
#endif
}

//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken {
//
//    NSLog(@"regisger success:%@", pToken);
//
//    //注册成功，将deviceToken保存到应用服务器数据库中
//
//}
//
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    // 处理推送消息
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"通知" message:@"我的信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
//    NSLog(@"%@", userInfo);
//}
//
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSLog(@"Regist fail%@",error);
//
//
//}

@end
