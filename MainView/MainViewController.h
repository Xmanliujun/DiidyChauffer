//
//  MainViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ASIHTTPRequest.h"
#import "DownLoadDelegate.h"
#import "AboutDiiDyViewController.h"
@interface MainViewController : UIViewController
<UIActionSheetDelegate,MFMessageComposeViewControllerDelegate,UIAlertViewDelegate,ASIHTTPRequestDelegate,DownLoadDelegate>
{   
    BOOL price;
    BOOL server;
    UIImageView *priceImageView;
    AboutDiiDyViewController * aboutDiidy;
}
@property(nonatomic,assign)BOOL version;
@end
