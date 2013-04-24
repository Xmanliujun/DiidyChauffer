//
//  FillOrdersViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FillOrdersViewController.h"
#import "EditDepartureViewController.h"
#import "SelectCouponViewController.h"
#import "OrdersPreviewViewController.h"
#import "OrdersPreviewTwoViewController.h"
#import "LandingViewController.h"
#import "EditDestinationViewController.h"
#import "CONST.h"
#import "AppDelegate.h"
#import "DIIdyModel.h"
#import "JSONKit.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import "MobClick.h"
@interface FillOrdersViewController ()

@end

@implementation FillOrdersViewController
@synthesize  numberPeopleString;
@synthesize nameString,telString;
 @synthesize departureMinuteString,couponString,landed;
@synthesize couponaArray;
@synthesize destinationString,originalTime,total,originalNumber;


@synthesize departure,dataArraya;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithDeparture:(NSString *)departureString CLLocation:(CLLocationCoordinate2D)centers
{
    self = [super init];
    if(self)
    {
        self.departure = departureString;
        location = centers;
        NSLog(@"lay   %f",centers.latitude);
    }
    
    return self;
    
}
#pragma mark-HttpDown


#pragma mark-textFiled

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    orderTableView.frame= CGRectMake(0.0f, -200.0f, 320.0f, 416.0f);
   
       
    return YES;

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    orderTableView.contentOffset= CGPointMake(0, 0);
    orderTableView.frame= CGRectMake(0.0f, 0.0f, 320.0f, 416.0f);

    return YES;


}

#pragma mark-PickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView.tag ==50){
        
        return 2;
        
    }else {
        
        return 1;
        
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView.tag ==50){
        
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
    }else {
        
       return  [peopleArray count];
        
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag ==50){
        
        switch (component) {
                
            case 0:
                return [[timeArray objectAtIndex:row] objectForKey:@"State"];
                break;
                
            case 1:
                return  [minuteArray objectAtIndex:row];
                break;
                
            default:
                return nil;
                break;
                
        }
    
    }else {
        
        return [peopleArray objectAtIndex:row];
        
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
       
    self.numberPeopleString = [NSString stringWithFormat:@"%d人",row+1];
    
    [orderTableView reloadData];
    
}
#pragma mark-Button
-(void)selectOK:(id)sender
{
    orderTableView.contentOffset= CGPointMake(0, 0);
    orderTableView.frame= CGRectMake(0.0f, 0.0f, 320.0f, 416.0f);
    self.originalTime=self.departureMinuteString;
    self.originalNumber = self.numberPeopleString;
    datePicker.alpha = 0;
    pickImageView.alpha = 0;
    peoplePickView.alpha = 0;
    [orderTableView reloadData];
   
}
-(void)selectCancel:(id)sender
{
   orderTableView.contentOffset= CGPointMake(0, 0);
    self.departureMinuteString=self.originalTime;
    self.numberPeopleString = self.originalNumber;
    orderTableView.frame= CGRectMake(0.0f, 0.0f, 320.0f, 416.0f);
    datePicker.alpha = 0;
    pickImageView.alpha = 0;
    peoplePickView.alpha = 0;
    [orderTableView reloadData];
}
-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];

}
-(void)nextStep:(id)sender
{
   
    NSDate *today = [[[NSDate alloc] init] autorelease];
    NSTimeInterval date1 = [today timeIntervalSinceReferenceDate];
   
    NSTimeInterval date2 = [_date timeIntervalSinceReferenceDate]; 
    
    double diff = date2 -date1;
    
    if ([self.departure isEqualToString:@"未读取到位置信息，请手动编辑修改!"]) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"请填写出发地"
                                                      delegate:nil
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];
        
    }else{
    
        if (diff<60*30-20) {
        
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                       message:@"出发时间需要在当前时间30分以后"
                                                      delegate:nil 
                                             cancelButtonTitle:@"取消" 
                                             otherButtonTitles:nil ];
            [alert show];
            [alert release];
        
        }else {
        
            if (self.destinationString==NULL||[self.destinationString length]==0) {
                
                self.destinationString =@"";
                
            }
            if (self.nameString==NULL||[self.nameString length]==0) {
                
                self.nameString=@"";
                
            }
            if (self.telString==NULL||[self.telString length]==0) {
                
                self.telString=@"";
                
            }
            
        
            if (!self.landed) {
            
                LandingViewController * landedController = [[LandingViewController alloc] init];
                UINavigationController * landNa = [[UINavigationController alloc] initWithRootViewController:landedController];
        
                landedController.couponArray = [NSArray arrayWithObjects:self.departure,self.departureMinuteString,self.numberPeopleString,self.destinationString,self.nameString,self.telString,self.couponString,nil];
            
                [self presentModalViewController:landNa animated:NO];
                [landedController release];
                [landNa release];
            
            }else {
            
                if ([self.couponaArray count]==0) {
                
                    NSArray* ayy = [NSArray arrayWithObjects:self.departure,self.departureMinuteString,self.numberPeopleString,self.destinationString,self.nameString,self.telString,self.couponString,nil];
        
                    for (int i=0; i<[ayy count]; i++) {
                        NSLog(@"%@",[ayy objectAtIndex:i]);
                    }
                    
                    OrdersPreviewTwoViewController * orderPre = [[OrdersPreviewTwoViewController alloc] init];
                    orderPre.orderArray = ayy;
                    orderPre.markPre = YES;
                    [self.navigationController pushViewController:orderPre animated:YES];
                    [orderPre release];
                
                
                }else{
            
                    OrdersPreviewViewController * orderController = [[OrdersPreviewViewController alloc] init];
                    NSArray* ayy   = [NSArray arrayWithObjects:self.departure,self.departureMinuteString,self.numberPeopleString,self.destinationString,self.nameString,self.telString,self.couponString,nil];
                    orderController.orderArray = ayy;
                    orderController.useCouponArray = self.couponaArray;
                    orderController.selectArray = self.dataArraya;
                    [self.navigationController pushViewController:orderController animated:YES];
                    [orderController release];
                }
            }

        }
    
    }
}

