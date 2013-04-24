//
//  BillingDetailViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "HTTPRequest.h"
#import "MBProgressHUD.h"
@interface BillingDetailViewController : UIViewController
<ASIHTTPRequestDelegate,HTTPRequestDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    UIButton* returnButton;
    UIImageView*topImageView ;
    UILabel*centerLable;
    ASIHTTPRequest *billRequest;
    MBProgressHUD *HUD;
    UITableView*  orderTableView;

}
@property(nonatomic,retain) NSString *feesReceivablString;//应收费用
@property(nonatomic,retain) NSString *couponString;//优惠劵
@property(nonatomic,retain)  NSString *enioyCardString;//畅享卡
@property(nonatomic,retain)NSString *giftCardString;//礼品卡
@property(nonatomic,retain) NSString *diidyWalletString;//滴滴钱包
@property(nonatomic,retain) NSString *discountString;//折扣
@property(nonatomic,retain) NSString *implementationFeesString;//实收费用


@property(nonatomic,retain)NSString * orderID;
@property(nonatomic, retain)HTTPRequest *bill_request;
//@property (nonatomic, retain) MBProgressHUD *HUD;

@end
