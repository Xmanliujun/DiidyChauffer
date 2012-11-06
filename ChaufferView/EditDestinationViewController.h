//
//  EditDestinationViewController.h
//  DiidyChauffer
//
//  Created by diidy on 12-11-2.
//
//

#import <UIKit/UIKit.h>
#import "CouponDelegate.h"
@interface EditDestinationViewController : UIViewController
<UITextViewDelegate,CouponDelegate>
{
    UITextView *destinationView;
    
    UIImageView*topImageView;
    UIButton*returnButton;
    UILabel*centerLable;
    UIButton *rigthbutton;
}

@property(nonatomic,assign)id <CouponDelegate>DestionDelegate;
@property(nonatomic,retain)NSString* destinationNSSString;
@end
