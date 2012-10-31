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
#import "CONST.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "DIIdyModel.h"
#import "JSONKit.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
@interface FillOrdersViewController ()

@end

@implementation FillOrdersViewController
@synthesize departureLable,numberPeopleLable,newsImangeView,backGroundView;
@synthesize destinationField,nameField,telNumberField;
@synthesize couponView,departureMinuteLable,couponLable,landed;
@synthesize couponaArray;
@synthesize bookInforView,couponInforView,contactInforView;
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
        departure = [departureString retain];
        location = centers;
    }
    
    return self;
    
}
#pragma mark-HttpDown
-(void)downLoadTheCouponData
{
    
    Reachability * r =[Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([r currentReachabilityStatus]==0) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"联网失败,无法获得优惠劵"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }else{

        NSLog(@"%@",ShareApp.mobilNumber);
        NSString * baseUrl = [NSString stringWithFormat:COUPON,ShareApp.mobilNumber];
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        HTTPRequest *request = [[HTTPRequest alloc] init];
    
        self.getCoupon_request = request;
        self.getCoupon_request.m_delegate = self;
        self.getCoupon_request.hasTimeOut = YES;
        [request release];
    
        [self.getCoupon_request requestByUrlByGet: baseUrl];
    }
}

-(void)parseStringJson:(NSString *)str
{
    total = 0;
    [dataArry removeAllObjects];

    NSArray* jsonParser =[str objectFromJSONString];
    NSLog(@"%d",[jsonParser count]);
    for (int i = 0; i<[jsonParser count]; i++) {
        
        DIIdyModel * diidy = [[DIIdyModel alloc] init];
        NSDictionary * diidyDict = [jsonParser objectAtIndex:i];
        diidy.ID = [diidyDict objectForKey:@"id"];
        diidy.name = [diidyDict objectForKey:@"name"];
        diidy.type = [diidyDict objectForKey:@"type"];
        diidy.number = [diidyDict objectForKey:@"number"];
        diidy.close_date = [diidyDict objectForKey:@"close_date"];
        diidy.amount = [diidyDict objectForKey:@"amount"];
        total += [diidy.number intValue];
        [dataArry addObject:diidy];
        [diidy release];
        
    }
   
    if(total!=0){
        
        self.couponLable.text = [NSString stringWithFormat:@"%d张",total];
        self.couponView.hidden = NO;
        
    }
        
}
-(void)requFinish:(NSString *)requestString order:(int)nOrder
{

    if ([requestString length]==0) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"登陆失败"
                                                       message:@"请检查网络是否连接"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];
        
    }else{
        
        [self parseStringJson:requestString];
    }

}
-(void)requesttimeout
{

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;


}
#pragma mark-textFiled
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag ==42){
        
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.backGroundView.frame = CGRectMake(0, -30, self.backGroundView.frame.size.width,self.backGroundView.frame.size.height );
        [UIView commitAnimations];
        
    }else if (textField.tag ==40) {
        
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.backGroundView.frame = CGRectMake(0, -100, self.backGroundView.frame.size.width,self.backGroundView.frame.size.height );
        [UIView commitAnimations];
        
    }else {
        
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.backGroundView.frame = CGRectMake(0, -120, self.backGroundView.frame.size.width,self.backGroundView.frame.size.height );
        viewTest.frame = CGRectMake(0, -120, viewTest.frame.size.width, viewTest.frame.size.height);
        [UIView commitAnimations];
        
    }
       return YES;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [textField resignFirstResponder];
    if(textField.tag ==42){
        
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.backGroundView.frame = CGRectMake(0, 0, self.backGroundView.frame.size.width,self.backGroundView.frame.size.height );
        [UIView commitAnimations];
        
    }else if (textField.tag ==40) {
        
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.backGroundView.frame = CGRectMake(0, 0, self.backGroundView.frame.size.width,self.backGroundView.frame.size.height );
        [UIView commitAnimations];
        
    }else {
        
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.backGroundView.frame = CGRectMake(0, 0, self.backGroundView.frame.size.width,self.backGroundView.frame.size.height );
        [UIView commitAnimations];
        
    }


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
       
        self.numberPeopleLable.text = [NSString stringWithFormat:@"%d人",row+1];
    
}
#pragma mark-Button
-(void)selectOK:(id)sender
{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    datePicker.alpha = 0;
    pickImageView.alpha = 0;
    peoplePickView.alpha = 0;
    [UIView commitAnimations];
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
    
    if (diff<60*30-20) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                       message:@"出发时间需要在当前时间30分以后"
                                                      delegate:nil 
                                             cancelButtonTitle:@"取消" 
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];
        
    }else {
        if (!self.landed) {
            
            LandingViewController * landedController = [[LandingViewController alloc] init];
            UINavigationController * landNa = [[UINavigationController alloc] initWithRootViewController:landedController];
            NSLog(@"%@",self.departureMinuteLable.text);
            landedController.couponArray = [NSArray arrayWithObjects:self.departureLable.text,self.departureMinuteLable.text,self.numberPeopleLable.text,self.destinationField.text,self.nameField.text,self.telNumberField.text,self.couponLable.text,nil];
            [self presentModalViewController:landNa animated:NO];
            [landedController release];
            [landNa release];
            
        }else {
            
            if ([self.couponaArray count]==0) {
                
                 NSArray* ayy   = [NSArray arrayWithObjects:self.departureLable.text,self.departureMinuteLable.text,self.numberPeopleLable.text,self.destinationField.text,self.nameField.text,self.telNumberField.text,self.couponLable.text,nil];
                
                OrdersPreviewTwoViewController * orderPre = [[OrdersPreviewTwoViewController alloc] init];
                orderPre.orderArray = ayy;
                [self.navigationController pushViewController:orderPre animated:YES];
                [orderPre release];
                
                
            }else{
            
                OrdersPreviewViewController * orderController = [[OrdersPreviewViewController alloc] init];
                NSArray* ayy   = [NSArray arrayWithObjects:self.departureLable.text,self.departureMinuteLable.text,self.numberPeopleLable.text,self.destinationField.text,self.nameField.text,self.telNumberField.text,self.couponLable.text,nil];
                orderController.orderArray = ayy;
                orderController.useCouponArray = self.couponaArray;
                orderController.selectArray = dataArry;
                [self.navigationController pushViewController:orderController animated:YES];
                [orderController release];
            }
        }

    }
    
        
       
}
-(IBAction)selectDeparture:(id)sender{
    
    EditDepartureViewController * editDeparture = [[EditDepartureViewController alloc] init];
    editDeparture.DepartureDelegate = self;
    editDeparture.departureName = self.departureLable.text;
    editDeparture.locationDe = location;
    [self.navigationController pushViewController:editDeparture animated:YES];
    [editDeparture release];

}
-(IBAction)selectDepartureTime:(id)sender{
   
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    datePicker.alpha = 1;
    pickImageView.alpha = 1;
    peoplePickView.alpha = 0;
    [UIView commitAnimations];

}
-(IBAction)selectNumberPeople:(id)sender{
    
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    peoplePickView.alpha = 1;
    pickImageView.alpha = 1;
    datePicker.alpha = 0;
    [UIView commitAnimations];
}

