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
#import "CouponViewController.h"
#import "ManageMentViewController.h"
#import "DIIdyModel.h"
#import "SelectCouponViewController.h"
#import "OrdersPreviewViewController.h"
#import "DriverViewController.h"
#import "OrdersPreviewTwoViewController.h"
#import "MoreViewController.h"
#import "JSONKit.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import "MobClick.h"

@implementation LandingViewController
@synthesize couponArray;
@synthesize CouponInformation_request,land_request;
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
    
    UIView* landView = [[UIView alloc] initWithFrame: CGRectMake(10.0f, 15.0f, 300.0,102.0f)];
    landView.backgroundColor = [UIColor whiteColor];
    [[landView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[landView layer] setShadowRadius:5];
    [[landView layer] setShadowOpacity:1];
    [[landView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[landView layer] setCornerRadius:7];
    [[landView layer] setBorderWidth:1];
    [[landView layer] setBorderColor:[UIColor grayColor].CGColor];
    
    UIImageView*lineImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u721_line.png"]];
    lineImage.frame = CGRectMake(0, 51, 300, 3);
    [landView addSubview:lineImage];
    [lineImage release];
    
    UILabel * inputLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f,51.0f)];
    inputLable.text = @"手机号:";
    inputLable.backgroundColor = [UIColor clearColor];
    inputLable.textAlignment = NSTextAlignmentCenter;
    inputLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    
    inputNumberText = [[UITextField alloc] initWithFrame:CGRectMake(70.0f, 2.0f, 200.0f,51.0f)];
    inputNumberText.backgroundColor = [UIColor clearColor];
    inputNumberText.keyboardType = UIKeyboardTypePhonePad;
    inputNumberText.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputNumberText.font = [UIFont fontWithName:@"Arial" size:16.0f];
    inputNumberText.borderStyle = UITextBorderStyleNone;
    inputNumberText.autocorrectionType = UITextAutocorrectionTypeYes;
    inputNumberText.placeholder = @"请输入手机号";
    inputNumberText.returnKeyType = UIReturnKeyDone;
    inputNumberText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
       
    UILabel * passWordLable = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 51.0f, 70.0f, 51.0f)];
    passWordLable.text = @"密码:";
    passWordLable.backgroundColor = [UIColor clearColor];
    passWordLable.textAlignment = NSTextAlignmentLeft;
    passWordLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(70.0f, 51.0f, 200.0f,51.0f)];
    passWordText.backgroundColor = [UIColor clearColor];
    passWordText.keyboardType = UIKeyboardTypeDefault;
    passWordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordText.font = [UIFont fontWithName:@"Arial" size:16.0f];
    passWordText.borderStyle = UITextBorderStyleNone;
    passWordText.autocorrectionType = UITextAutocorrectionTypeYes;
    passWordText.placeholder = @"请输入密码";
    passWordText.returnKeyType = UIReturnKeyDone;
    passWordText.secureTextEntry = YES;
    passWordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passWordText.delegate = self;
    
    [landView addSubview:inputNumberText];
    [landView addSubview:inputLable];
    [landView addSubview:passWordText];
    [landView addSubview:passWordLable];
    [self.view addSubview:landView];
    [inputLable release];
    [passWordLable release];
    [landView release];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [passWordText resignFirstResponder];
    return YES;
}
#pragma mark-Button
-(void)registeredUsers:(id)sender
{
    [MobClick event:@"m09_u001"];
    RegisteredViewController * registered = [[RegisteredViewController alloc] init];
    registered.registerIsTrue = @"TRUE";
    returnButton.hidden = YES;
    [self.navigationController pushViewController:registered animated:YES];
    [registered release];
    
}
-(void)forgotPassword:(id)sender
{
    [MobClick event:@"m09_u003"];
    RegisteredViewController * registered = [[RegisteredViewController alloc] init];
    registered.registerIsTrue = @"NO";
    returnButton.hidden = YES;
    [self.navigationController pushViewController:registered animated:YES];
    [registered release];
    
}
-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
    
}

-(void)closeConnection
{
    
    if (HUD){
        
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)requesttimeout
{
    [self closeConnection];

}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
    [HUD release];
     HUD = nil;
}

