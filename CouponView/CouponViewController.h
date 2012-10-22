//
//  CouponViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "HTTPRequest.h"
@interface CouponViewController : UIViewController
<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,HTTPRequestDelegate>
{
   // UIImageView* leftImage;
    UIPageControl * couponPage;
    UILabel * centerLable;
    NSMutableArray * dataArry;
    UILabel * messgeLable;
    UIButton*returnButton;
    UIImageView*topImageView;
    UIScrollView * couponScrollView;
    int page;
    NSTimer *couponTimer;
    MBProgressHUD *HUD;
   
}
@property(nonatomic, retain)HTTPRequest *order_request;
@end
