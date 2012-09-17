//
//  MathViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MathViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
@interface MathViewController ()

@end

@implementation MathViewController
@synthesize totalCostLable;
@synthesize travelTimeLable,time,cost;
@synthesize travelTimeSlider;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    judge = 0;
    endAddional = 0;
    additional = 0;
    
    price1 = 60,addPrice1 = 30;
    price2 = 60,addPrice2 = 30;
    price3 = 70,addPrice3 = 40;
    price4 = 100,addPrice4 = 50;
    departure = NO;
    endParture = NO;
    startLable.hidden = YES;
    endLable.hidden = YES;
    CGRect costRect = totalCostLable.frame;
    totalCostLable.frame = CGRectMake(costRect.origin.x, 291, costRect.size.width, costRect.size.height);
   
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    self.navigationItem.title = @"算算看";
    timeArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
    minuteArray   = [[timeArray objectAtIndex:0] objectForKey:@"Cities"];
    
    UIImage * rigthImage =[UIImage imageNamed:@"u966_normal.png"];
    UIButton *rigthBarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthBarbutton setBackgroundImage:rigthImage forState:UIControlStateNormal];
    rigthBarbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rigthBarbutton.frame=CGRectMake(0.0, 100.0, rigthImage.size.width, rigthImage.size.height);
    [rigthBarbutton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBarbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];

    UIImage * detailExpenseImage = [UIImage imageNamed:@"u283_normal.png"];
    UIImageView *detailExpenseImageView = [[UIImageView alloc] initWithImage:detailExpenseImage];
    detailExpenseImageView.frame = CGRectMake(5.0, 230.0, detailExpenseImage.size.width, 120.0);
    [self.view addSubview:detailExpenseImageView];
    [detailExpenseImageView release];
    
    travelTime = [[UILabel alloc] initWithFrame:CGRectMake(95.0, 33.0, 61.0, 34.0)];
    travelTime.backgroundColor = [UIColor clearColor];
    travelTime.textAlignment = UITextAlignmentRight;
    travelTime.font = [UIFont fontWithName:@"Arial" size:14];
    [self.view addSubview:travelTime];
    
    travelMinute = [[UILabel alloc] initWithFrame:CGRectMake(156.0, 33.0, 61.0, 34.0)];
    travelMinute.backgroundColor = [UIColor clearColor];
    travelMinute.textAlignment = UITextAlignmentLeft;
    travelMinute.font = [UIFont fontWithName:@"Arial" size:14];
    [self.view addSubview:travelMinute];
    
    UIButton *rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"btn_020@2x.png"] forState:UIControlStateNormal];
     rigthbutton.frame=CGRectMake(280.0,0.0, 42.0, 42.0);
    [rigthbutton addTarget:self action:@selector(selectOK:) forControlEvents:UIControlEventTouchUpInside];

    UILabel * travelTimeLableq = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 120, 42)];
    travelTimeLableq.text = @"选择出发时间";
    travelTimeLableq.font = [UIFont fontWithName:@"Arial" size:14];
    travelTimeLableq.textAlignment = UITextAlignmentCenter;
    travelTimeLableq.backgroundColor = [UIColor clearColor];
    travelTimeLableq.textColor = [UIColor whiteColor];
    
    pickImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_023@2x.png"]];
    pickImageView.frame = CGRectMake(0.0f, 156.0f, 320.0f, 44.0f);
    pickImageView.hidden = YES;
    pickImageView.userInteractionEnabled = YES;
    [pickImageView addSubview:travelTimeLableq];
    [pickImageView addSubview:rigthbutton];
    [self.view addSubview:pickImageView];
    [travelTimeLableq release];
    
    timePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
    timePickerView.delegate = self;  
     timePickerView.dataSource = self;
    timePickerView.alpha = 0;
     timePickerView.showsSelectionIndicator = YES; 
    [self.view addSubview:timePickerView];
    
   
    
}
-(IBAction)updateValue:(id)sender
{
    
    int travelTimea= self.travelTimeSlider.value;
    self.travelTimeLable.text = [NSString stringWithFormat:@"%d分钟",travelTimea];
    NSArray* travelTimeArray = [travelTime.text componentsSeparatedByString:@":"];
    int departureTimeINT = [[travelTimeArray objectAtIndex:0] intValue];
    int departureMinuteINT = [travelMinute.text intValue];
    time.text = [NSString stringWithFormat:@"出发时间:%d点%d",departureTimeINT,departureMinuteINT];
   
    
    price = 0;
    BOOL flag = YES;
    int tempTimeLong = self.travelTimeSlider.value ;
    int tempMinute = departureMinuteINT;
    int tempHour = departureTimeINT;
    
    if(tempHour >= 6 && tempHour < 18){
        
        if(tempTimeLong / 60 == 0){
            price += price1;
            
        }else{
            tempTimeLong -= 60;
            tempHour++;
            if(tempHour == 24){
                tempHour = 0;
            }
            price += price1;
            
            if(tempTimeLong <= 0){
                flag = NO;
            }
            
            
            while(flag){
                if(tempHour >= 6 &&tempHour < 18){
                    tempTimeLong -= 60;
                    tempHour++;
                    if(tempHour == 24){
                        tempHour = 0;
                    }
                    price += addPrice1;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >= 18 && tempHour < 21){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice2;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >=21 && tempHour < 24){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice3;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >= 0 && tempHour < 6){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice4;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }
            }
        }
        
    }else if(tempHour >= 18 && tempHour < 21){
        
        if(tempTimeLong / 30 == 0){
            price += price2;
        }else{
            tempTimeLong -= 30;
            tempMinute += 30;
            if(tempMinute / 60  ==1){
                tempHour++;
                if(tempHour == 24){
                    tempHour = 0;
                }
                tempMinute -= 60;
            }
            price += price2;
            
            if(tempTimeLong <= 0){
                flag = NO;
            }
            
            while(flag){
                
                if(tempHour >= 6 && tempHour < 18){
                    tempTimeLong -= 60;
                    tempHour++;
                    if(tempHour == 24){
                        tempHour = 0;
                    }
                    price += addPrice1;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >= 18 && tempHour < 21){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice2;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >=21 && tempHour < 24){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice3;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >= 0 && tempHour < 6){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice4;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }
            }
        }
        
    }else if(tempHour >=21 && tempHour < 24){
        
        if(tempTimeLong / 30 == 0){
            price += price3;
        }else{
            tempTimeLong -= 30;
            tempMinute += 30;
            if(tempMinute / 60  ==1){
                tempHour++;
                if(tempHour == 24){
                    tempHour = 0;
                }
                tempMinute -= 60;
            }
            price += price3;
            
            if(tempTimeLong <= 0){
                flag = NO;
            }
            
            while(flag){
                
                if(tempHour >= 6 && tempHour < 18){
                    tempTimeLong -= 60;
                    tempHour++;
                    if(tempHour == 24){
                        tempHour = 0;
                    }
                    price += addPrice1;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >= 18 && tempHour < 21){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice2;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >=21 && tempHour < 24){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice3;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >= 0 && tempHour < 6){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice4;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }
            }
        }
        
    }else if(tempHour >= 0 && tempHour < 6){
        
        if(tempTimeLong / 30 == 0){
            price += price4;
        }else{
            tempTimeLong -= 30;
            tempMinute += 30;
            if(tempMinute / 60  ==1){
                tempHour++;
                if(tempHour == 24){
                    tempHour = 0;
                }
                tempMinute -= 60;
            }
            price += price4;
            
            if(tempTimeLong <= 0){
                flag = NO;
            }
            
            while(flag){
                
                if(tempHour >= 6 && tempHour < 18){
                    tempTimeLong -= 60;
                    tempHour++;
                    if(tempHour == 24){
                        tempHour = 0;
                    }
                    price += addPrice1;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >= 18 && tempHour < 21){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice2;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >=21 && tempHour < 24){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice3;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }else if(tempHour >= 0 && tempHour < 6){
                    tempTimeLong -= 30;
                    tempMinute += 30;
                    if(tempMinute / 60 ==1){
                        tempHour++;
                        if(tempHour == 24){
                            tempHour = 0;
                        }
                        tempMinute -= 60;
                    }
                    price += addPrice4;
                    if(tempTimeLong < 0){
                        flag = NO;
                    }
                }
            }
        }
    }
    self.cost.text = [NSString stringWithFormat:@"花费:%d元",price];
     self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",price+additional+endAddional];
}

