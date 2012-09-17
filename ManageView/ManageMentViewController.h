//
//  ManageMentViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface ManageMentViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    UIButton* returnButton;
   
    NSMutableArray * listOrderArray;
    ASIHTTPRequest *requestHTTP;

}

@end
