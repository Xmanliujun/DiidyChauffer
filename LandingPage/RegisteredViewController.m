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
@interface RegisteredViewController ()

@end

@implementation RegisteredViewController
@synthesize registerIsTrue;
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
-(void)parseStringJson:(NSString *)str
{
//    NSDictionary * jsonParser =[str JSONValue];
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
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self parseStringJson:[request responseString]];
    
    
}
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


-(void)startASync:(id)urlString1{
    NSURL *url=[NSURL URLWithString:urlString1];
    NSLog(@"url========%@",url);
    NSError *error=nil;
    NSString *responseString=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"response data is %@", responseString);
    if ([responseString length]==0) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"注册失败"
                                                       message:@"请检查网络是否连接"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];
    }else{
        [self parseStringJson:responseString];
    }
}

-(void)myTask{
    //形成异步加载
   
    [self startASync:baseUrl];
    
}

-(void)showWithDetails{
    
    HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=baseStatus;
    //HUD.detailsLabelText=@"正在加载...";
    HUD.square=YES;
    //此处进入多线程处理
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

-(void)nextStep:(id)sender
{
    ShareApp.mobilNumber = inputNumberText.text;
    [inputNumberText resignFirstResponder];
    if (inputNumberText.text !=NULL) {
        
        if([registerIsTrue isEqualToString:@"TRUE"]){
            NSLog(@"注册账号");
            baseUrl = [NSString stringWithFormat:REGISTER,inputNumberText.text];
            baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            baseStatus = @"用户注册...";
            [self showWithDetails];
//            NSURL * url = [NSURL URLWithString:baseUrl];
//            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//            NSLog(@"url=%@",url);
//            [request setDelegate:self];
//            [request setTag:101];
//            [request startAsynchronous];
            
        }else {
            NSLog(@"修改密码");
            baseUrl = [NSString stringWithFormat:PASSWORD,inputNumberText.text];
            baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            baseStatus = @"找回密码...";
            [self showWithDetails];
//            NSURL * url = [NSURL URLWithString:baseUrl];
//            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//            NSLog(@"url=%@",url);
//            [request setDelegate:self];
//            [request setTag:100];
//            [request startAsynchronous];
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


-(void)returnLandingView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

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
    promptLable.textAlignment = UITextAlignmentCenter;
    
    contentLable = [[UILabel alloc] initWithFrame:CGRectMake(2.0f, 30.0f, 260.0f, 40.0f)];
    contentLable.font = [UIFont fontWithName:@"Arial" size:14.0f];
    contentLable.backgroundColor = [UIColor clearColor];
    contentLable.textAlignment = UITextAlignmentCenter;
    
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0f, 5.0f, 55.0f, 35.0f);
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
    telNumberLable.textAlignment = UITextAlignmentCenter;
    
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
