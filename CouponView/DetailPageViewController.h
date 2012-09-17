//
//  DetailPageViewController.h
//  DiidyProject
//
//  Created by diidy on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import <MessageUI/MFMessageComposeViewController.h>

@interface DetailPageViewController : UIViewController
<UITextViewDelegate,ASIHTTPRequestDelegate,MFMessageComposeViewControllerDelegate>
{
    UIImageView *leftDetailImage;
    UIImageView * giftFrientImage;
    UITextView *giftNumberText;
    UITextView* contentView;
    UILabel *detailCenterLable;
}
@property(nonatomic,retain)NSString* detailCoupon;
@property(nonatomic,retain)NSString * couponID;
@end
