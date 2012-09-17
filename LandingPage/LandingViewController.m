//
//  LandingViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LandingViewController.h"
#import "RegisteredViewController.h"
#import "AppDelegate.h"
#import "NSString+Hashing.h"
#import "CONST.h"
#import "SBJson.h"
#import "CouponViewController.h"
#import "ManageMentViewController.h"
#import "Landing_DownLoadView.h"
#import "DIIdyModel.h"
#import "SelectCouponViewController.h"
#import "OrdersPreviewViewController.h"
#import "DriverViewController.h"
#import "OrdersPreviewTwoViewController.h"
@interface LandingViewController ()

@end

@implementation LandingViewController
@synthesize couponArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)creatInPutBox
{
    UILabel * inputLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 51.0)];
    inputLable.text = @"手机号:";
    inputLable.backgroundColor = [UIColor clearColor];
    inputLable.textAlignment = UITextAlignmentCenter;
    inputLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    
    inputNumberText = [[UITextField alloc] initWithFrame:CGRectMake(60.0, 5.0, 200.0,45.0)];
    inputNumberText.backgroundColor = [UIColor clearColor];
    inputNumberText.keyboardType = UIKeyboardTypePhonePad;
    inputNumberText.font = [UIFont fontWithName:@"Arial" size:15.0];
    inputNumberText.borderStyle = UITextBorderStyleNone;
    inputNumberText.autocorrectionType = UITextAutocorrectionTypeYes;
    inputNumberText.placeholder = @"请输入手机号";
    inputNumberText.returnKeyType = UIReturnKeyDone;
    inputNumberText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIImage * inputImage = [UIImage imageNamed:@"u70_normal.png"];
    UIImageView* inputImageView = [[UIImageView alloc] initWithImage:inputImage];
    inputImageView.frame = CGRectMake(10.0, 40.0, inputImage.size.width, inputImage.size.height);
    inputImageView.userInteractionEnabled = YES;
    
    [inputImageView addSubview:inputNumberText];
    [inputImageView addSubview:inputLable];
    [self.view addSubview:inputImageView];
    [inputLable release];
    [inputImageView release];
    
    UILabel * passWordLable = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 0.0, 40.0, 51.0)];
    passWordLable.text = @"密码:";
    passWordLable.backgroundColor = [UIColor clearColor];
    passWordLable.textAlignment = UITextAlignmentLeft;
    passWordLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(45.0, 5.0, 200.0,45.0)];
    passWordText.backgroundColor = [UIColor clearColor];
    passWordText.keyboardType = UIKeyboardTypeDefault;
    passWordText.font = [UIFont fontWithName:@"Arial" size:15.0];
    passWordText.borderStyle = UITextBorderStyleNone;
    passWordText.autocorrectionType = UITextAutocorrectionTypeYes;
    passWordText.placeholder = @"请输入密码";
    passWordText.returnKeyType = UIReturnKeyDone;
    passWordText.secureTextEntry = YES;
    passWordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passWordText.delegate = self;
    
    UIImage * passWordImage = [UIImage imageNamed:@"u72_normal.png"];
    UIImageView* passWordImageView = [[UIImageView alloc] initWithImage:passWordImage];
    passWordImageView.frame = CGRectMake(10.0, 86.0, passWordImage.size.width, passWordImage.size.height);
    passWordImageView.userInteractionEnabled = YES;
    
    [passWordImageView addSubview:passWordText];
    [passWordImageView addSubview:passWordLable];
    [self.view addSubview:passWordImageView];
    [passWordLable release];
    [passWordImageView release];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
     self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.hidesBackButton = YES;
    dataArry = [[NSMutableArray alloc] initWithCapacity:0];
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0, 10.0, 43.0, 25.0);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"u108_normalp.png"] forState:UIControlStateNormal];
    [returnButton setTitle:@"返回" forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    UILabel * landingLable = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 10.0, 70.0, 30.0)];
    landingLable.text = @"用户登陆";
    landingLable.backgroundColor = [UIColor clearColor];
    landingLable.font = [UIFont fontWithName:@"Arial" size:16.0];
    [self.view addSubview:landingLable];
    [landingLable release];
    
    UIImage * landedImage =[UIImage imageNamed:@"u14_normal.png" ];
    UIButton*landedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    landedButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    landedButton.frame=CGRectMake(15.0, 150.0, landedImage.size.width, landedImage.size.height);
    [landedButton setBackgroundImage:landedImage forState:UIControlStateNormal];
    [landedButton setTitle:@"登陆" forState:UIControlStateNormal];
    [landedButton addTarget:self action:@selector(clientLandedPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landedButton];
    
    UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(20.0, 185.0, 80.0, 30.0);
    [registerButton setTitle:@"还没注册？>" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [registerButton addTarget:self action:@selector(registeredUsers:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UIButton * forgotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgotButton.frame = CGRectMake(240.0, 185.0,60.0, 30.0);
    [forgotButton setTitle:@"忘记密码 >" forState:UIControlStateNormal];
    [forgotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgotButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [forgotButton addTarget:self action:@selector(forgotPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotButton];
    
    [self creatInPutBox];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [passWordText resignFirstResponder];
    return YES;
    
}

-(void)registeredUsers:(id)sender
{
    RegisteredViewController * registered = [[RegisteredViewController alloc] init];
    registered.registerIsTrue = @"TRUE";
    returnButton.hidden = YES;
    [self.navigationController pushViewController:registered animated:YES];
    
}
-(void)forgotPassword:(id)sender
{
    RegisteredViewController * registered = [[RegisteredViewController alloc] init];
    registered.registerIsTrue = @"NO";
    returnButton.hidden = YES;
    [self.navigationController pushViewController:registered animated:YES];
    
}
-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
}
-(void)clientLandedPage:(id)sender
{
    
    
    NSString * baseUrl = [NSString stringWithFormat:LAND,inputNumberText.text,[passWordText.text MD5Hash],ShareApp.uniqueString,ShareApp.reachable,ShareApp.phoneVerion,ShareApp.deviceName]; 
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:baseUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSLog(@"%@",url);
    [request setDelegate:self];
    [request setTag:500];
    [request startAsynchronous];
    
}

-(void)getCouponInformation{

    NSString * baseUrl = [NSString stringWithFormat:COUPON,inputNumberText.text];
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:baseUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
   // [request setTimeOutSeconds:15.0];
    [request setDelegate:self];
    [request setTag:505];
    [request startAsynchronous];
        
}


-(void)parseCouponStringJson:(NSString*)str
{   
   int total = 0;
    NSArray* jsonParser =[str JSONValue];
    
    for (int i = 0; i<[jsonParser count]; i++) {
        total = 0;
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
    }
    if(total!=0){
            
        SelectCouponViewController * selectCoupon = [[SelectCouponViewController alloc]init];
        selectCoupon.selectCouponAray = dataArry;
        selectCoupon.rowNumber = total;
        selectCoupon.mark = YES;
        selectCoupon.orderPreArray = self.couponArray;
        [self.navigationController pushViewController:selectCoupon animated:YES];
        [selectCoupon release];
    
    }else {
        
        OrdersPreviewTwoViewController * orderPre = [[OrdersPreviewTwoViewController alloc] init];
        orderPre.orderArray = self.couponArray;
        [self.navigationController pushViewController:orderPre animated:YES];
        [orderPre release];

    }
}
-(void)parseStringJson:(NSString *)str
{
    [inputNumberText resignFirstResponder];
    [passWordText resignFirstResponder];
    
    NSDictionary * jsonParser =[str JSONValue];
    NSString * returenNews =[jsonParser objectForKey:@"r"];
    ShareApp.logInState = returenNews;
    
    if([returenNews isEqualToString:@"s"])
    {
        returnButton.hidden = YES;
        if([ShareApp.pageManageMent isEqualToString:@"coupon"]){
            CouponViewController * cou = [[CouponViewController alloc] init];
            ShareApp.mobilNumber = inputNumberText.text;
            [self.navigationController pushViewController:cou animated:YES];
            [cou release];
        }else if([ShareApp.pageManageMent isEqualToString:@"manage"]) {
            ManageMentViewController * manage = [[ManageMentViewController alloc] init];
            ShareApp.mobilNumber = inputNumberText.text;
            [self.navigationController pushViewController:manage animated:YES];
            [manage release];
        }else if ([ShareApp.pageManageMent isEqualToString:@"chauffer"]) {
            [self getCouponInformation];
            ShareApp.mobilNumber = inputNumberText.text;
        }else {
            DriverViewController *drive = [[DriverViewController alloc] init];
            ShareApp.mobilNumber = inputNumberText.text;
            [self.navigationController pushViewController:drive animated:YES];
            [drive release];
        }
    }else if ([returenNews isEqualToString:@"f"]) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"登陆失败" 
                                                       message:@"请检查网络是否连接"
                                                      delegate:self 
                                             cancelButtonTitle:@"OK" 
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];
    }else if ([returenNews isEqualToString:@"pwd error"]) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"密码错误" 
                                                       message:@"请重新输入密码"
                                                      delegate:self 
                                             cancelButtonTitle:@"OK" 
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }else {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"未注册" 
                                                       message:@"请先注册账号"
                                                      delegate:self 
                                             cancelButtonTitle:@"OK" 
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    if(request.tag ==500){
        [self parseStringJson:[request responseString]];
    }else {
        [self parseCouponStringJson:[request responseString]];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    returnButton.hidden = NO;
    
}
-(void)dealloc
{ 
    [couponArray release];
    [dataArry release];
    [inputNumberText release];
    [passWordText release];
    [super dealloc];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
