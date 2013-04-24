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
#import <QuartzCore/QuartzCore.h>
#import "MobClick.h"
@interface MathViewController ()

@end

@implementation MathViewController
@synthesize totalCostLable;
@synthesize travelTimeLable,time,cost;
@synthesize travelTimeSlider,informationView,feeInforView;
@synthesize timeInforView,originalTime,originalMinute;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark-pickerView
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
    
    NSLog(@"获取时间信息");
    
    switch (component) {
        case 0:
            travelTime.text = [NSString stringWithFormat:@"%d:",row];
            if (row>=21||row<6) {
                if (_sixOutSide.selected) {
                    
                     startLable.text = @"出发地在六环外加收:50元";
                }
                
                if (_deSixOutSide.selected) {
                    
                     endLable.text = @"目的地在五环外加收:50元";
                }
            
            }else {
                if (_sixOutSide.selected) {
                    
                    startLable.text = @"出发地在六环外加收:50元";
                }
                
                if (_deSixOutSide.selected) {
                    endLable.text = @"目的地在五环外加收:50元";
                }

            }
            
            
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
#pragma mark-Button
-(IBAction)updateValue:(id)sender
{
     [MobClick event:@"m03_d003_0001"];
    int travelTimea= self.travelTimeSlider.value;
    
    if (self.travelTimeSlider.value/60>=1) {
        
        int traverTimeA = self.travelTimeSlider.value/60;
        int travelMin = self.travelTimeSlider.value-traverTimeA*60;
         self.travelTimeLable.text = [NSString stringWithFormat:@"%d小时%d分钟",traverTimeA,travelMin];
        
    }else{
        
         self.travelTimeLable.text = [NSString stringWithFormat:@"%d分钟",travelTimea];
    }
    
    NSArray* travelTimeArray = [travelTime.text componentsSeparatedByString:@":"];
    int departureTimeINT = [[travelTimeArray objectAtIndex:0] intValue];
    int departureMinuteINT = [travelMinute.text intValue];
    self.time.text = [NSString stringWithFormat:@"出发时间:  %d点%d分",departureTimeINT,departureMinuteINT];
   
    price = 0;
    BOOL flag = YES;
    int tempTimeLong = self.travelTimeSlider.value ;
    int tempMinute = departureMinuteINT;
    int tempHour = departureTimeINT;
    
    if(tempHour >= 8 && tempHour < 18){
        
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
                if(tempHour >= 8 &&tempHour < 18){
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
                }else if(tempHour >=21 && tempHour < 23){
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
                }else if((tempHour >= 0 && tempHour < 8)||tempHour >= 23){
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
                
                if(tempHour >= 8 && tempHour < 18){
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
                }else if(tempHour >=21 && tempHour < 23){
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
                }else if((tempHour >= 0 && tempHour < 8)||tempHour>=23){
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
        
    }else if(tempHour >=21 && tempHour < 23){
        
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
                
                if(tempHour >= 8 && tempHour < 18){
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
                }else if(tempHour >=21 && tempHour < 23){
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
                }else if((tempHour >= 0 && tempHour < 8)||tempHour>=23){
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
        
    }else if((tempHour >= 0 && tempHour < 8)||tempHour>=23){
        
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
                
                if(tempHour >= 8 && tempHour < 18){
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
                }else if(tempHour >=21 && tempHour < 23){
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
                }else if((tempHour >= 0 && tempHour < 8)||tempHour>=23){
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
    
    self.originalTime = travelTime.text;
    self.originalMinute = travelMinute.text;
    
    self.time.text = [NSString stringWithFormat:@"出发时间:  %d点%d分",departureTimeINT,departureMinuteINT];
    
    pickImageView.hidden = YES;
    timePickerView.alpha = 0;
    
}

-(void)selectCancel:(id)sender
{
    pickImageView.hidden = YES;
    timePickerView.alpha = 0;
   travelTime.text= [NSString stringWithFormat:@"%@",self.originalTime];
   travelMinute.text= self.originalMinute;


}
-(IBAction)selectDeparture:(UIButton *)sender
{
   
    if (sender.tag==60) {
        
        _fiveRing.selected = !_fiveRing.selected;
        _fiveOutSide.selected = NO;
        _sixOutSide.selected = NO;
        
    }else if(sender.tag==61){
        
        _fiveOutSide.selected = !_fiveOutSide.selected;
        _fiveRing.selected = NO;
        _sixOutSide.selected = NO;
        
    }else {
        
        _sixOutSide.selected = !_sixOutSide.selected;
        _fiveRing.selected = NO;
        _fiveOutSide.selected = NO;
    }
    
    
    CGRect costRect =  CGRectMake(24.0f, 293.0f, 251.0f, 20.0f);
   
    CGRect endRect = CGRectMake(24.0f, 293.0f, 251.0f, 20.0f);
    additional = 0;
   
    if (sender.tag ==60) {
        endParture = NO;
        if (!departure) {
            startLable.hidden = YES;
            CGRect costRect = totalCostLable.frame;
            int total = additional+price+endAddional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,90.0f);
            totalCostLable.frame = CGRectMake(costRect.origin.x, 293.0f, costRect.size.width, costRect.size.height);
        }else {
            startLable.hidden = YES;
           
            endLable.frame = CGRectMake(endRect.origin.x, 293.0f, endRect.size.width, endRect.size.height);
            int total = additional+price+endAddional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
             self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,110.0f);
            totalCostLable.frame = CGRectMake(costRect.origin.x, 313.0f, costRect.size.width, costRect.size.height);
        }
       
        
    }else if (sender.tag==61) {
        endParture = YES;
        if (!departure) {
            startLable.hidden = NO;
            additional = 20;
            startLable.text = @"出发地在五环外加收:20元";
            startLable.frame =CGRectMake(costRect.origin.x, 293.0f, costRect.size.width, costRect.size.height);
            totalCostLable.frame = CGRectMake(costRect.origin.x, 313.0f, costRect.size.width, costRect.size.height);
            int total = additional+price+endAddional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
             self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width, 110.0f);
        }else {
            startLable.hidden = NO;
            additional = 20;
            startLable.text = @"出发地在五环外加收:20元";
            startLable.frame =CGRectMake(costRect.origin.x, 293.0f, costRect.size.width, costRect.size.height);
            endLable.frame = CGRectMake(endRect.origin.x, 313.0f, endRect.size.width, endRect.size.height);
            totalCostLable.frame = CGRectMake(costRect.origin.x, 333.0f, costRect.size.width, costRect.size.height);
            int total = additional+price+endAddional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,130.0f);
        }
        
    }else if (sender.tag==62) {
        endParture = YES;
         startLable.hidden = NO;
        if (!departure) {
            int mHour = [travelTime.text intValue];
            if(mHour >= 21 || (mHour >= 0 && mHour <8)){
               
                startLable.text = @"出发地在六环外加收:50元";
                additional=50;
                int total = additional+price+endAddional;
                
                startLable.frame =CGRectMake(costRect.origin.x, 293.0f, costRect.size.width, costRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 313.0f, costRect.size.width, costRect.size.height);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
                self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width, 110.0f);
                
            }else{
                startLable.text=@"出发地在六环外加收:50元";
                additional= 50;
                int total = additional+price+endAddional;
                startLable.frame =CGRectMake(costRect.origin.x, 293.0f, costRect.size.width, costRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 313.0f, costRect.size.width, costRect.size.height);
                self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,110.0f);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
            }
        }else {
            int mHour = [travelTime.text intValue];
            if(mHour >= 21 || (mHour >= 0 && mHour <8)){
                
                startLable.text = @"出发地在六环外加收:50元";
                additional=50;
                int total = additional+price+endAddional;
                startLable.frame =CGRectMake(costRect.origin.x, 293.0f, costRect.size.width, costRect.size.height);
                endLable.frame = CGRectMake(endRect.origin.x, 313.0f, endRect.size.width, endRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 333.0f, costRect.size.width, costRect.size.height);
                self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width, 130.0f);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
                
            }else{
                
                startLable.text=@"出发地在六环外加收:50元";
                additional= 50;
                int total = additional+price+endAddional;
                startLable.frame =CGRectMake(costRect.origin.x, 293.0f, costRect.size.width, costRect.size.height);
                endLable.frame = CGRectMake(endRect.origin.x, 313.0f, endRect.size.width, endRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 333.0f, costRect.size.width, costRect.size.height);
                self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width, 130.0f);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
                
            }
        }

    }
               
}
-(IBAction)selectDestination:(UIButton*)sender
{
    
    if (sender.tag==70) {
        _deFiveRing.selected = !_deFiveRing.selected;
        _deFiveOutSide.selected = NO;
        _deSixOutSide.selected = NO;
    }else if(sender.tag==71){
        _deFiveOutSide.selected = !_deFiveOutSide.selected;
        _deFiveRing.selected = NO;
        _deSixOutSide.selected = NO;
    }else {
        _deSixOutSide.selected = !_deSixOutSide.selected;
        _deFiveOutSide.selected = NO;
        _deFiveRing.selected = NO;
    }

    
    
    CGRect costRect = CGRectMake(24.0f, 293.0f, 251.0f, 20.0f);
    CGRect endRect = CGRectMake(24.0f, 293.0f, 251.0f, 20.0f);
    endAddional = 0;
    
    if (sender.tag ==70) {
        departure = NO;
        if (!endParture) {
            
            endLable.hidden = YES;
            CGRect costRect = totalCostLable.frame;
            int total = endAddional+price+additional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d元",total];
             self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,90.0f);
            totalCostLable.frame = CGRectMake(costRect.origin.x, 293.0f, costRect.size.width, costRect.size.height);
            
        }else {
            
            endLable.hidden = YES;
            startLable.frame = CGRectMake(endRect.origin.x, 293.0f, endRect.size.width, endRect.size.height);
            int total = endAddional+price+additional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d元",total];
             self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,110.0f);
             self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,110.0f);
            totalCostLable.frame = CGRectMake(costRect.origin.x, 313.0f, costRect.size.width, costRect.size.height);
        }
        
        
    }else if (sender.tag==71) {
        
        departure = YES;
        
        if (!endParture) {
            
            endLable.hidden = NO;
            endAddional = 20;
            endLable.text = @"目的地在五环外加收:20元";
            endLable.frame = CGRectMake(endLable.frame.origin.x, 293.0f, endLable.frame.size.width, endLable.frame.size.height);
            totalCostLable.frame = CGRectMake(costRect.origin.x, 313.0f, costRect.size.width, costRect.size.height);
             self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,110.0f);
            int total = endAddional+price+additional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d元",total];
            
        }else {
            
            endLable.hidden = NO;
            endAddional = 20;
            endLable.text = @"目的地在五环外加收:20元";
            startLable.frame = CGRectMake(endRect.origin.x, 293.0f, endRect.size.width, endRect.size.height);
            endLable.frame = CGRectMake(endRect.origin.x, 313.0f, endRect.size.width, endRect.size.height);
            totalCostLable.frame = CGRectMake(costRect.origin.x, 333.0f, costRect.size.width, costRect.size.height);
             self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,130.0f);
            int total = endAddional+price+additional;
            self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d元",total];
            
        }
        
    }else if (sender.tag==72) {
        departure = YES;
        endLable.hidden = NO;
        if (!endParture) {
            int mHour = [travelTime.text intValue];
            if(mHour >= 21 || (mHour >= 0 && mHour <8)){
                
                endLable.text = @"目的地在六环外加收:50元";
                endAddional=50;
                int total = additional+price+endAddional;
                endLable.frame = CGRectMake(endLable.frame.origin.x, 293.0f, endLable.frame.size.width, endLable.frame.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 313.0f, costRect.size.width, costRect.size.height);
                 self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,110.0f);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d元都是些啊啊啊啊啊、 ",total];
                
            }else{
                
                endLable.text=@"目的地在六环外加收:50元";
                endAddional= 50;
                int total = endAddional+price+additional;
                endLable.frame = CGRectMake(endRect.origin.x, 293.0f, endRect.size.width, endRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 313.0f, costRect.size.width, costRect.size.height);
                 self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,110.0f);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
                
            }
        }else {
            
            int mHour = [travelTime.text intValue];
            if(mHour >= 21 || (mHour >= 0 && mHour <8)){
                
                endLable.text = @"目的地在六环外加收:50元";
                endAddional=50;
                int total = endAddional+price+additional;
                startLable.frame = CGRectMake(endRect.origin.x, 293.0f, endRect.size.width, endRect.size.height);
                endLable.frame = CGRectMake(endRect.origin.x, 313.0f, endRect.size.width, endRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 333.0f, costRect.size.width, costRect.size.height);
                 self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,130.0f);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
                
            }else{
                
                endLable.text=@"目的地在六环外加收:50元";
                endAddional= 50;
                int total =endAddional+price+additional;
                startLable.frame = CGRectMake(endRect.origin.x, 293.0f, endRect.size.width, endRect.size.height);
                endLable.frame = CGRectMake(endRect.origin.x, 313.0f, endRect.size.width, endRect.size.height);
                totalCostLable.frame = CGRectMake(costRect.origin.x, 333.0f, costRect.size.width, costRect.size.height);
                 self.feeInforView.frame = CGRectMake(self.feeInforView.frame.origin.x, self.feeInforView.frame.origin.y, self.feeInforView.frame.size.width,130.0f);
                self.totalCostLable.text = [NSString stringWithFormat:@"费用合计:%d",total];
                
            }
        }
        
    }
}
#pragma mark - System Approach
-(void)setMathView
{
    
    self.informationView.backgroundColor=[UIColor whiteColor];
    [[self.informationView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[self.informationView layer] setShadowRadius:5];
    [[self.informationView layer] setShadowOpacity:1];
    [[self.informationView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[self.informationView layer] setCornerRadius:7];
    [[self.informationView layer] setBorderWidth:1];
    [[self.informationView layer] setBorderColor:[UIColor grayColor].CGColor];
    [self.view sendSubviewToBack: self.informationView];
    
    self.feeInforView.backgroundColor=[UIColor whiteColor];
    [[self.feeInforView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[self.feeInforView layer] setShadowRadius:5];
    [[self.feeInforView layer] setShadowOpacity:1];
    [[self.feeInforView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[self.feeInforView layer] setCornerRadius:7];
    [[self.feeInforView layer] setBorderWidth:1];
    [[self.feeInforView layer] setBorderColor:[UIColor grayColor].CGColor];
    [self.view sendSubviewToBack: self.feeInforView];
    
    self.timeInforView.backgroundColor=[UIColor lightGrayColor];
    [[self.timeInforView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[self.timeInforView layer] setShadowRadius:5];
    [[self.timeInforView layer] setShadowOpacity:1];
    [[self.timeInforView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[self.timeInforView layer] setCornerRadius:7];
    [[self.timeInforView layer] setBorderWidth:1];
    [[self.timeInforView layer] setBorderColor:[UIColor grayColor].CGColor];
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
    
    [self setMathView];
    
    CGRect costRect = totalCostLable.frame;
    totalCostLable.frame = CGRectMake(costRect.origin.x, 293.0f, costRect.size.width, costRect.size.height);
    self.cost.text =@"花费:0元";
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    timeArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
    minuteArray   = [[timeArray objectAtIndex:0] objectForKey:@"Cities"];
    
    UIImageView* topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, -2.0f, 320.0f, 49.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    [topImageView release];
    
    UILabel *centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    centerLable.font = [UIFont fontWithName:@"Arial" size:17];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.text = @"算 算 看";
    self.navigationItem.titleView = centerLable;
    [centerLable release]; 
    
    UIImage * rigthImage =[UIImage imageNamed:@"33.png"];
    UIButton *rigthBarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthBarbutton setBackgroundImage:rigthImage forState:UIControlStateNormal];
    [rigthBarbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rigthBarbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    [rigthBarbutton setTitle:@"主页" forState:UIControlStateNormal];
    rigthBarbutton.frame=CGRectMake(260.0f, 7.0f, 50.0f, 30.0f);
    [rigthBarbutton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBarbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];
    
    travelTime = [[UILabel alloc] initWithFrame:CGRectMake(95.0, 26.0, 61.0, 34.0)];
    travelTime.backgroundColor = [UIColor clearColor];
    travelTime.textAlignment = NSTextAlignmentRight;
    travelTime.font = [UIFont fontWithName:@"Arial" size:14];
    [self.view addSubview:travelTime];
    
    travelMinute = [[UILabel alloc] initWithFrame:CGRectMake(156.0, 26.0, 61.0, 34.0)];
    travelMinute.backgroundColor = [UIColor clearColor];
    travelMinute.textAlignment = NSTextAlignmentLeft;
    travelMinute.font = [UIFont fontWithName:@"Arial" size:14];
    [self.view addSubview:travelMinute];
    
    NSDate * senddate=[NSDate date];
    dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    NSArray*timesArray = [locationString componentsSeparatedByString:@":"];
    
    travelTime.text = [NSString stringWithFormat:@"%@:",[timesArray objectAtIndex:0]];
    travelMinute.text = [NSString stringWithFormat:@"%@",[timesArray objectAtIndex:1]];
    self.time.text = [NSString stringWithFormat:@"出发时间:  %@点%@分",[timesArray objectAtIndex:0],[timesArray objectAtIndex:1]];
    self.originalTime = travelTime.text;
    self.originalMinute = travelMinute.text;
    
    UIButton *rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    rigthbutton.frame=CGRectMake(262.0f,7.0f, 49.0f, 30.0f);
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [rigthbutton setTitle:@"完成" forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(selectOK:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelbutton.backgroundColor = [UIColor clearColor];
    [cancelbutton setBackgroundImage:[UIImage imageNamed:@"button-3.png"] forState:UIControlStateNormal];
    //[cancelbutton setImage:[UIImage imageNamed:@"button-3.png"] forState:UIControlStateNormal];
    cancelbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
    cancelbutton.frame=CGRectMake(9.0f,7.0f,49.0f, 30.0f);
    [cancelbutton addTarget:self action:@selector(selectCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * travelTimeLableq = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 0.0f, 120.0f, 42.0f)];
    travelTimeLableq.text = @"选择出发时间";
    travelTimeLableq.font = [UIFont fontWithName:@"Arial" size:14.0f];
    travelTimeLableq.textAlignment = NSTextAlignmentCenter;
    travelTimeLableq.backgroundColor = [UIColor clearColor];
    travelTimeLableq.textColor = [UIColor whiteColor];
    
    pickImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_023.png"]];
    pickImageView.frame = CGRectMake(0.0f, 156.0f, 320.0f, 44.0f);
    pickImageView.hidden = YES;
    pickImageView.userInteractionEnabled = YES;
    [pickImageView addSubview:travelTimeLableq];
    [pickImageView addSubview:rigthbutton];
    [pickImageView addSubview:cancelbutton];
    [self.view addSubview:pickImageView];
    [travelTimeLableq release];
    
    timePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
    timePickerView.delegate = self;  
    timePickerView.dataSource = self;
    timePickerView.alpha = 0;
    timePickerView.showsSelectionIndicator = YES; 
    [self.view addSubview:timePickerView];
    
    [_fiveRing setImage:[UIImage imageNamed:@"btmbtn22.png"] forState:UIControlStateSelected];
    _fiveRing.selected = YES;
    [_fiveOutSide setImage:[UIImage imageNamed:@"btmbtn23.png"] forState:UIControlStateSelected];
    [_sixOutSide setImage:[UIImage imageNamed:@"btmbtn24.png"] forState:UIControlStateSelected];
    [_deFiveRing setImage:[UIImage imageNamed:@"btmbtn22.png"] forState:UIControlStateSelected];
    _deFiveRing.selected = YES;
    [_deFiveOutSide setImage:[UIImage imageNamed:@"btmbtn23.png"] forState:UIControlStateSelected];
    [_deSixOutSide setImage:[UIImage imageNamed:@"btmbtn24.png"] forState:UIControlStateSelected];
}

-(void)dealloc
{
    [feeInforView release];
    [informationView release];
    [timeInforView release];
    [originalTime release];
    [originalMinute release];
    [cost release];
    [endLable release];
    [dateformatter release];
    [minuteArray release];
    [pickImageView release];
    [time release];
   // [timeArray release];
    [totalCostLable release];
    [travelMinute release];
    [timePickerView release];
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