-(void)clientLandedPage:(id)sender
{
    [MobClick event:@"m09_u002_0001"];

    [inputNumberText resignFirstResponder];
    [passWordText resignFirstResponder];
    
    ShareApp.mobilNumber = inputNumberText.text;
    
   if (![ShareApp connectedToNetwork]) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"联网失败,请稍后再试"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }else{

        if(inputNumberText.text==NULL||[inputNumberText.text length]==0)
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"请输入手机号"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
            [alert show];
            [alert release];
    
        }else if (passWordText.text==NULL||[passWordText.text length]==0)
        {
    
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"请输入密码"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
            [alert show];
            [alert release];
    
        }else{
            
            HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.delegate=self;
            HUD.labelText=@"正在登陆...";
            //HUD.detailsLabelText=@"正在加载...";
            HUD.square=YES;
            [HUD show:YES];
           
            NSString * baseUrl = [NSString stringWithFormat:LAND,inputNumberText.text,[passWordText.text MD5Hash],ShareApp.uniqueString,ShareApp.reachable,ShareApp.phoneVerion,ShareApp.deviceName];
            NSLog(@"%@",baseUrl);
            baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
            HTTPRequest *request = [[HTTPRequest alloc] init];
            request.forwordFlag = 500;
            self.land_request = request;
            self.land_request.m_delegate = self;
            self.land_request.hasTimeOut = YES;
            [request release];
    
            [self.land_request requestByUrlByGet: baseUrl];
    
        }
    }
}

-(void)getCouponInformation{

    NSString * baseUrl = [NSString stringWithFormat:COUPON,inputNumberText.text];
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HTTPRequest *request = [[HTTPRequest alloc] init];
    request.forwordFlag=505;
    self.CouponInformation_request = request;
    self.CouponInformation_request.m_delegate = self;
    self.CouponInformation_request.hasTimeOut = YES;
    [request release];
    [self.CouponInformation_request requestByUrlByGet: baseUrl];
        
}

#pragma mark-Http
-(void)parseCouponStringJson:(NSString*)str
{
    
    int total = 0;
   [dataArry removeAllObjects];
    NSArray* jsonParser =[str objectFromJSONString];
    
    for (int i = 0; i<[jsonParser count];i++) {
        
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
        
        SelectCouponViewController * selectCoupon = [[SelectCouponViewController alloc]init];
        selectCoupon.selectCouponAray = dataArry;
        selectCoupon.rowNumber = total;
        selectCoupon.mark = YES;
        selectCoupon.orderPreArray = self.couponArray;
        [self.navigationController pushViewController:selectCoupon animated:YES];
        [selectCoupon release];
    
    }else {
        
        OrdersPreviewTwoViewController * orderPre = [[OrdersPreviewTwoViewController alloc] init];
        ShareApp.mobilNumber = inputNumberText.text;
        orderPre.markPre=NO;
        orderPre.orderArray = self.couponArray;
        [self.navigationController pushViewController:orderPre animated:YES];
        [orderPre release];

    }
}
-(void)parseStringJson:(NSString *)str
{
    if (HUD){
        
        [HUD removeFromSuperview];
        [HUD release];
         HUD = nil;
    }

    NSDictionary * jsonParser =[str objectFromJSONString];
    NSString * returenNews =[jsonParser objectForKey:@"r"];
    ShareApp.logInState = returenNews;
    
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *plugin1 = [[NSMutableDictionary alloc]init];
    [plugin1 setObject:returenNews forKey:@"status"];
    [plugin1 setObject:inputNumberText.text forKey:@"telephone"];
    [dictplist setObject:plugin1 forKey:@"statusDict"];
    [dictplist writeToFile:plistPath atomically:YES];
    [plugin1 release];
    [dictplist release];
    
    if([returenNews isEqualToString:@"s"])
    {
        [MobClick event:@"m09_u002_0001_0001"];

        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"land",@"STATUS", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LAND" object:self userInfo:dict];
        
        returnButton.hidden = YES;
        
        if([ShareApp.pageManageMent isEqualToString:@"coupon"]){
            
            CouponViewController * cou = [[CouponViewController alloc] init];
            cou.couponStat = YES;
            ShareApp.mobilNumber = inputNumberText.text;
            [self.navigationController pushViewController:cou animated:YES];
            [cou release];
            
        }else if([ShareApp.pageManageMent isEqualToString:@"manage"]) {
            
            ManageMentViewController * manage = [[ManageMentViewController alloc] init];
            manage.manageStat = YES;
            ShareApp.mobilNumber = inputNumberText.text;
            [self.navigationController pushViewController:manage animated:YES];
            [manage release];
            
        }else if ([ShareApp.pageManageMent isEqualToString:@"chauffer"]) {
            
            [self getCouponInformation];
            ShareApp.mobilNumber = inputNumberText.text;
            
        }else if([ShareApp.pageManageMent isEqualToString:@"Driver"]){
            
            DriverViewController *drive = [[DriverViewController alloc] init];
            ShareApp.mobilNumber = inputNumberText.text;
            [self.navigationController pushViewController:drive animated:YES];
            [drive release];
            
        }else if([ShareApp.pageManageMent isEqualToString:@"notLog"]){
            
            MoreViewController * more =[[MoreViewController alloc] init];
            more.whereLand = @"Land";
            [self.navigationController pushViewController:more animated:YES];
            [more release];
            ShareApp.mobilNumber = inputNumberText.text;
            
        }
    }else if ([returenNews isEqualToString:@"f"]) {
        
        [MobClick event:@"m09_u002_0001_0002"];
        
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
        
        if(nOrder ==500){
            
            [self parseStringJson:requestString];
            
        }else {
            
            [self parseCouponStringJson:requestString];
        }
    }
}

