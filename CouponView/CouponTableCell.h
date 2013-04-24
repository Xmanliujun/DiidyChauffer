//
//  CouponTableCell.h
//  DiidyProject
//
//  Created by diidy on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponTableCell : UITableViewCell
{
    UILabel *nameLable;
    UILabel * closeDataLable;
    
}
@property(nonatomic,retain)UILabel *nameLable;
@property(nonatomic,retain)UILabel *closeDataLable;
@end
