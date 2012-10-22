//
//  FeedBackViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "HTTPRequest.h"
#import "MBProgressHUD.h"
@interface FeedBackViewController : UIViewController
<ASIHTTPRequestDelegate,HTTPRequestDelegate,MBProgressHUDDelegate>
{
    UITextView *feedBackText;
    UIImageView*topImageView;
    UIButton*returnButton;
    UIButton*rigthbutton;
    UILabel*centerLable;
    
    MBProgressHUD *HUD;

}
@property(nonatomic,retain)NSString*judge;
@property(nonatomic, retain)HTTPRequest *feedBack_request;
@end
