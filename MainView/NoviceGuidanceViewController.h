//
//  NoviceGuidanceViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoviceGuidanceViewController : UIViewController
<UIScrollViewDelegate>
{
    UIPageControl*  couponPage;
    
    UIImageView* topImageView;
    UIButton* returnButton;
    UILabel* centerLable;
    
}
@property(nonatomic,retain)NSString*noviceGuidan;
@end