-(IBAction)selectDepartureTime:(id)sender
{
   timePickerView.alpha = 1;
    pickImageView.hidden = NO;
  
}

-(void)returnMainView:(id)sender
{
    
    MainViewController * main = [[MainViewController alloc] init];
    [ShareApp.window setRootViewController:main];
    [main release];

}
-(void)selectOK:(id)sender
{ 
    
    NSArray* travelTimeArray = [travelTime.text componentsSeparatedByString:@":"];
    int departureTimeINT = [[travelTimeArray objectAtIndex:0] intValue];
    int departureMinuteINT = [travelMinute.text intValue];

    self.time.text = [NSString stringWithFormat:@"出发时间:  %d点%d分",departureTimeINT,departureMinuteINT];
    
    pickImageView.hidden = YES;
    timePickerView.alpha = 0;

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
        return 2;
    

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
        switch (component) {
            case 0:
                return [timeArray count];
                break;
            case 1:
                return [minuteArray count];;
                break;
            default:
                return 0;
                break;
        }

}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
        switch (component) {
            case 0:
                return [[timeArray objectAtIndex:row] objectForKey:@"State"];
                break;
            case 1:
                return  [minuteArray objectAtIndex:row];
            default:
                return nil;
                break;
        }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
        switch (component) {
            case 0:
                travelTime.text = [NSString stringWithFormat:@"%d:",row];
                break;
            case 1:
                if(row<10){
                    travelMinute.text = [NSString stringWithFormat:@"0%d",row];
                }else {
                    travelMinute.text = [NSString stringWithFormat:@"%d",row];
                }
                break;
            default:
                break;
        }
}
-(IBAction)selectDeparture:(UIButton *)sender
{
    CGRect costRect = totalCostLable.frame;
    CGRect endRect = endLable.frame;
    additional = 0;
   
    if (sender.tag ==60) {
        endParture = NO;
        if (!departure) {
            startLable.hidden = YES;
            CGRect costRect = totalCostLable.frame;
            int total = additional+price+endAddional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];

            totalCostLable.frame = CGRectMake(costRect.origin.x, 291, costRect.size.width, costRect.size.height);
        }else {
            startLable.hidden = YES;
           
            endLable.frame = CGRectMake(endRect.origin.x, 291, endRect.size.width, endRect.size.height);
            int total = additional+price+endAddional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            totalCostLable.frame = CGRectMake(costRect.origin.x, 306, costRect.size.width, costRect.size.height);
        }
        
        
    }else if (sender.tag==61) {
        endParture = YES;
        if (!departure) {
            startLable.hidden = NO;
            additional = 20;
            startLable.text = @"出发地在五环外加收:20元";
            totalCostLable.frame = CGRectMake(costRect.origin.x, 306, costRect.size.width, costRect.size.height);
            int total = additional+price+endAddional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
        }else {
            startLable.hidden = NO;
            additional = 20;
            startLable.text = @"出发地在五环外加收:20元";
            endLable.frame = CGRectMake(endRect.origin.x, 306, endRect.size.width, endRect.size.height);
            totalCostLable.frame = CGRectMake(costRect.origin.x, 328, costRect.size.width, costRect.size.height);
            int total = additional+price+endAddional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
        }
        
    }else if (sender.tag==62) {
        endParture = YES;
         startLable.hidden = NO;
        if (!departure) {
            int mHour = [travelTime.text intValue];
            if(mHour >= 21 || (mHour >= 0 && mHour <6)){
               
                startLable.text = @"出发地在六环外加收:50元.";
                additional=50;
                int total = additional+price+endAddional;
                totalCostLable.frame = CGRectMake(costRect.origin.x, 306, costRect.size.width, costRect.size.height);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            }else{
                startLable.text=@"出发地在六环外加收:20元.";
                additional= 20;
                int total = additional+price+endAddional;
                totalCostLable.frame = CGRectMake(costRect.origin.x, 306, costRect.size.width, costRect.size.height);

                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            }
        }else {
            int mHour = [travelTime.text intValue];
            if(mHour >= 21 || (mHour >= 0 && mHour <6)){
                
                startLable.text = @"出发地在六环外加收:50元.";
                additional=50;
                int total = additional+price+endAddional;
                endLable.frame = CGRectMake(endRect.origin.x, 306, endRect.size.width, endRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 328, costRect.size.width, costRect.size.height);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            }else{
                startLable.text=@"出发地在六环外加收:20元.";
                additional= 20;
                int total = additional+price+endAddional;
                endLable.frame = CGRectMake(endRect.origin.x, 306, endRect.size.width, endRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 328, costRect.size.width, costRect.size.height);                
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            }
        }

    }
               
}
-(IBAction)selectDestination:(UIButton*)sender
{
    CGRect costRect = totalCostLable.frame;
    CGRect endRect = endLable.frame;
    endAddional = 0;
    
    if (sender.tag ==70) {
        departure = NO;
        if (!endParture) {
            endLable.hidden = YES;
            CGRect costRect = totalCostLable.frame;
            int total = endAddional+price+additional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            
            totalCostLable.frame = CGRectMake(costRect.origin.x, 291, costRect.size.width, costRect.size.height);
        }else {
            endLable.hidden = YES;
            startLable.frame = CGRectMake(endRect.origin.x, 291, endRect.size.width, endRect.size.height);
            int total = endAddional+price+additional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            totalCostLable.frame = CGRectMake(costRect.origin.x, 306, costRect.size.width, costRect.size.height);
        }
        
        
    }else if (sender.tag==71) {
        departure = YES;
        if (!endParture) {
            endLable.hidden = NO;
            endAddional = 20;
            endLable.text = @"目的地在五环外加收:20元";
            endLable.frame = CGRectMake(endLable.frame.origin.x, 291, endLable.frame.size.width, endLable.frame.size.height);
            totalCostLable.frame = CGRectMake(costRect.origin.x, 306, costRect.size.width, costRect.size.height);
            int total = endAddional+price+additional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
        }else {
            endLable.hidden = NO;
            endAddional = 20;
            endLable.text = @"目的地在五环外加收:20元";
            endLable.frame = CGRectMake(endRect.origin.x, 306, endRect.size.width, endRect.size.height);
            totalCostLable.frame = CGRectMake(costRect.origin.x, 328, costRect.size.width, costRect.size.height);
            int total = endAddional+price+additional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
        }
        
    }else if (sender.tag==72) {
        departure = YES;
        endLable.hidden = NO;
        if (!endParture) {
            int mHour = [travelTime.text intValue];
            if(mHour >= 21 || (mHour >= 0 && mHour <6)){
                
                endLable.text = @"目的地在六环外加收:50元.";
                endAddional=50;
                int total = additional+price+endAddional;
                endLable.frame = CGRectMake(endLable.frame.origin.x, 291, endLable.frame.size.width, endLable.frame.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 306, costRect.size.width, costRect.size.height);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            }else{
                endLable.text=@"目的地在六环外加收:20元.";
               endAddional= 20;
                int total = endAddional+price+additional;
                endLable.frame = CGRectMake(endRect.origin.x, 291, endRect.size.width, endRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 306, costRect.size.width, costRect.size.height);
                
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            }
        }else {
            int mHour = [travelTime.text intValue];
            if(mHour >= 21 || (mHour >= 0 && mHour <6)){
                
                endLable.text = @"目的地在六环外加收:50元.";
                endAddional=50;
                int total = endAddional+price+additional;
                endLable.frame = CGRectMake(endRect.origin.x, 306, endRect.size.width, endRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 328, costRect.size.width, costRect.size.height);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            }else{
                endLable.text=@"目的地在六环外加收:20元.";
                endAddional= 20;
                int total =endAddional+price+additional;
                endLable.frame = CGRectMake(endRect.origin.x, 306, endRect.size.width, endRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 328, costRect.size.width, costRect.size.height);                
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            }
        }
        
    }


}

-(void)dealloc
{
    [cost release];
    [time release];
    [timeArray release];
    [minuteArray release];
    [travelMinute release];
    [timePickerView release];
    [pickImageView release];
    [totalCostLable release];
    [travelTimeSlider release];
    [travelTimeLable release];
    [travelTime release];
    [super dealloc];

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end