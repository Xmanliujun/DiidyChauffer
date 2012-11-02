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
#import "ASIHTTPRequest.h"
@interface CouponViewController : UIViewController
<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,HTTPRequestDelegate,
ASIHTTPRequestDelegate,UIAlertViewDelegate>
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
    
    UITextField * giftNumberText;
    UIView * giftFrientView;
   
}
@property(nonatomic, retain)HTTPRequest *order_request;
@property(nonatomic,retain)NSString* detailCoupon;
@property(nonatomic,retain)NSString * couponID;


@end