-(IBAction)useCoupon:(id)sender
{
    NSArray* ayy   = [NSArray arrayWithObjects:self.departureLable.text,self.departureMinuteLable.text,self.numberPeopleLable.text,self.destinationField.text,self.nameField.text,self.telNumberField.text,self.couponLable.text,nil];
    SelectCouponViewController * selectCoupon = [[SelectCouponViewController alloc]init];
    selectCoupon.selectCouponAray = dataArry;
    selectCoupon.orderPreArray= ayy;
    selectCoupon.delegate = self;
    selectCoupon.rowNumber = total;
    selectCoupon.mark = NO;
    [self.navigationController pushViewController:selectCoupon animated:YES];
    [selectCoupon release];

}
-(void)selectThePlaceOfDeparture:(NSString*)placeDeparture
{
    self.departureLable.text = placeDeparture;
}

-(void)selectedCoupon:(NSArray*)couponArray{
    
    self.couponaArray = couponArray;
     NSMutableString * couString = [[[NSMutableString alloc]initWithCapacity:0]autorelease ];
    
    if ([self.couponaArray count]==0) {
        self.couponLable.text = @"";

    }
    
    
    if ([self.couponaArray count]>=2) {
        
        for (int i=0; i<[self.couponaArray count]-1; i++) {
            
            NSIndexPath* diidyMbdelPath = [self.couponaArray objectAtIndex:i];
            DIIdyModel *diidyModel = [dataArry objectAtIndex:diidyMbdelPath.section];
            [couString appendFormat:@"%@,",diidyModel.name];
            
        }
        
    }
    if ([self.couponaArray count]>=1) {
        
        NSIndexPath* lastdiidyPath = [self.couponaArray objectAtIndex:[self.couponaArray count]-1];
        DIIdyModel * lastDiidy = [dataArry objectAtIndex:lastdiidyPath.section];
        [couString appendFormat:@"%@",lastDiidy.name];
        self.couponLable.text = couString;
        
    }

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
    
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    rigthbutton.frame=CGRectMake(262.0, 7.0, 50.0, 30.0);
    [rigthbutton setTitle:@"下一步 " forState:UIControlStateNormal];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"button4.png"] forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"填 写 订 单";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
}
-(void)dateChanged:(id)sender{
    
    UIDatePicker* control = (UIDatePicker*)sender;  
     _date = [control.date retain];
    NSString * locationString=[dateformatter stringFromDate:_date];
    self.departureMinuteLable.text = locationString;

}
-(void)creatView
{

    self.bookInforView.backgroundColor=[UIColor whiteColor];
    [[self.bookInforView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[self.bookInforView layer] setShadowRadius:5];
    [[self.bookInforView layer] setShadowOpacity:1];
    [[self.bookInforView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[self.bookInforView layer] setCornerRadius:7];
    [[self.bookInforView layer] setBorderWidth:1];
    [[self.bookInforView layer] setBorderColor:[UIColor grayColor].CGColor];
    [self.backGroundView sendSubviewToBack:self.bookInforView];
    
    self.contactInforView.backgroundColor=[UIColor whiteColor];
    [[self.contactInforView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[self.contactInforView layer] setShadowRadius:5];
    [[self.contactInforView layer] setShadowOpacity:1];
    [[self.contactInforView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[self.contactInforView layer] setCornerRadius:7];
    [[self.contactInforView layer] setBorderWidth:1];
    [[self.contactInforView layer] setBorderColor:[UIColor grayColor].CGColor];
    [self.backGroundView sendSubviewToBack:self.self.contactInforView];
    
    self.couponInforView.backgroundColor=[UIColor whiteColor];
    [[self.couponInforView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[self.couponInforView layer] setShadowRadius:5];
    [[self.couponInforView layer] setShadowOpacity:1];
    [[self.couponInforView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[self.couponInforView layer] setCornerRadius:7];
    [[self.couponInforView layer] setBorderWidth:1];
    [[self.couponInforView layer] setBorderColor:[UIColor grayColor].CGColor];
    [self.couponView sendSubviewToBack:self.couponInforView];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];

    self.destinationField.delegate = self;
    self.nameField.delegate = self;
    self.telNumberField.delegate = self;
    self.couponView.hidden = YES;
    self.departureLable.text = departure;
    self.departureLable.numberOfLines = 0;
    
    [self creatView];
    if (ShareApp.mobilNumber.length!=0) {
        
        self.telNumberField.text = ShareApp.mobilNumber;
    }
    
    dataArry = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self setTheNavigationBar];

    [self downLoadTheCouponData];
       
    timeArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
    minuteArray   = [[timeArray objectAtIndex:0] objectForKey:@"Cities"];
    peopleArray = [[timeArray objectAtIndex:1]objectForKey:@"Cities"];

//****************************************************************
    NSDate *today = [[NSDate alloc] init]; 
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init]; 
    // [offsetComponents setHour:1]; 
    [offsetComponents setMinute:30]; 
    
    NSDate *endOfWorldWar3 = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
    _date = [endOfWorldWar3  retain];
     dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY年MM月d日HH时mm分"];
    
    NSString * locationString=[dateformatter stringFromDate:endOfWorldWar3];
    self.departureMinuteLable.text = locationString;
    
    [today release];
    [offsetComponents release];
    [gregorian release];
//*****************************************************************
//    NSDateFormatter* todayformatter= [[NSDateFormatter alloc] init];
//    [todayformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
//    
//    NSString* todayData = [todayformatter stringFromDate:endOfWorldWar3];
//    NSLog(@"xxxxxx  %@",todayData);
//    
//    NSString* todayNewData = [NSString stringWithFormat:@"%@:00 -0500",todayData];
//    NSLog(@"%@",todayNewData);
//    NSArray*timesArray = [todayNewData  componentsSeparatedByString:@" "];
//    NSString* timeMis = [timesArray objectAtIndex:1];
//    NSArray*timeMinArray = [timeMis componentsSeparatedByString:@":"];
//    NSString*newTime = [timeMinArray objectAtIndex:0];
//   
//    int timenew = [newTime intValue];
//    if (timenew >=12) {
//        timenew-=12;
//    }
//    todayNewData = [NSString stringWithFormat:@"%@ %d:%@:00 -0500",[timesArray objectAtIndex:0],timenew,[timeMinArray objectAtIndex:1]];
//    NSLog(@"xinde  %@",todayNewData);
//******************************************************************
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
    datePicker.datePickerMode =UIDatePickerModeDateAndTime;   
    datePicker.alpha = 0;
    NSDate* maxDate = [[NSDate alloc]initWithString:@"2099-01-01 00:00:00 -0500"];    
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [datePicker setMinimumDate:endOfWorldWar3];
    datePicker.maximumDate = maxDate;  
    [self.view addSubview:datePicker]; 
  
    [maxDate release];
    
    UIButton *rigthPickbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthPickbutton setBackgroundImage:[UIImage imageNamed:@"btn_020@2x.png"] forState:UIControlStateNormal];
    rigthPickbutton.frame=CGRectMake(280.0,0.0, 42.0, 42.0);
    [rigthPickbutton addTarget:self action:@selector(selectOK:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * travelTimeLableq = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 120, 42)];
    travelTimeLableq.text = @"选择出发时间";
    travelTimeLableq.font = [UIFont fontWithName:@"Arial" size:14];
    travelTimeLableq.textAlignment = NSTextAlignmentCenter;
    travelTimeLableq.backgroundColor = [UIColor clearColor];
    travelTimeLableq.textColor = [UIColor whiteColor];
    
    pickImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_023@2x.png"]];
    pickImageView.frame = CGRectMake(0.0f, 156.0f, 320.0f, 44.0f);
    pickImageView.alpha = 0;
    pickImageView.userInteractionEnabled = YES;
    [pickImageView addSubview:travelTimeLableq];
    [pickImageView addSubview:rigthPickbutton];
    [self.view addSubview:pickImageView];
    [travelTimeLableq release];
    
    peoplePickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
    peoplePickView.delegate = self;  
    peoplePickView.dataSource = self;
    peoplePickView.alpha = 0;
    peoplePickView.tag = 51;
    peoplePickView.showsSelectionIndicator = YES; 
    [self.view addSubview:peoplePickView];
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
    [self.getCoupon_request closeConnection];
    [couponInforView release];
    [contactInforView release];
    [bookInforView release];
    [backGroundView release];
    [couponView  release];
    [centerLable release];
    [couponaArray release];
    [couponLable release];
    [departure release];
    [departureLable release];
    [destinationField release];
    [dataArry release];
    [departureMinuteLable release];
    [numberPeopleLable release];
    [newsImangeView release];
    [nameField release];
    [peoplePickView release];
    [pickImageView release];
    [telNumberField release];
    [timeArray release];
    [datePicker release];
    [topImageView release];
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
