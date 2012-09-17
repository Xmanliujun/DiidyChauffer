//
//  DriverViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "MapViewController.h"
@interface DriverViewController : UIViewController
<ASIHTTPRequestDelegate>
{
    UILabel* centerLable;
    MapViewController * map;
    BOOL driverStatus;
    ASIHTTPRequest *requestDriveStatus;
    ASIHTTPRequest *requestOrderStatus;
}
@end
