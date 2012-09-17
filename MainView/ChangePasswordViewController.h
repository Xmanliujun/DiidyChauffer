//
//  ChangePasswordViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface ChangePasswordViewController : UIViewController
<UITextFieldDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate>
{
    UITextField * oldPasswordText;
    UITextField *newPassWordText;
    UITextField * confirmPassWordText;
}
@end
