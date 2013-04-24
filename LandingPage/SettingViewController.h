//
//  SettingViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "HTTPRequest.h"
@interface SettingViewController : UIViewController
<UITextFieldDelegate,UIAlertViewDelegate,MBProgressHUDDelegate,HTTPRequestDelegate>
{
    int currentTime;
    UITextField * verificationText;
    UITextField * passWordText;
    UITextField * confirmText;
    UIButton *regainbutton;
    NSString*_judge;
    NSString * returenNews;
    UIButton*returnButton;
    UIImageView*topImageView;
    
   
    MBProgressHUD *HUD;
   
}

@property(nonatomic,retain)NSString * mobilNumber;
@property(nonatomic,retain)NSString * optype;
@property(nonatomic, retain)HTTPRequest *comRequest_request;
@property(nonatomic, retain)HTTPRequest *again_request;
-(id)initWithRegisteredOrForgot:(NSString*)judge;
@end
