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
<ASIHTTPRequestDelegate,HTTPRequestDelegate,MBProgressHUDDelegate>
{
    
    UIButton* returnButton;
    UIImageView*topImageView ;
    UILabel*centerLable;
    ASIHTTPRequest *billRequest;
    MBProgressHUD *HUD;
}
@property(nonatomic,retain)IBOutlet UILabel *feesReceivableLable;//应收费用
@property(nonatomic,retain)IBOutlet UILabel *couponLable;//优惠劵
@property(nonatomic,retain)IBOutlet UILabel *enioyCardLable;//畅享卡
@property(nonatomic,retain)IBOutlet UILabel *giftCardLable;//礼品卡
@property(nonatomic,retain)IBOutlet UILabel *diidyWalletLable;//滴滴钱包
@property(nonatomic,retain)IBOutlet UILabel *discountLable;//折扣
@property(nonatomic,retain)IBOutlet UILabel *implementationFeesLable;//实收费用
@property(nonatomic,retain)IBOutlet UIView *billInforView;

@property(nonatomic,retain)NSString * orderID;
@property(nonatomic, retain)HTTPRequest *bill_request;
@property (nonatomic, retain) MBProgressHUD *HUD;
@end
