//
//  MoreViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * moreNameArray;
    

}
@property(nonatomic,retain)NSArray *moreNameArray;
@end
