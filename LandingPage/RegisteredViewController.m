//
//  RegisteredViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RegisteredViewController.h"
#import "SettingViewController.h"
#import "AppDelegate.h"
#import "CONST.h"
#import "SBJson.h"
#import "Landing_DownLoadView.h"
#import "JSONKit.h"
#import "Reachability.h"
@interface RegisteredViewController ()

@end

@implementation RegisteredViewController
@synthesize registerIsTrue,registAndPassword_request;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    veriFicationImageView.hidden = YES;
    SettingViewController * set = [[SettingViewController alloc] initWithRegisteredOrForgot:registerIsTrue];
    set.mobilNumber = inputNumberText.text;
    if([registerIsTrue isEqualToString:@"TRUE"]){
        set.optype = @"register";
    }else {
        set.optype = @"password";
    }
    [self.navigationController pushViewController:set animated:YES];
    [set release];
    
}
#pragma mark-HTTP
-(void)parseStringJson:(NSString *)str
{
    if (HUD){
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }

    NSDictionary * jsonParser =[str objectFromJSONString];
    NSString * returenNews =[jsonParser objectForKey:@"r"];
    if([registerIsTrue isEqualToString:@"TRUE"]){ 
    
       if([returenNews isEqualToString:@"s"])
       {

           UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"短信验证码发送成功" 
                                                          message:@"验证码以通过短信发给您，请查看..."
                                                         delegate:self 
                                                cancelButtonTitle:@"确定" 
                                                otherButtonTitles:nil];
           [alert show];
           [alert release];
   
       }else if([returenNews isEqualToString:@"f"]) {

           UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"请重试" 
                                                          message:@"短信验证码发送失败" 
                                                         delegate:nil 
                                                cancelButtonTitle:@"确定" 
                                                otherButtonTitles:nil];
           [alert show];
           [alert release];
           
       }else if([returenNews isEqualToString:@"register"]){

           UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                          message:@"您已经注册账号" 
                                                         delegate:nil 
                                                cancelButtonTitle:@"确定" 
                                                otherButtonTitles:nil];
           [alert show];
           [alert release];

       }
   }else {
       if([returenNews isEqualToString:@"s"]){
           
           UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"找回密码成功" 
                                                          message: @"验证码已通过短信发给您,请立刻修改密码" 
                                                         delegate:self 
                                                cancelButtonTitle:@"确定" 
                                                otherButtonTitles:nil];
           [alert show];
           [alert release];
           
       }else if([returenNews isEqualToString:@"f"]) {
          
           UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                          message: @"找回密码失败,请重试" 
                                                         delegate:nil
                                                cancelButtonTitle:@"确定" 
                                                otherButtonTitles:nil];
           [alert show];
           [alert release];
       }else if([returenNews isEqualToString:@"no register"]){
           
           UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                          message: @"请您先注册账号" 
                                                         delegate:nil
                                                cancelButtonTitle:@"确定" 
                                                otherButtonTitles:nil];
           [alert show];
           [alert release];
        }

   }
}
-(void)requFinish:(NSString *)requestString order:(int)nOrder
{

    if ([requestString length]==0) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"注册失败"
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

    [self closeConnection];

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


- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
    [HUD release];
     HUD = nil;
}
#pragma mark-button
-(void)determineStep:(id)sender
{
    veriFicationImageView.hidden = YES;
    SettingViewController * set = [[SettingViewController alloc] initWithRegisteredOrForgot:registerIsTrue];
    set.mobilNumber = inputNumberText.text;
    
    if([registerIsTrue isEqualToString:@"TRUE"]){
        
        set.optype = @"register";
        
    }else {
        
        set.optype = @"password";
        
    }
    
    [self.navigationController pushViewController:set animated:YES];
    [set release];
}

-(void)nextStep:(id)sender
{
    ShareApp.mobilNumber = inputNumberText.text;
    [inputNumberText resignFirstResponder];
    
    Reachability * r =[Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([r currentReachabilityStatus]==0) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"联网失败,请稍后再试"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }else{

        if (inputNumberText.text !=NULL) {
        
            if([registerIsTrue isEqualToString:@"TRUE"]){
            
                NSLog(@"注册账号");
                baseUrl = [NSString stringWithFormat:REGISTER,inputNumberText.text];
                baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                baseStatus = @"用户注册...";
                [self showWithDetails];
            
            
            }else {
            
                NSLog(@"修改密码");
                baseUrl = [NSString stringWithFormat:PASSWORD,inputNumberText.text];
                baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                baseStatus = @"找回密码...";
                [self showWithDetails];
            
            }
        
        }else {
        
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"请输入手机号"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
            [alert show];
            [alert release];
        
        }
    }
}


-(void)returnLandingView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)showWithDetails{
    
    HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=baseStatus;
    //HUD.detailsLabelText=@"正在加载...";
    HUD.square=YES;
    [HUD show:YES];
    
    HTTPRequest *request = [[HTTPRequest alloc] init];
    self.registAndPassword_request = request;
    self.registAndPassword_request.m_delegate = self;
    self.registAndPassword_request.hasTimeOut = YES;
    [request release];
    
    [self.registAndPassword_request requestByUrlByGet: baseUrl];
}


