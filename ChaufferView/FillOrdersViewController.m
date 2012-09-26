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
@synthesize departuretimes,departureMinutes,couponaArray;
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
    NSString * baseUrl = [NSString stringWithFormat:COUPON,ShareApp.mobilNumber];
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
    
    NSArray* jsonParser =[str JSONValue];
    
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

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self parseStringJson:[request responseString]];
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
#pragma mark-Button
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
        [landNa release];
    }else {
    
        OrdersPreviewViewController * orderController = [[OrdersPreviewViewController alloc] init];
        NSString * timeString = [NSString stringWithFormat:@"%@:%@",self.departuretimes,self.departureMinutes];
        NSArray* ayy   = [NSArray arrayWithObjects:self.departureLable.text,timeString,self.numberPeopleLable.text,self.destinationField.text,self.nameField.text,self.telNumberField.text,self.couponLable.text,nil];
        orderController.orderArray = ayy;
        orderController.useCouponArray = self.couponaArray;
        orderController.selectArray = dataArry;
        [self.navigationController pushViewController:orderController animated:YES];
        [orderController release];
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
    NSString * timeString = [NSString stringWithFormat:@"%@:%@",self.departuretimes,self.departureMinutes];
    NSArray* ayy   = [NSArray arrayWithObjects:self.departureLable.text,timeString,self.numberPeopleLable.text,self.destinationField.text,self.nameField.text,self.telNumberField.text,self.couponLable.text,nil];
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
    for (int i =0; i<[self.couponaArray count]; i++) {
        
        
        NSIndexPath* diidyMbdelPath = [self.couponaArray objectAtIndex:i];
        DIIdyModel *diidyModel = [dataArry objectAtIndex:diidyMbdelPath.section];
        
        couString = [couString stringByAppendingString:diidyModel.name];
        couString = [NSMutableString stringWithFormat:@"%@,",couString];
    }

      self.couponLable.text = couString;
}

#pragma mark - System Approach

-(void)setTheNavigationBar
{
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0, 5.0, 55.0, 35.0);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rigthbutton.frame=CGRectMake(260.0, 5.0, 55.0, 35.0);
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"button4.png"] forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"填 写 订 单";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.destinationField.delegate = self;
    self.nameField.delegate = self;
    self.telNumberField.delegate = self;
    self.couponView.hidden = YES;
    self.departureLable.text = departure;
    
    dataArry = [[NSMutableArray alloc] initWithCapacity:0];
    timeArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
    minuteArray   = [[timeArray objectAtIndex:0] objectForKey:@"Cities"];
    peopleArray = [[timeArray objectAtIndex:1]objectForKey:@"Cities"];
    
    [self downLoadTheCouponData];
    [self setTheNavigationBar];
    
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

-(void)viewWillAppear:(BOOL)animated
{
    topImageView.hidden = NO;
    returnButton.hidden =NO;
    rigthbutton.hidden = NO;
    centerLable.hidden = NO;
}
-(void)viewDidDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;
    centerLable.hidden = YES;

}
-(void)dealloc
{
    [backGroundView release];
    [couponView  release];
    [centerLable release];
    [couponaArray release];
    [couponLable release];
    [departure release];
    [departuretimes release];
    [departureMinutes release];
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
    [timePickView release];
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
