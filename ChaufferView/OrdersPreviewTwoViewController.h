//
//  OrdersPreviewTwoViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "HTTPRequest.h"
#import "MBProgressHUD.h"
@interface OrdersPreviewTwoViewController : UIViewController
<UIAlertViewDelegate,ASIHTTPRequestDelegate,HTTPRequestDelegate,MBProgressHUDDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIButton *rigthbutton;
    UIImageView* topImageView;
    UIButton* returnButton;
    UILabel* centerLable;
    MBProgressHUD *HUD;
}
@property(nonatomic,retain)NSArray * orderArray;
@property(nonatomic, retain)HTTPRequest *submit_request;
@property(nonatomic,assign)BOOL markPre;


@end
