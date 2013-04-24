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
<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,HTTPRequestDelegate,UIAlertViewDelegate>
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
    UITableView * couponTableView;
    
   
}
@property(nonatomic, retain)HTTPRequest *order_request;
@property(nonatomic, retain)HTTPRequest *order_stat;
@property(nonatomic, retain)HTTPRequest *order_send;
@property(nonatomic, retain)HTTPRequest *order_number;

@property(nonatomic,retain)NSString* detailCoupon;
@property(nonatomic,retain)NSString * couponID;
@property(nonatomic,retain)NSString * verCoupon;
@property(nonatomic,retain)NSString * timeString;
@property(nonatomic,retain)UIPageControl * couponPage;

@property(nonatomic,assign) BOOL couponStat;
@property (nonatomic, retain) NSTimer *couponTimer;
//@property(nonatomic,retain)NSString * content;
//@property(nonatomic,retain)UILabel * contentLable;


@end
