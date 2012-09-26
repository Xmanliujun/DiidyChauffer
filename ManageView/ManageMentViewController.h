//
//  ManageMentViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ManageMentViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UIButton* returnButton;
   
    NSMutableArray * listOrderArray;
    UIImageView*topImageView ;
    UILabel*centerLable;
    
    NSMutableData * receivedData;
    NSURLConnection * urlConnecction;
}

@end
