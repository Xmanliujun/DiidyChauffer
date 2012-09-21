//
//  SettingViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface SettingViewController : UIViewController
<UITextFieldDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate>
{
    int currentTime;
    UITextField * verificationText;
    UITextField * passWordText;
    UITextField * confirmText;
    UIButton *regainbutton;
    //UIImageView* promptImageView;
  //  UILabel * promtLable;
    NSString*_judge;
    //UIImageView *modifyImageView;
    //UILabel* modifyLable;
    NSString * returenNews;
    UIButton*returnButton;
    UIImageView*topImageView;
}

@property(nonatomic,retain)NSString * mobilNumber;
@property(nonatomic,retain)NSString * optype;
-(id)initWithRegisteredOrForgot:(NSString*)judge;


@end
