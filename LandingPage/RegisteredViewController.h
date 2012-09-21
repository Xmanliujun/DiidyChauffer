//
//  RegisteredViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface RegisteredViewController : UIViewController
<ASIHTTPRequestDelegate,UIAlertViewDelegate>
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
}@property(nonatomic,retain)NSString *registerIsTrue;
@end
