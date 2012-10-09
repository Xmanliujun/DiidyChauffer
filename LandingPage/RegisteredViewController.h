//
//  RegisteredViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
@interface RegisteredViewController : UIViewController
<ASIHTTPRequestDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>
{
    UILabel * contentLable;
    UILabel * promptLable;
    UITextField* inputNumberText;
    UIImageView * veriFicationImageView;
    NSString* registerIsTrue;
    UIImageView *registImageView;
    UIButton * returnButton;
    UIImageView* topImageView;
    UIButton *rigthbutton;
    
    MBProgressHUD *HUD;
    NSString * baseUrl;
    NSString * baseStatus;
}@property(nonatomic,retain)NSString *registerIsTrue;
@end
