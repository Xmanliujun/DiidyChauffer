//
//  FromPossibleViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponDelegate.h"
@interface FromPossibleViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView*topImageView;
    UIButton*returnButton;
    UILabel *centerLable ;
}
@property(nonatomic,retain)NSString* possibleCity;
@property(nonatomic,retain)NSArray * possibleCityArray;

@end