-(void)selectThePlaceOfDeparture:(NSString*)placeDeparture
{
    self.departure = placeDeparture;
    [orderTableView reloadData];
}
-(void)selectThePlaceOfDestion:(NSString*)placeDestion
{
   
    self.destinationString= placeDestion;
    [orderTableView reloadData];

}
-(void)selectedCoupon:(NSArray*)couponArray{
    
    self.couponaArray = couponArray;
    
       if ([couponArray count]==0) {
        
        self.couponString= @"您没有使用优惠劵";

    }else{
        
        self.couponString = [NSString stringWithFormat:@"您一共选择了%d张优惠劵",[couponArray count]];

    }
        [orderTableView reloadData];
}

#pragma mark - System Approach

-(void)setTheNavigationBar
{
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0, 7.0, 50.0, 30.0);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    UIImage * rigthImage =[UIImage imageNamed:@"button4.png"];
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    [rigthbutton setBackgroundImage:rigthImage forState:UIControlStateNormal];
    rigthbutton.frame=CGRectMake(258.0, 7.0, 56.0, 31.0);
    [rigthbutton setTitle:@"下一步  " forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    centerLable=[[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text=@"填 写 订 单";
    centerLable.textColor=[UIColor whiteColor];
    centerLable.backgroundColor=[UIColor clearColor];
    centerLable.textAlignment=NSTextAlignmentCenter;
    centerLable.font=[UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
}
-(void)dateChanged:(id)sender{
    
    UIDatePicker* control = (UIDatePicker*)sender;  
     _date = [control.date retain];
    NSString * locationString=[dateformatter stringFromDate:_date];
    self.departureMinuteString = locationString;
    [orderTableView reloadData];

}
-(void)returnEachView:(NSNotification *)notify {
    
    self.landed = YES;
  
}
-(void)dataRequestCompelte:(NSNotification *)notification
{
   
    NSDictionary *dict = notification.userInfo;
    self.dataArraya = [dict objectForKey:@"array"];
    self.total = [[dict objectForKey:@"number"] intValue];
    self.couponString = [NSString stringWithFormat:@"%d张",self.total];
    self.landed = YES;
    [orderTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MobClick event:@"m03_d002_0001"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataRequestCompelte:) name:@"COUPONDATA" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnEachView:) name:@"LAND" object:nil];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];

    totalNumber =2;
    self.telString = ShareApp.mobilNumber;
    self.numberPeopleString=@"1";
    self.destinationString =@"";
    self.couponString = [NSString stringWithFormat:@"%d张",self.total];
    self.originalNumber = @"1人";
   
    [self setTheNavigationBar];
    
    orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f) style:UITableViewStyleGrouped];
    orderTableView.backgroundColor = [UIColor clearColor];
    orderTableView.backgroundView=nil;
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    [self.view addSubview:orderTableView];
   
    timeArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
    minuteArray = [[timeArray objectAtIndex:0] objectForKey:@"Cities"];
    peopleArray = [[timeArray objectAtIndex:1]objectForKey:@"Cities"];

