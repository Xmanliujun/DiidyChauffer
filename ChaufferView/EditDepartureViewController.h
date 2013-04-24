//
//  EditDepartureViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "CouponDelegate.h"
@interface EditDepartureViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,BMKSearchDelegate,CouponDelegate>
{
    UITableView * orderTableView;
    UITextView *departureView ;
    BMKSearch* search;
    
    UIImageView*topImageView;
    UIButton*returnButton;
    UILabel*centerLable;
    UIButton *rigthbutton;
    CLLocationCoordinate2D    locationDe;
    NSString*departure;
    NSMutableArray*addressinformationArray;

}

@property(nonatomic,assign)id <CouponDelegate>DepartureDelegate;
@property(nonatomic,retain)NSString* departureName;
@property(nonatomic,assign)CLLocationCoordinate2D locationDe;
@end
