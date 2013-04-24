//
//  DriverViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DriveLocationViewController.h"
#import "MBProgressHUD.h"
#import "HTTPRequest.h"
@interface DriverViewController : UIViewController
<MBProgressHUDDelegate,HTTPRequestDelegate>
{
    UILabel* centerLable;
    BOOL driverStatus;
    DriveLocationViewController* driveMap;
    MBProgressHUD *HUD;
    MBProgressHUD *HUDB;
    
     int buttonMark;
    int orderNumber;
}
//@property (nonatomic, copy) NSString *urlordering;
//@property (nonatomic, copy) NSString *urlpositionDriver;
@property(nonatomic, retain)HTTPRequest *OrderStatus_request;
@property(nonatomic, retain)HTTPRequest *DriverStatus_request;
@property(nonatomic, retain)HTTPRequest *seeDrive_request;
@end
