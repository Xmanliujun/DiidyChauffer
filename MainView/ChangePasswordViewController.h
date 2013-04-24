//
//  ChangePasswordViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "HTTPRequest.h"
#import "MBProgressHUD.h"
@interface ChangePasswordViewController : UIViewController
<UITextFieldDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate,HTTPRequestDelegate,MBProgressHUDDelegate>
{
    UITextField * oldPasswordText;
    UITextField *newPassWordText;
    UITextField * confirmPassWordText;
    
    UIButton *rigthbutton;
    UIImageView* topImageView;
    UIButton* returnButton;
    UILabel* centerLable;
    MBProgressHUD *HUD;

}
@property(nonatomic, retain)HTTPRequest *changePassword_request;
@end
