//
//  LandingViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface LandingViewController : UIViewController
<UITextFieldDelegate,UIAlertViewDelegate,ASIHTTPRequestDelegate>
{
    UITextField* passWordText;
    UITextField* inputNumberText;
    UIButton* returnButton;
    NSMutableArray * dataArry;
    
}
@property(nonatomic,retain)NSArray * couponArray;
@end
