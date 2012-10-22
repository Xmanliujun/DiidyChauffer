//
//  FillOrdersViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponDelegate.h"
#import "BMapKit.h"
#import "HTTPRequest.h"
@interface FillOrdersViewController : UIViewController
<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CouponDelegate,HTTPRequestDelegate>
{
   
    
    CLLocationCoordinate2D   location;
    NSMutableArray *peopleArray;
    NSArray *minuteArray;
    NSMutableArray * dataArry;//存放数据类
    NSArray *timeArray;
    NSString * departure;
    UIDatePicker *datePicker;
    UIPickerView *peoplePickView;
    UIImageView *pickImageView;
    UIImageView*topImageView;
    UIButton* returnButton;
    UIButton*rigthbutton;
    UILabel*centerLable ;
    BOOL landed;
    int total;
    
    NSDate* _date;
   
    NSDateFormatter*dateformatter;
}

@property(nonatomic,retain)NSArray*couponaArray;//存放选择的优惠劵
@property(nonatomic,assign) BOOL landed;
@property(nonatomic,retain)IBOutlet UITextField *destinationField;
@property(nonatomic,retain)IBOutlet UITextField *nameField;
@property(nonatomic,retain)IBOutlet UITextField *telNumberField;
@property(nonatomic,retain)IBOutlet UIView *backGroundView;
@property(nonatomic,retain)IBOutlet UIImageView *newsImangeView;
@property(nonatomic,retain)IBOutlet UILabel *departureLable;//出发地
@property(nonatomic,retain)IBOutlet UILabel *departureMinuteLable;//出发时间
@property(nonatomic,retain)IBOutlet UILabel *numberPeopleLable;//人数
@property(nonatomic,retain)IBOutlet UIView *couponView;
@property(nonatomic,retain)IBOutlet UILabel *couponLable;

-(IBAction)selectDeparture:(id)sender;
-(IBAction)selectDepartureTime:(id)sender;
-(IBAction)selectNumberPeople:(id)sender;
-(IBAction)useCoupon:(id)sender;
-(id)initWithDeparture:(NSString*)departureString CLLocation:(CLLocationCoordinate2D)centers;

@property(nonatomic, retain)HTTPRequest *getCoupon_request;
@end
