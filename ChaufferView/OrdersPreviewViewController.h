//
//  OrdersPreviewViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIIdyModel.h"
@interface OrdersPreviewViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * couponArray;
}
@property(nonatomic,retain)NSArray * orderArray;
@property(nonatomic,retain)NSArray * useCouponArray;
@property(nonatomic,retain)NSArray * selectArray;
@property(nonatomic,retain)IBOutlet UILabel *departureLable;//出发地
@property(nonatomic,retain)IBOutlet UILabel *departureTimeLable;//出发时间
@property(nonatomic,retain)IBOutlet UILabel *numberOfPeopleLable;//人数
@property(nonatomic,retain)IBOutlet UILabel *destinationLable;//目的地
@property(nonatomic,retain)IBOutlet UILabel *contactLable;//联系人
@property(nonatomic,retain)IBOutlet UILabel *mobilNumberLable;//手机号码
@property(nonatomic,retain)IBOutlet UITableView*couponTableView;//优惠劵列表
@property(nonatomic,retain)IBOutlet UILabel *remarkLable;//备注
@end
