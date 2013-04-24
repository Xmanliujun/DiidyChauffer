//
//  OnLineAboutViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponDelegate.h"
#import "LocationDemoViewController.h"
#import "HTTPRequest.h"
//#import "MBProgressHUD.h"
@interface OnLineAboutViewController : UIViewController
<UISearchBarDelegate,CouponDelegate,HTTPRequestDelegate>
{
    UISearchBar* startAddrSearchBar;
    UIImageView*topImageView;
    LocationDemoViewController* locationDomo;
     int total;
    NSMutableArray * dataArry;
   // MBProgressHUD *HUD;

    
}
@property(nonatomic,assign)  CLLocationCoordinate2D   possibleLocation;
@property(nonatomic,retain)NSString*cityName;
@property(nonatomic,assign)BOOL possible;
@property(nonatomic,assign)BOOL coupossible;
@property(nonatomic, retain)HTTPRequest *getCoupon_request;
@end
