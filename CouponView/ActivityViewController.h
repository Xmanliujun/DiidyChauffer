//
//  ActivityViewController.h
//  DiidyChauffer
//
//  Created by diidy on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityViewController : UIViewController
{

    UIButton*returnButton;
    UIImageView*topImageView;
    UILabel*centerLable;
}
@property(nonatomic,retain)IBOutlet UILabel *eventName;//点单编号
@property(nonatomic,retain)NSString*diidyTitle;
@property(nonatomic,retain)NSString * diidyContent;
@end