#pragma mark - System Approach

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.navigationItem.hidesBackButton = YES;
    
    dataArry = [[NSMutableArray alloc] initWithCapacity:0];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, -2.0f, 320.0f, 49.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    returnButton.frame=CGRectMake(7.0f, 7.0f, 50.0f, 30.0f);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    UILabel * landingLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f,0.0f,160.0f,44.0f)];
    landingLable.text = @"用 户 登 录";
    landingLable.textAlignment =NSTextAlignmentCenter;
    landingLable.textColor = [UIColor whiteColor];
    landingLable.backgroundColor = [UIColor clearColor];
    landingLable.font = [UIFont fontWithName:@"Arial" size:18.0f];
    [self.navigationController.navigationBar addSubview:landingLable];
    [landingLable release];

    UIImage * landedImage =[UIImage imageNamed:@"land.png" ];
    UIButton*landedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [landedButton setTitle:@"登 陆" forState:UIControlStateNormal];
    landedButton.frame=CGRectMake(9.0f, 130.0f,landedImage.size.width,40);
    [landedButton setBackgroundImage:landedImage forState:UIControlStateNormal];
    [landedButton addTarget:self action:@selector(clientLandedPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:landedButton];
    
    UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(20.0f, 173.0f, 80.0f, 30.0f);
    [registerButton setTitle:@"还没注册>" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16.0f];
    [registerButton addTarget:self action:@selector(registeredUsers:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UIButton * forgotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgotButton.frame = CGRectMake(220.0f, 173.0f,80.0f, 30.0f);
    [forgotButton setTitle:@"忘记密码>" forState:UIControlStateNormal];
    [forgotButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    forgotButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16.0f];
    [forgotButton addTarget:self action:@selector(forgotPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotButton];
    
    [self creatInPutBox];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    topImageView.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    returnButton.hidden = NO;
    topImageView.hidden = NO;
    
}

-(void)dealloc
{
    if (land_request) {
        
        [self.land_request closeConnection];
        self.land_request.m_delegate=nil;
        self.land_request=nil;
    }
    
    if (CouponInformation_request) {
        
        [self.CouponInformation_request closeConnection];
        self.CouponInformation_request.m_delegate=nil;
        self.CouponInformation_request=nil;
    }
    
    [topImageView release];
    [couponArray release];
    [dataArry release];
    [inputNumberText release];
    [passWordText release];
    [super dealloc];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
