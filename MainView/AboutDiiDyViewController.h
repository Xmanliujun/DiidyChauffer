//
//  AboutDiiDyViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "DownLoadDelegate.h"
#import "HTTPRequest.h"
@interface AboutDiiDyViewController : UIViewController
<MBProgressHUDDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate,HTTPRequestDelegate>
{
    UIButton *returnButton;
    UILabel *centerLable;
    UIImageView *topImageView;
    IBOutlet UIButton*versionButton;
    MBProgressHUD *HUD;
    ASIHTTPRequest *requestAsi;
    ASIHTTPRequest* requestAsiVer;
}
-(void)checkNewVersion;
-(void)cancelConnection;
@property(nonatomic,assign)id <DownLoadDelegate>delegate;
@property(nonatomic, retain)HTTPRequest *main_request;
@property(nonatomic, retain)HTTPRequest *aboutDiidy_request;
@end
