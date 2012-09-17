//
//  CouponViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface CouponViewController : UIViewController
<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    UIImageView* leftImage;
    UIPageControl * couponPage;
    UILabel * centerLable;
    NSMutableArray * dataArry;
    UILabel * messgeLable;
}

@end
