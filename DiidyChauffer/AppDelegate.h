//
//  AppDelegate.h
//  DiidyChauffer
//
//  Created by diidy on 12-9-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@class QFDatabase;
#define ShareApp ((AppDelegate*)[[UIApplication sharedApplication] delegate])
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;
    
    NSString* reachable; //0 无连接  1 使用WiFi网络 2使用3G/GPRS网络2
    float phoneVerion; //操作系统
    NSString *deviceName;//终端型号
    NSString*uniqueString;
    NSString *logInState;
    QFDatabase * mDatabase;
    
}
@property(nonatomic,retain)NSString*pageManageMent;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)NSString*reachable;
@property(nonatomic,assign)float phoneVerion;
@property(nonatomic,retain)NSString*deviceName;
@property(nonatomic,retain)NSString*uniqueString;
@property(nonatomic,retain)NSString*logInState;
@property(nonatomic,retain)NSString * mobilNumber;
@property(nonatomic,retain)QFDatabase * mDatabase;
-(BOOL)connectedToNetwork;
@end