-(void)creatVeriFicationCodeView
{
    
    UIButton *determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [determineButton setBackgroundImage:[UIImage imageNamed:@"button_gray_down.png"] forState:UIControlStateNormal];
    [determineButton  setTitle:@"确定" forState:UIControlStateNormal];
    determineButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    determineButton .frame=CGRectMake(52.0f, 90.0f, 160.0f, 25.0f);
    [determineButton addTarget:self action:@selector(determineStep:) forControlEvents:UIControlEventTouchUpInside];
    
    promptLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 260.0f, 40.0f)];
    promptLable.font = [UIFont fontWithName:@"Arial" size:14.0f];
    promptLable.backgroundColor = [UIColor clearColor];
    promptLable.textAlignment = NSTextAlignmentCenter;
    
    contentLable = [[UILabel alloc] initWithFrame:CGRectMake(2.0f, 30.0f, 260.0f, 40.0f)];
    contentLable.font = [UIFont fontWithName:@"Arial" size:14.0f];
    contentLable.backgroundColor = [UIColor clearColor];
    contentLable.textAlignment =   NSTextAlignmentCenter;
    
    UIImage * veriFicationImage = [UIImage imageNamed:@"u63_normal.png"];
    veriFicationImageView = [[UIImageView alloc] initWithImage:veriFicationImage];
    veriFicationImageView.frame = CGRectMake(25.0f, 100.0f, veriFicationImage.size.width, veriFicationImage.size.height);
    veriFicationImageView.userInteractionEnabled = YES;
    veriFicationImageView.hidden = YES;
    
    [veriFicationImageView addSubview:contentLable];
    [veriFicationImageView addSubview:determineButton];
    [veriFicationImageView addSubview:promptLable];
    [self.view addSubview:veriFicationImageView];
    
}


#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, -2.0f, 320.0f, 49.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0f, 7.0f, 50.0f, 30.0f);
    [returnButton setTitle:@"返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnLandingView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rigthbutton.frame=CGRectMake(260.0f, 5.0f, 55.0f, 35.0f);
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"button4.png"] forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    UILabel * telNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 40.0f)];
    telNumberLable.text = @"手机号码";
    telNumberLable.font = [UIFont fontWithName:@"Arial" size:14.0f];
    telNumberLable.backgroundColor = [UIColor clearColor];
    telNumberLable.textAlignment = NSTextAlignmentCenter;
    
    UIImage* telNumberImage = [UIImage imageNamed:@"u30_normal.png"];
    UIImageView * telNumberImageView = [[UIImageView alloc] initWithImage:telNumberImage];
    telNumberImageView.frame = CGRectMake(10.0f, 10.0f, telNumberImage.size.width, telNumberImage.size.height);
    [telNumberImageView addSubview:telNumberLable];
    [self.view addSubview:telNumberImageView];
    [telNumberLable release];
    [telNumberImageView release];
    
    UIImage* lineImage = [UIImage imageNamed:@"u54_line.png"];
    UIImageView * lineImageView = [[UIImageView alloc] initWithImage:lineImage];
    lineImageView.frame = CGRectMake(112.0f, 13.0f, lineImage.size.width, lineImage.size.height);
    [self.view addSubview:lineImageView];
    [lineImageView release];
    
    inputNumberText = [[UITextField alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 160.0f,46.0f)];
    inputNumberText.backgroundColor = [UIColor clearColor];
    inputNumberText.keyboardType = UIKeyboardTypePhonePad;
    inputNumberText.font = [UIFont fontWithName:@"Arial" size:14.0f];
    inputNumberText.borderStyle = UITextBorderStyleNone;
    inputNumberText.autocorrectionType = UITextAutocorrectionTypeYes;
    inputNumberText.placeholder = @"请输入注册手机号";
    inputNumberText.returnKeyType = UIReturnKeyDone;
    inputNumberText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIImage* enterNumberImage = [UIImage imageNamed:@"u28_normal.png"];
    UIImageView * enterNumberImageView = [[UIImageView alloc] initWithImage:enterNumberImage];
    enterNumberImageView.frame = CGRectMake(111.0f, 10.0f, enterNumberImage.size.width, enterNumberImage.size.height);
    enterNumberImageView.userInteractionEnabled = YES;
    [enterNumberImageView addSubview:inputNumberText];
    [self.view addSubview:enterNumberImageView];
    [enterNumberImageView release];
    
    [self creatVeriFicationCodeView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;

}
-(void)viewDidAppear:(BOOL)animated
{
    topImageView.hidden = NO;
    returnButton.hidden = NO;
    rigthbutton.hidden = NO;
}
-(void)dealloc
{
    [contentLable release];
    [inputNumberText release];
    [promptLable release];
    [registerIsTrue release];
    [topImageView release];
    [veriFicationImageView release];
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
