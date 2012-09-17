//
//  OrdersPreviewTwoViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersPreviewTwoViewController : UIViewController
@property(nonatomic,retain)NSArray * orderArray;
@property(nonatomic,retain)IBOutlet UILabel *departureLable;//出发地
@property(nonatomic,retain)IBOutlet UILabel *departureTimeLable;//出发时间
@property(nonatomic,retain)IBOutlet UILabel *numberOfPeopleLable;//人数
@property(nonatomic,retain)IBOutlet UILabel *destinationLable;//目的地
@property(nonatomic,retain)IBOutlet UILabel *contactLable;//联系人
@property(nonatomic,retain)IBOutlet UILabel *mobilNumberLable;//手机号码
@end
