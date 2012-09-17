//
//  ManageTableViewCell.h
//  DiidyProject
//
//  Created by diidy on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageTableViewCell : UITableViewCell{
    UILabel * orderNumberLable;
    UILabel *startTimeLable;
    UILabel * departureLable;
    UILabel * statusLable;
}
@property(nonatomic,retain) UILabel * orderNumberLable;
@property(nonatomic,retain)UILabel *startTimeLable;
@property(nonatomic,retain)UILabel *departureLable;
@property(nonatomic,retain)UILabel *statusLable;
@end
