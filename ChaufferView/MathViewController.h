//
//  MathViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MathViewController : UIViewController
<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UILabel * travelTime;
    NSArray *timeArray;
    NSArray *minuteArray;
    UILabel * travelMinute;
    UIPickerView*timePickerView;
    UIImageView * pickImageView;
    NSDateFormatter *dateformatter;
    IBOutlet UIButton  *_fiveRing;
    IBOutlet UIButton  *_fiveOutSide;
    IBOutlet UIButton  *_sixOutSide;
    IBOutlet UIButton  *_deFiveRing;
    IBOutlet UIButton  *_deFiveOutSide;
    IBOutlet UIButton  *_deSixOutSide;
    IBOutlet UILabel  *startLable;
    IBOutlet UILabel  *endLable;
    BOOL departure;
    BOOL endParture;
   
    int judge;
    int additional;
    int endAddional;
    int price;
    int price1,addPrice1;
    int price2,addPrice2;
    int price3,addPrice3;
    int price4,addPrice4;
    
}
@property(nonatomic,retain)IBOutlet UILabel *travelTimeLable;
@property(nonatomic,retain)IBOutlet UILabel *time;
@property(nonatomic,retain)IBOutlet UILabel *cost;
@property(nonatomic,retain)IBOutlet UILabel *totalCostLable;
@property(nonatomic,retain)IBOutlet UISlider *travelTimeSlider;
-(IBAction)updateValue:(id)sender;
-(IBAction)selectDepartureTime:(id)sender;
-(IBAction)selectDeparture:(UIButton*)sender;
-(IBAction)selectDestination:(UIButton *)sender;
@property(nonatomic,retain)IBOutlet UIView *informationView;
@property(nonatomic,retain)IBOutlet UIView *feeInforView;
@end
