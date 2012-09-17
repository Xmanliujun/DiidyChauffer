//
//  FeedBackViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface FeedBackViewController : UIViewController
<ASIHTTPRequestDelegate>
{
    UITextView *feedBackText;
}
@property(nonatomic,retain)NSString*judge;
@end
