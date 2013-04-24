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
<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CouponDelegate,UITableViewDataSource,UITableViewDelegate>
{
   
    CLLocationCoordinate2D   location;
    NSMutableArray *peopleArray;
    NSArray *minuteArray;
   // NSMutableArray * dataArry;//存放数据类
    NSArray *timeArray;
   
    UIDatePicker *datePicker;
    UIPickerView *peoplePickView;
    UIImageView *pickImageView;
    UIImageView*topImageView;
    UIButton* returnButton;
    UIButton*rigthbutton;
    UILabel*centerLable ;
    BOOL landed;
    int total;
    int totalNumber;
    
    NSDate* _date;
    NSDateFormatter*dateformatter;
    UILabel * travelTimeLableq;
    UITableView*  orderTableView;
}
@property(nonatomic,retain)NSArray*couponaArray;//存放选择的优惠劵
@property(nonatomic,assign) BOOL landed;
@property(nonatomic,retain) NSString *departureMinuteString;//出发时间
@property(nonatomic,retain) NSString *couponString;//优惠劵
@property(nonatomic,retain) NSString * departure;//出发地
@property(nonatomic,retain) NSString *destinationString;//目的地
@property(nonatomic,retain) NSString *numberPeopleString;//人数
@property(nonatomic,assign) int total;
@property(nonatomic,retain)NSString*originalTime;
@property(nonatomic,retain)NSString*originalNumber;
@property(nonatomic,retain)NSString*nameString;
@property(nonatomic,retain)NSString*telString;
@property(nonatomic,retain)NSArray*dataArraya;//存放数据
-(id)initWithDeparture:(NSString*)departureString CLLocation:(CLLocationCoordinate2D)centers;
@end
