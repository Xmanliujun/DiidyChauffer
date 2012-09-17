//
//  SelectCouponViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponDelegate.h"
@interface SelectCouponViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * selectCouponAray;
    int rowNumber;
    NSMutableArray * useSelectCouponArray;
    id<CouponDelegate>delegate;
   

}
@property(nonatomic,assign)id<CouponDelegate>delegate;
@property(nonatomic,retain)NSArray * selectCouponAray;
@property(nonatomic,assign)int  rowNumber;
@property(nonatomic,assign)BOOL mark;
@property(nonatomic,retain)NSArray * orderPreArray;


@end
