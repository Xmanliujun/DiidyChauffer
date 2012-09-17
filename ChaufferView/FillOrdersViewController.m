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
#import "LandingViewController.h"
#import "CONST.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "DIIdyModel.h"
@interface FillOrdersViewController ()

@end

@implementation FillOrdersViewController
@synthesize departureLable,numberPeopleLable,newsImangeView,backGroundView;
@synthesize destinationField,nameField,telNumberField;
@synthesize couponView,departureMinuteLable,couponLable,landed;
@synthesize departuretimes,departureMinutes;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithDeparture:(NSString *)departureString
{
    self = [super init];
    if(self)
    {
        departure = [departureString retain];
    }
    
    return self;
    
}
-(void)downLoadTheCouponData
{
    
    NSString * baseUrl = [NSString stringWithFormat:COUPON,ShareApp.mobilNumber];
    NSLog(@"%@",baseUrl);
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:baseUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    
    [request startSynchronous];
    
    
}

-(void)parseStringJson:(NSString *)str
{
    total = 0;
    [dataArry removeAllObjects];
    DIIdyModel * diidy = [[DIIdyModel alloc] init];
    NSArray* jsonParser =[str JSONValue];
    
    for (int i = 0; i<[jsonParser count]; i++) {
        NSDictionary * diidyDict = [jsonParser objectAtIndex:i];
        diidy.ID = [diidyDict objectForKey:@"id"];
        diidy.name = [diidyDict objectForKey:@"name"];
        diidy.type = [diidyDict objectForKey:@"type"];
        diidy.number = [diidyDict objectForKey:@"number"];
        diidy.close_date = [diidyDict objectForKey:@"close_date"];
        diidy.amount = [diidyDict objectForKey:@"amount"];
        total += [diidy.number intValue];
      
        [dataArry addObject:diidy];
    }
    if(total!=0){
        self.couponLable.text = [NSString stringWithFormat:@"%d张",total];
        self.couponView.hidden = NO;
    }
        
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self parseStringJson:[request responseString]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    self.destinationField.delegate = self;
    self.nameField.delegate = self;
    self.telNumberField.delegate = self;
    self.couponView.hidden = YES;
    [self downLoadTheCouponData];
    
    self.departureLable.text = departure;    
    dataArry = [[NSMutableArray alloc] initWithCapacity:0];
    timeArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
    minuteArray   = [[timeArray objectAtIndex:0] objectForKey:@"Cities"];
    peopleArray = [[NSMutableArray alloc] initWithObjects:@"1人",@"2人",@"3人",@"4人",@"5人", nil];
    
    
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"u108_normalp.png"] forState:UIControlStateNormal];
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    leftbutton.frame=CGRectMake(0.0, 100.0, 43.0, 25.0);
    [leftbutton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];

    UIButton *rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"u927_normal.png"] forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rigthbutton setTitle:@"下一步" forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rigthbutton.frame=CGRectMake(0.0, 100.0, 65.0, 34.0);
    [rigthbutton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];
    
    UILabel *centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    centerLable.font = [UIFont systemFontOfSize:17];
    centerLable.textColor = [UIColor blackColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.text = @"填 写 订 单";
    self.navigationItem.titleView = centerLable;
    [centerLable release]; 
    
    timePickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
    timePickView.delegate = self;  
    timePickView.dataSource = self;
    timePickView.alpha = 0;
    timePickView.tag = 50;
    timePickView.showsSelectionIndicator = YES; 
    [self.view addSubview:timePickView];
    
    
    UIButton *rigthPickbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthPickbutton setBackgroundImage:[UIImage imageNamed:@"btn_020@2x.png"] forState:UIControlStateNormal];
    rigthPickbutton.frame=CGRectMake(280.0,0.0, 42.0, 42.0);
    [rigthPickbutton addTarget:self action:@selector(selectOK:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * travelTimeLableq = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 120, 42)];
    travelTimeLableq.text = @"选择出发时间";
    travelTimeLableq.font = [UIFont fontWithName:@"Arial" size:14];
    travelTimeLableq.textAlignment = UITextAlignmentCenter;
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
            default:
                return nil;
                break;
        }
    
    }else {
        return [peopleArray objectAtIndex:row];
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(pickerView.tag ==50){
        switch (component) {
            case 0:
                self.departuretimes = [NSString stringWithFormat:@"%d",row]; 
                break;
            case 1:
                if(row<10){
                    self.departureMinutes= [NSString stringWithFormat:@"0%d",row];
                    
                }else {
                    self.departureMinutes = [NSString stringWithFormat:@"%d",row];
                }
                break;
            default:
                break;
        } 
        self.departureMinuteLable.text = [NSString stringWithFormat:@"%@:%@",self.departuretimes,self.departureMinutes];
        
    }else {
        self.numberPeopleLable.text = [NSString stringWithFormat:@"%d人",row+1];
    }
}

-(void)selectOK:(id)sender
{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    timePickView.alpha = 0;
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

    if (!self.landed) {
        LandingViewController * landedController = [[LandingViewController alloc] init];
        UINavigationController * landNa = [[UINavigationController alloc] initWithRootViewController:landedController];
        
        NSString * timeString = [NSString stringWithFormat:@"%@:%@",self.departuretimes,self.departureMinutes];
        landedController.couponArray = [NSArray arrayWithObjects:self.departureLable.text,timeString,self.numberPeopleLable.text,self.destinationField.text,self.nameField.text,self.telNumberField.text,self.couponLable.text,nil];
        [self presentModalViewController:landNa animated:YES];
        [landedController release];
    }else {
    
        OrdersPreviewViewController * orderController = [[OrdersPreviewViewController alloc] init];
        NSString * timeString = [NSString stringWithFormat:@"%@:%@",self.departuretimes,self.departureMinutes];
        NSArray* ayy   = [NSArray arrayWithObjects:self.departureLable.text,timeString,self.numberPeopleLable.text,self.destinationField.text,self.nameField.text,self.telNumberField.text,self.couponLable.text,nil];
        orderController.orderArray = ayy;
        [self.navigationController pushViewController:orderController animated:YES];
        [orderController release];
    }
    
}
-(IBAction)selectDeparture:(id)sender{
    EditDepartureViewController * editDeparture = [[EditDepartureViewController alloc] init];
    [self.navigationController pushViewController:editDeparture animated:YES];
    [editDeparture release];

}
-(IBAction)selectDepartureTime:(id)sender{
   
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    timePickView.alpha = 1;
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
    timePickView.alpha = 0;
    [UIView commitAnimations];
}

-(IBAction)useCoupon:(id)sender
{
    SelectCouponViewController * selectCoupon = [[SelectCouponViewController alloc]init];
    selectCoupon.selectCouponAray = dataArry;
    selectCoupon.delegate = self;
    selectCoupon.rowNumber = total;
    selectCoupon.mark = NO;
    [self.navigationController pushViewController:selectCoupon animated:YES];
    [selectCoupon release];

}
-(void)selectedCoupon:(NSArray*)couponArray{
    

}
-(void)dealloc
{
    [departure release];
    [dataArry release];
    [couponLable release];
    [departureLable release];
    [numberPeopleLable release];
    [newsImangeView release];
    [backGroundView release];
    [destinationField release];
    [nameField release];
    [telNumberField release];
    [couponView  release];
    [departureMinuteLable release];

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
