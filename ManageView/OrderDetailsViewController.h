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
<UITableViewDataSource,UITableViewDelegate>
{
    DIIdyModel * diidyModel;
    UIImageView* topImageView;
    UIButton*returnButton;
    UILabel*centerLable;
}

@property(nonatomic,retain)UIView *clearingView;
@property(nonatomic,retain)DIIdyModel * diidyModel;
@end
