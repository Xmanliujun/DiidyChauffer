//
//  OrderDetailsViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIIdyModel.h"
@interface OrderDetailsViewController : UIViewController
{
    DIIdyModel * diidyModel;
    UIImageView* topImageView;
    UIButton*returnButton;
    UILabel*centerLable;
}
@property(nonatomic,retain)IBOutlet UILabel *orderNumberLable;//点单编号
@property(nonatomic,retain)IBOutlet UILabel *orderStatusLable;//订单状态
@property(nonatomic,retain)IBOutlet UILabel *orderTimerLable;//下单时间
@property(nonatomic,retain)IBOutlet UILabel *departureLable;//出发地
@property(nonatomic,retain)IBOutlet UILabel *departureTimeLable;//出发时间
@property(nonatomic,retain)IBOutlet UILabel *numberOfPeopleLable;//人数
@property(nonatomic,retain)IBOutlet UILabel *destinationLable;//目的地
@property(nonatomic,retain)IBOutlet UILabel *contactLable;//联系人
@property(nonatomic,retain)IBOutlet UILabel *mobilNumberLable;//手机号码
@property(nonatomic,retain)IBOutlet UILabel *couponLable;//优惠劵
@property(nonatomic,retain)IBOutlet UILabel *leftDepartureTimeLable;
@property(nonatomic,retain)DIIdyModel * diidyModel;
@end
