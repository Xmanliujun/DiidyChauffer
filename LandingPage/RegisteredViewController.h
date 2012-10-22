//
//  RegisteredViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "HTTPRequest.h"
@interface RegisteredViewController : UIViewController
<UIAlertViewDelegate,MBProgressHUDDelegate,HTTPRequestDelegate>
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
    
   
}
@property(nonatomic,retain)NSString *registerIsTrue;
@property(nonatomic, retain)HTTPRequest *registAndPassword_request;

@end
