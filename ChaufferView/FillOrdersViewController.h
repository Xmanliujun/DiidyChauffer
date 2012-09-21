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
@interface FillOrdersViewController : UIViewController
<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CouponDelegate>
{
    NSMutableArray * dataArry;
    NSArray *timeArray;
    NSArray *minuteArray;
    UIImageView *pickImageView;
    UIPickerView * timePickView;
    NSMutableArray *peopleArray;
    UIPickerView *peoplePickView;
    NSString * departure;
    BOOL landed;
    int total;
    CLLocationCoordinate2D    location;
    UIImageView*topImageView;
    UIButton* returnButton;
    UIButton*rigthbutton;
    UILabel*centerLable ;
}

@property(nonatomic,retain)NSArray*couponaArray;
@property(nonatomic,retain) NSString *departuretimes;//出发时间
@property(nonatomic,retain) NSString *departureMinutes;//出发时间
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
@end
