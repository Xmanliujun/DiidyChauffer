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
-(void)creatVeriFicationCodeView
{
    
    UIButton *determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [determineButton setBackgroundImage:[UIImage imageNamed:@"button_gray_down.png"] forState:UIControlStateNormal];
    [determineButton  setTitle:@"确定" forState:UIControlStateNormal];
    determineButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    determineButton .frame=CGRectMake(52.0, 90.0, 160.0, 25.0);
    [determineButton addTarget:self action:@selector(determineStep:) forControlEvents:UIControlEventTouchUpInside];
   
    promptLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 260.0, 40.0)];
    promptLable.font = [UIFont fontWithName:@"Arial" size:14.0];
    promptLable.backgroundColor = [UIColor clearColor];
    promptLable.textAlignment = UITextAlignmentCenter;
    
    contentLable = [[UILabel alloc] initWithFrame:CGRectMake(2.0, 30.0, 260.0, 40.0)];
    contentLable.font = [UIFont fontWithName:@"Arial" size:14.0];
    contentLable.backgroundColor = [UIColor clearColor];
    contentLable.textAlignment = UITextAlignmentCenter;
    
    UIImage * veriFicationImage = [UIImage imageNamed:@"u63_normal.png"];
    veriFicationImageView = [[UIImageView alloc] initWithImage:veriFicationImage];
    veriFicationImageView.frame = CGRectMake(25.0, 100.0, veriFicationImage.size.width, veriFicationImage.size.height);
    veriFicationImageView.userInteractionEnabled = YES;
    veriFicationImageView.hidden = YES;
    
    [veriFicationImageView addSubview:contentLable];
    [veriFicationImageView addSubview:determineButton];
    [veriFicationImageView addSubview:promptLable];
    [self.view addSubview:veriFicationImageView];
      
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];

    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"u108_normalp.png"] forState:UIControlStateNormal];
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    leftbutton.frame=CGRectMake(0.0, 100.0, 43.0, 25.0);
    [leftbutton addTarget:self action:@selector(returnLandingView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];
    
    UIButton *rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"u38_normal.png"] forState:UIControlStateNormal];
    [rigthbutton setTitle:@"下一步" forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rigthbutton.frame=CGRectMake(0.0, 100.0, 60.0, 25.0);
    [rigthbutton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];

    UILabel * telNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 40.0)];
    telNumberLable.text = @"手机号码";
    telNumberLable.font = [UIFont fontWithName:@"Arial" size:14.0];
    telNumberLable.backgroundColor = [UIColor clearColor];
    telNumberLable.textAlignment = UITextAlignmentCenter;
    
    UIImage* telNumberImage = [UIImage imageNamed:@"u30_normal.png"];
    UIImageView * telNumberImageView = [[UIImageView alloc] initWithImage:telNumberImage];
    telNumberImageView.frame = CGRectMake(10.0, 10.0, telNumberImage.size.width, telNumberImage.size.height);
    [telNumberImageView addSubview:telNumberLable];
    [self.view addSubview:telNumberImageView];
    [telNumberLable release];
    [telNumberImageView release];
    
    UIImage* lineImage = [UIImage imageNamed:@"u54_line.png"];
    UIImageView * lineImageView = [[UIImageView alloc] initWithImage:lineImage];
    lineImageView.frame = CGRectMake(112.0, 13.0, lineImage.size.width, lineImage.size.height);
    [self.view addSubview:lineImageView];
    [lineImageView release];
    
    inputNumberText = [[UITextField alloc] initWithFrame:CGRectMake(5.0, 0.0, 160.0,46.0)];
    inputNumberText.backgroundColor = [UIColor clearColor];
    inputNumberText.keyboardType = UIKeyboardTypePhonePad;
    inputNumberText.font = [UIFont fontWithName:@"Arial" size:14.0];
    inputNumberText.borderStyle = UITextBorderStyleNone;
    inputNumberText.autocorrectionType = UITextAutocorrectionTypeYes;
    inputNumberText.placeholder = @"请输入注册手机号";
    inputNumberText.returnKeyType = UIReturnKeyDone;
    inputNumberText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIImage* enterNumberImage = [UIImage imageNamed:@"u28_normal.png"];
    UIImageView * enterNumberImageView = [[UIImageView alloc] initWithImage:enterNumberImage];
    enterNumberImageView.frame = CGRectMake(111.0, 10.0, enterNumberImage.size.width, enterNumberImage.size.height);
    enterNumberImageView.userInteractionEnabled = YES;
    [enterNumberImageView addSubview:inputNumberText];
    [self.view addSubview:enterNumberImageView];
    [enterNumberImageView release];
    
    [self creatVeriFicationCodeView];
    
    
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
    
    

}
-(void)nextStep:(id)sender
{
    [inputNumberText resignFirstResponder];
    if([registerIsTrue isEqualToString:@"TRUE"]){
        NSLog(@"注册账号");
        NSString * baseUrl = [NSString stringWithFormat:REGISTER,inputNumberText.text];
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * url = [NSURL URLWithString:baseUrl];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        NSLog(@"url=%@",url);
        [request setDelegate:self];
        [request setTag:101];
        [request startAsynchronous];
            
    }else {
        NSLog(@"修改密码");
        NSString * baseUrl = [NSString stringWithFormat:PASSWORD,inputNumberText.text];
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * url = [NSURL URLWithString:baseUrl];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        NSLog(@"url=%@",url);
        [request setDelegate:self];
        [request setTag:100];
        [request startAsynchronous];
    }
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
    


}
-(void)parseStringJson:(NSString *)str
{
    NSDictionary * jsonParser =[str JSONValue];
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

-(void)returnLandingView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)dealloc
{
    [registerIsTrue release];
    [contentLable release];
    [promptLable release];
    [inputNumberText release];
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
