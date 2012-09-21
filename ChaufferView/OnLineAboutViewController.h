//
//  OnLineAboutViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponDelegate.h"
@interface OnLineAboutViewController : UIViewController
<UISearchBarDelegate,CouponDelegate>
{
    UISearchBar* startAddrSearchBar;
    UIImageView*topImageView;
    
}

@end
