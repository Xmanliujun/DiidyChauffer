//
//  LandingViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
@interface LandingViewController : UIViewController
<UITextFieldDelegate,UIAlertViewDelegate,ASIHTTPRequestDelegate,MBProgressHUDDelegate>
{
    UITextField* passWordText;
    UITextField* inputNumberText;
    UIButton* returnButton;
    NSMutableArray * dataArry;
  //  UIImageView * LandImageView;
    UIImageView * topImageView;
    MBProgressHUD *HUD;
    
}
@property(nonatomic,retain)NSArray * couponArray;
@end
