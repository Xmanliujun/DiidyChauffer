//
//  ManageMentViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface ManageMentViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    UIButton* returnButton;
   
    NSMutableArray * listOrderArray;
    UIImageView*topImageView ;
    UILabel*centerLable;
    
    NSMutableData * receivedData;
    NSURLConnection * urlConnecction;
    BOOL sqlitBool;
    
    MBProgressHUD *HUD;
    NSString * baseUrl;

}

@end
