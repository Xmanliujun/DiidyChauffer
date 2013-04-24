//
//  OrdersPreviewViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIIdyModel.h"
#import "VerticallyAlignedLabel.h"
#import "HTTPRequest.h"
#import "MBProgressHUD.h"
@interface OrdersPreviewViewController : UIViewController
<UIAlertViewDelegate,HTTPRequestDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * couponArray;
    UIButton*returnButton;
    UIButton*rigthbutton;
    UIImageView*topImageView;
    UILabel* centerLable;
    MBProgressHUD *HUD;
    
    NSMutableString *couString;
}
@property(nonatomic,retain)NSArray * orderArray;//存放填写的内容
@property(nonatomic,retain)NSArray * useCouponArray;//存放选择的优惠劵
@property(nonatomic,retain)NSArray * selectArray;//存放数据类
@property(nonatomic,retain) VerticallyAlignedLabel *couponLable;//优惠劵
@property(nonatomic, retain)HTTPRequest *submit_request;

@end
