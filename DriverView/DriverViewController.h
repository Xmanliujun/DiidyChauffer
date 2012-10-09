//
//  DriverViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "DriveLocationViewController.h"
#import "MBProgressHUD.h"
@interface DriverViewController : UIViewController
<ASIHTTPRequestDelegate,MBProgressHUDDelegate>
{
    UILabel* centerLable;
    BOOL driverStatus;
    ASIHTTPRequest *requestDriveStatus;
    ASIHTTPRequest *requestOrderStatus;
    DriveLocationViewController* driveMap;
    MBProgressHUD *HUD;
}
@end
