//
//  NotLoggedViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotLoggedViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView*topImageView;
    UIButton*returnButton;
    UIButton*rigthbutton;
    UILabel*centerLable;
}
@property(nonatomic,retain)NSArray * moreNameArray;
@end