//****************************************************************
    NSDate *today = [[NSDate alloc] init]; 
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init]; 
    // [offsetComponents setHour:1]; 
    [offsetComponents setMinute:35];
    
    NSDate *endOfWorldWar3 = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    _date = [endOfWorldWar3  retain];
     dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY年MM月d日HH时mm分"];
    
    NSString * locationString=[dateformatter stringFromDate:endOfWorldWar3];
    self.departureMinuteString = locationString;
    self.originalTime = self.departureMinuteString;
    [today release];
    [offsetComponents release];
    [gregorian release];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
    datePicker.datePickerMode =UIDatePickerModeDateAndTime;
    datePicker.alpha = 0;
    NSDate* maxDate = [[NSDate alloc]initWithString:@"2099-01-01 00:00:00 -0500"];
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [datePicker setMinimumDate:endOfWorldWar3];
     datePicker.maximumDate = maxDate;
    [self.view addSubview:datePicker];
    [self.view bringSubviewToFront:datePicker];
    [maxDate release];
    
    UIButton *rigthPickbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthPickbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    rigthPickbutton.frame=CGRectMake(262.0f,7.0f,49.0f, 30.0f);
    rigthPickbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [rigthPickbutton setTitle:@"完成" forState:UIControlStateNormal];
    [rigthPickbutton addTarget:self action:@selector(selectOK:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelbutton setBackgroundImage:[UIImage imageNamed:@"button-3.png"] forState:UIControlStateNormal];
    cancelbutton.frame=CGRectMake(9.0f,7.0f,49.0f, 30.0f);
    cancelbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbutton addTarget:self action:@selector(selectCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    travelTimeLableq = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 42)];
    travelTimeLableq.text = @"选择出发时间(以提前半小时)";
    travelTimeLableq.font = [UIFont fontWithName:@"Arial" size:14];
    travelTimeLableq.textAlignment = NSTextAlignmentCenter;
    travelTimeLableq.backgroundColor = [UIColor clearColor];
    travelTimeLableq.textColor = [UIColor whiteColor];
    
    pickImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_023.png"]];
    pickImageView.frame = CGRectMake(0.0f, 156.0f, 320.0f, 44.0f);
    pickImageView.alpha = 0;
    pickImageView.userInteractionEnabled = YES;
    [pickImageView addSubview:travelTimeLableq];
    [pickImageView addSubview:cancelbutton];
    [pickImageView addSubview:rigthPickbutton];
    [self.view addSubview:pickImageView];
    
    peoplePickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
    peoplePickView.delegate = self;
    peoplePickView.dataSource = self;
    peoplePickView.alpha = 0;
    peoplePickView.tag = 51;
    peoplePickView.showsSelectionIndicator = YES;
    [self.view addSubview:peoplePickView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (landed) {
        
        if ([self.dataArraya count]==0) {
            
            return 2;
            
        }else{
            
            return 3;
        }
        
    }else{
        
        return 2;
    }

    return totalNumber;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[[UIView alloc] init] autorelease];
    myView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, 22)];
    titleLabel.textColor=[UIColor orangeColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    if (section==0) {
        
        titleLabel.text = @"订单信息";
        
    }else if (section==1){
        titleLabel.text = @"联系人信息";
        
    }else if(section==2){
        
        titleLabel.text = @"优惠劵";
    
    }
    [myView addSubview:titleLabel];
    [titleLabel release];
    return myView;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   
    if (section==0) {
        
        return @"订单信息";
        
    }else if(section==1){
        
        return @"联系人信息";
        
    }else
        return @"优惠劵";
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section==0&&indexPath.row==0)
    {
        CGSize size1 = [self.departure sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        
        if (size1.height==18.0||size1.height==0) {
            
            return 44;
            
        }else
            
            return 30+size1.height-18;
        
        
    }else if(indexPath.section==0&&indexPath.row==3)
    {
        
        
        CGSize size2 = [self.destinationString sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        
        if (size2.height==18.0||size2.height==0) {
            
            return 44;
            
        }else
            
            return 30+size2.height-18;
        
    }
    return 44;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        
        return 4;
        
    }else if(section==1)
        
        return 2;
    
    else if(section==2){
        
        return 1;
        
    }else
        
        return 1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"cellID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID] autorelease];
        [cell setSelectionStyle:UITableViewCellEditingStyleNone];
        cell.backgroundColor = [UIColor whiteColor];
        
        UILabel*  markLable = [[UILabel alloc] initWithFrame:CGRectMake(3.0f, 0.0f, 80.0f, 44.0f)];
        markLable.font = [UIFont systemFontOfSize:14];
        markLable.textColor = [UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1];
        markLable.tag =60;
        markLable.numberOfLines=0;
        markLable.backgroundColor = [UIColor clearColor];
        markLable.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:markLable];
        [markLable release];
        
        UILabel*  messageLable = [[UILabel alloc] initWithFrame:CGRectMake(65.0f, 0.0f, 230.0f, 44.0f)];
        messageLable.font = [UIFont systemFontOfSize:14];
        messageLable.numberOfLines = 0;
        messageLable.tag = 61;
        messageLable.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
        messageLable.backgroundColor = [UIColor clearColor];
        messageLable.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:messageLable];
        [messageLable release];
        
        UITextField* nameTextFile = [[UITextField alloc] initWithFrame:CGRectMake(70.0f, 2.0f, 200.0f,44.0f)];
        nameTextFile.delegate = self;
        nameTextFile.tag =62;
        nameTextFile.backgroundColor = [UIColor clearColor];
        nameTextFile.keyboardType =UIKeyboardTypeDefault;
        nameTextFile.clearButtonMode = UITextFieldViewModeWhileEditing;
        nameTextFile.font = [UIFont fontWithName:@"Arial" size:14.0f];
        nameTextFile.borderStyle = UITextBorderStyleNone;
        nameTextFile.autocorrectionType = UITextAutocorrectionTypeYes;
        nameTextFile.placeholder = @"请输入姓名";
        nameTextFile.returnKeyType = UIReturnKeyDone;
        nameTextFile.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [nameTextFile addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:nameTextFile];
        [nameTextFile release];
        
        UITextField*  teleFile = [[UITextField alloc] initWithFrame:CGRectMake(70.0f, 2.0f, 200.0f,44.0f)];
        teleFile.delegate = self;
        teleFile.tag=63;
        teleFile.backgroundColor = [UIColor clearColor];
        teleFile.keyboardType =UIKeyboardTypeDefault;
        teleFile.clearButtonMode = UITextFieldViewModeWhileEditing;
        teleFile.font = [UIFont fontWithName:@"Arial" size:14.0f];
        teleFile.borderStyle = UITextBorderStyleNone;
        teleFile.autocorrectionType = UITextAutocorrectionTypeYes;
        teleFile.placeholder = @"请输入手机号";
        teleFile.text =ShareApp.mobilNumber;
        teleFile.returnKeyType = UIReturnKeyDone;
        teleFile.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [teleFile addTarget:self action:@selector(textFieldWithtel:) forControlEvents:UIControlEventEditingChanged];
        [cell.contentView addSubview:teleFile];
    
    }
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    UILabel*markLable =(UILabel*)[cell.contentView viewWithTag:60];
    UILabel*  messageLable =(UILabel*)[cell.contentView viewWithTag:61];
    UITextField* nameTextFile=(UITextField*)[cell.contentView viewWithTag:62];
    UITextField*  teleFile=(UITextField*)[cell.contentView viewWithTag:63];
    teleFile.text = ShareApp.mobilNumber;
    
    CGSize size1 = [self.departure sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize size2 = [ self.destinationString sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(220, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    
    if (indexPath.section==0&&indexPath.row==0) {
        
        if (size1.height==18.0||size1.height==0) {
            
            messageLable.frame = CGRectMake(65.0f, 0.0f, 220.0f, 44);
            
        }else{
            
            messageLable.frame = CGRectMake(65.0f, 0.0f, 220.0f,30+size1.height-18);
            
        }
        
    }else if(indexPath.section==0&&indexPath.row==3){
        
        if (size2.height==18.0||size2.height==0) {
            
            messageLable.frame = CGRectMake(65.0f, 0.0f, 220.0f,44);
            
        }else{
            
            messageLable.frame = CGRectMake(65.0f, 0.0f, 220.0f,30+size2.height-18);
            
        }
        
    }else if(indexPath.section==2&&indexPath.row==0){
        
        messageLable.frame = CGRectMake(120.0f, 0.0f, 160.0f,44);

        
    }else{
    
         messageLable.frame = CGRectMake(65.0f, 0.0f, 230.0f, 44);
    }
    
    if (indexPath.section==1&&indexPath.row==0) {
        
        nameTextFile.frame=CGRectMake(70.0f, 0.0f, 200.0f,44.0f);
        teleFile.frame=CGRectMake(0.0f, 0.0f, 0.0f,0.0f);
        
    }else if(indexPath.section==1&&indexPath.row==1){
        
        teleFile.frame=CGRectMake(70.0f, 0.0f, 200.0f,44.0f);
        nameTextFile.frame= CGRectMake(0.0f, 0.0f, 0.0f,0.0f);
        
    }else{
    
        teleFile.frame=CGRectMake(0.0f, 0.0f, 0.0f,0.0f);
        nameTextFile.frame= CGRectMake(0.0f, 0.0f, 0.0f,0.0f);
    }
    
    if (indexPath.section==0&&indexPath.row==0) {
        
        markLable.text = @"出发地:";
        messageLable.text =self.departure;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        messageLable.textAlignment = NSTextAlignmentLeft;
        
        
    }else if (indexPath.section==0&&indexPath.row==1) {
        
        markLable.text = @"出发时间:";
        messageLable.text =  self.departureMinuteString;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        messageLable.textAlignment = NSTextAlignmentLeft;
        
    }else if (indexPath.section==0&&indexPath.row==2) {
        
        markLable.text = @"司机个数:";
        messageLable.text = self.numberPeopleString;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        messageLable.textAlignment = NSTextAlignmentLeft;
        
    }else if (indexPath.section==0&&indexPath.row==3) {
        
        markLable.text = @"目的地:";
        messageLable.text = self.destinationString;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        messageLable.textAlignment = NSTextAlignmentLeft;
        
        
    }else if(indexPath.section==1&&indexPath.row==0)
    {
        markLable.text = @"姓名:";
        messageLable.text = @"";
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        messageLable.textAlignment = NSTextAlignmentLeft;
        
        
    }else if(indexPath.section==1&&indexPath.row==1){
        
        
        markLable.text = @"手机号:";
        messageLable.text =@"";
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        messageLable.textAlignment = NSTextAlignmentLeft;
        
        
    }else if(indexPath.section==2&&indexPath.row==0){
        
        markLable.text = @"嘀嘀优惠劵:";
        messageLable.text = self.couponString;
        cell.backgroundColor = [UIColor whiteColor];
        messageLable.textAlignment = NSTextAlignmentRight;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }

    return cell;
    
}
- (void)textFieldWithText:(UITextField *)textField
{
    if (textField==NULL||[textField.text length]==0) {
        self.nameString = @"";
        
    }else{
    
      self.nameString = textField.text;
    }
  

}
-(void)textFieldWithtel:(UITextField *)textField
{

    if (textField.text==NULL||[textField.text length]==0) {
        self.telString = @"";
    }else{
        self.telString = textField.text;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        
        EditDepartureViewController * editDeparture = [[EditDepartureViewController alloc] init];
        editDeparture.DepartureDelegate=self;
        editDeparture.departureName=self.departure;
        editDeparture.locationDe = location;
        [self.navigationController pushViewController:editDeparture animated:YES];
        [editDeparture release];
        
    }else if (indexPath.section==0&&indexPath.row==3){
    
        EditDestinationViewController*destion = [[EditDestinationViewController alloc] init];
        destion.destinationNSSString = self.destinationString;
        destion.DestionDelegate = self;
        [self.navigationController pushViewController:destion animated:YES];
        [destion release];
        
    }else if(indexPath.section==0&&indexPath.row==2){
    
        travelTimeLableq.text = @"选择司机个数";
        peoplePickView.alpha = 1;
        pickImageView.alpha = 1;
        datePicker.alpha = 0;
        orderTableView.frame= CGRectMake(0.0f, -40.0f, 320.0f, 416.0f);

    }else if (indexPath.section==0&&indexPath.row==1){
    
        travelTimeLableq.text = @"选择出发时间(以提前半小时)";
        datePicker.alpha = 1;
        pickImageView.alpha = 1;
        peoplePickView.alpha = 0;
        orderTableView.frame = CGRectMake(0.0f, -40.0f, 320.0f, 416.0f);

    }else if (indexPath.section==2&&indexPath.row==0){
    
        NSArray* ayy   = [NSArray arrayWithObjects:self.departure,self.departureMinuteString,self.numberPeopleString,self.destinationString,self.nameString,self.telString,self.couponString,nil];
        SelectCouponViewController * selectCoupon = [[SelectCouponViewController alloc] init];
        selectCoupon.selectCouponAray = self.dataArraya;
        selectCoupon.indexAray = self.couponaArray;
        selectCoupon.orderPreArray= ayy;
        selectCoupon.delegate = self;
        selectCoupon.rowNumber = self.total;
        selectCoupon.mark = NO;
        [self.navigationController pushViewController:selectCoupon animated:YES];
        [selectCoupon release];

    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    topImageView.hidden = NO;
    returnButton.hidden =NO;
    rigthbutton.hidden = NO;
    centerLable.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;
    centerLable.hidden = YES;

}

-(void)dealloc
{

    [dataArraya release];
    [couponaArray release];
    
    [originalTime release];
    [originalNumber release];
    [travelTimeLableq release];
    [couponString release];
    [destinationString release];
    [departureMinuteString release];
    [numberPeopleString release];
    [peoplePickView release];
    [pickImageView release];
    [timeArray release];
    [datePicker release];
    [topImageView release];
    [centerLable release];
    
    [nameString release];
    [telString release];
    [departure release];
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
