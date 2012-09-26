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
@interface DriverViewController : UIViewController
<ASIHTTPRequestDelegate>
{
    UILabel* centerLable;
    BOOL driverStatus;
    ASIHTTPRequest *requestDriveStatus;
    ASIHTTPRequest *requestOrderStatus;
    DriveLocationViewController* driveMap;
}
@end
