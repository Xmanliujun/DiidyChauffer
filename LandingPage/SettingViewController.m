//
//  SettingViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "CONST.h"
#import "NSString+Hashing.h"
#import "SBJson.h"
#import "AppDelegate.h"
#import "NSString+Hashing.h"
#import "CouponViewController.h"
#import "ManageMentViewController.h"
#import "JSONKit.h"
@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize mobilNumber,optype;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(id)initWithRegisteredOrForgot:(NSString*)judge
{
    if([super init])
    {
        
        _judge = [judge retain];
    
    }
    
    return self;


}
-(void)startASetNumber:(NSTimer*)time
{
    currentTime--;
    NSString * verifcationCodeTime = [NSString stringWithFormat:@"重新获取验证码(%ds)",currentTime];
    [regainbutton setBackgroundImage:[UIImage imageNamed:@"u190_normal.png"] forState:UIControlStateNormal];
    [regainbutton setTitle:verifcationCodeTime forState:UIControlStateNormal];

    if(currentTime==0){
        regainbutton.userInteractionEnabled = YES;
        [time invalidate];
        [regainbutton setBackgroundImage:[UIImage imageNamed:@"u175_normal.png"] forState:UIControlStateNormal];
        [regainbutton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    }
    
  
}


-(void)pushCompleteView:(id)sender
{
    if([_judge isEqualToString:@"TRUE"]){
    
        if([passWordText.text length]!=0){
    
            if([passWordText.text isEqualToString:confirmText.text]){
                
                NSString * baseUrl = [NSString stringWithFormat:SETUP,verificationText.text,[passWordText.text MD5Hash],[confirmText.text MD5Hash],mobilNumber,optype,ShareApp.uniqueString,ShareApp.reachable,ShareApp.phoneVerion,ShareApp.deviceName];
                baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL * url = [NSURL URLWithString:baseUrl];
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
                [request setDelegate:self];
                [request setTag:100];
                [request startAsynchronous];
                
            }else {
                
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                               message:@"您输入的两次密码不一致哦，再试试看"
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK" 
                                                     otherButtonTitles:nil];
                [alert show];
                [alert release];
                
                
            }

        }else {
            
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                           message:@"密码不能为空"
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil];

    
            [alert show];
            [alert release];
        }
        
    }else{
        if([passWordText.text length]!=0){
            
            if([passWordText.text isEqualToString:confirmText.text]){
                
                NSString * baseUrl = [NSString stringWithFormat:SETUP,verificationText.text,[passWordText.text MD5Hash],[confirmText.text MD5Hash],mobilNumber,optype,ShareApp.uniqueString,ShareApp.reachable,ShareApp.phoneVerion,ShareApp.deviceName];  
                baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL * url = [NSURL URLWithString:baseUrl];
                
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
                [request setDelegate:self];
                [request setTag:101];
                [request startAsynchronous];
                
            }else {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                               message:@"您输入的两次密码不一致哦，再试试看"
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK" 
                                                     otherButtonTitles:nil];
                [alert show];
                [alert release];
                

            }
            
        }else {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                           message:@"密码不能为空"
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil];
            
            
            [alert show];
            [alert release];
        }
        
    }
}
-(void)parseStringJson:(NSString *)str
{
   // NSDictionary * jsonParser =[str JSONValue];
    NSDictionary * jsonParser =[str objectFromJSONString];
    returenNews =[[jsonParser objectForKey:@"r"] retain];
    if([_judge isEqualToString:@"TRUE"]){
       if([returenNews isEqualToString:@"s"]){
            if([ShareApp.pageManageMent isEqualToString:@"coupon"]){
                CouponViewController * cou = [[[CouponViewController alloc] init] autorelease];
                [self.navigationController pushViewController:cou animated:YES];
            }else {
                ManageMentViewController * manage = [[[ManageMentViewController alloc] init] autorelease];
                [self.navigationController pushViewController:manage animated:YES];
            }
        }else {
            
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                           message:@"输入错误,在试试看吧!"
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil];
            
            
            [alert show];
            [alert release];
        }
    }else {
        if([returenNews isEqualToString:@"s"]){
            
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                           message:@"您已成功修改密码"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil];
            
            
            [alert show];
            [alert release];

       }else{
           UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                          message: @"您修改密码失败,请重试"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK" 
                                                otherButtonTitles:nil];
           
           
           [alert show];
           [alert release];
       }
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if([returenNews isEqualToString:@"s"]){
        
        if([ShareApp.pageManageMent isEqualToString:@"coupon"]){
            
            CouponViewController * cou = [[[CouponViewController alloc] init] autorelease];
            [self.navigationController pushViewController:cou animated:YES];
            
            
        }else {
            
            ManageMentViewController * manage = [[[ManageMentViewController alloc] init] autorelease];
            [self.navigationController pushViewController:manage animated:YES];
            
        }
    }


}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if ([[request responseString] length]==0) {
        if([_judge isEqualToString:@"TRUE"]){
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"注册失败"
                                                           message:@"请检查网络是否连接"
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil ];
            [alert show];
            [alert release];
        }else{
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"修改密码失败"
                                                           message:@"请检查网络是否连接"
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil ];
            [alert show];
            [alert release];
        
        
        }
        
       
    }else{
        
        [self parseStringJson:[request responseString]];
    }
}
-(void)getSMSCodeAgain:(id)sender
{
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startASetNumber:) userInfo:nil repeats:YES];
    currentTime = 60;
    regainbutton.userInteractionEnabled = NO;
    
    NSString * baseUrl = [NSString stringWithFormat:REGAIN,mobilNumber]; 
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:baseUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setTag:102];
    [request startAsynchronous];

}

-(void)returRegisteredView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [verificationText resignFirstResponder];
    [confirmText resignFirstResponder];
    [passWordText resignFirstResponder];
    return YES;

}
#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    currentTime = 60;
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    [self.navigationController.navigationBar addSubview:topImageView];    
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0f, 5.0f, 55.0f, 35.0f);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returRegisteredView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    UIImageView * lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    lineImageView.frame = CGRectMake(4.0f, 40.0f, 290.0f, 3.0f);
    
    UIImageView * secondLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    secondLineImageView.frame = CGRectMake(4.0f, 80.0f, 290.0f, 3.0f);
    
    UIImageView * threeLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u125_line.png"]];
    threeLineImageView.frame = CGRectMake(80.0f, 4.0f, 3.0f, 115.0f);
    
    verificationText = [[UITextField alloc] initWithFrame:CGRectMake(85.0f, 5.0f, 160.0f,35.0f)];
    verificationText.backgroundColor = [UIColor clearColor];
    verificationText.keyboardType = UIKeyboardTypeDefault;
    verificationText.font = [UIFont fontWithName:@"Arial" size:15.0f];
    verificationText.borderStyle = UITextBorderStyleNone;
    verificationText.autocorrectionType = UITextAutocorrectionTypeYes;
    verificationText.placeholder = @"请输入验证码";
    verificationText.returnKeyType = UIReturnKeyDone;
    verificationText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    verificationText.delegate = self;
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(85.0f, 45.0f, 160.0f,35.0f)];
    passWordText.backgroundColor = [UIColor clearColor];
    passWordText.keyboardType = UIKeyboardTypeDefault;
    passWordText.font = [UIFont fontWithName:@"Arial" size:15.0f];
    passWordText.borderStyle = UITextBorderStyleNone;
    passWordText.autocorrectionType = UITextAutocorrectionTypeYes;
    passWordText.placeholder = @"请输入密码";
    passWordText.returnKeyType = UIReturnKeyDone;
    passWordText.secureTextEntry = YES;
    passWordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passWordText.delegate = self;
    
    confirmText = [[UITextField alloc] initWithFrame:CGRectMake(85.0f, 85.0f, 160.0f,35.0f)];
    confirmText.backgroundColor = [UIColor clearColor];
    confirmText.keyboardType = UIKeyboardTypeDefault;
    confirmText.font = [UIFont fontWithName:@"Arial" size:15.0f];
    confirmText.borderStyle = UITextBorderStyleNone;
    confirmText.autocorrectionType = UITextAutocorrectionTypeYes;
    confirmText.placeholder = @"请输入确认密码";
    confirmText.returnKeyType = UIReturnKeyDone;
    confirmText.secureTextEntry = YES;
    confirmText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    confirmText.delegate = self;
    
    UIImage * informationImage = [UIImage imageNamed:@"u90_normal.png"];
    UIImageView * informationImageView = [[UIImageView alloc] initWithImage:informationImage];
    informationImageView.frame = CGRectMake(10.0f, 20.0f, informationImage.size.width, informationImage.size.height);
    informationImageView.userInteractionEnabled = YES;
    
    NSArray * lableAArray =[NSArray arrayWithObjects:@"验证码",@"密码",@"确认密码",nil];
    NSArray * lableBArray = [NSArray arrayWithObjects:@"验证码",@"新密码",@"确认密码", nil];
    
    for(int i = 0;i<3;i++){
        UILabel * firstLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 40.0f*i, 80.0f, 40.0f)];
        
        if([_judge isEqualToString:@"TRUE"]){
            
            firstLable.text = [lableAArray objectAtIndex:i];
            
        }else {
            
            firstLable.text = [lableBArray objectAtIndex:i];
        }
        
        firstLable.backgroundColor = [UIColor clearColor];
        firstLable.textAlignment = UITextAlignmentCenter;
        firstLable.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [informationImageView addSubview:firstLable];
        [firstLable release];
    }
    [informationImageView addSubview:confirmText];
    [informationImageView addSubview:passWordText];
    [informationImageView addSubview:verificationText];    
    [informationImageView addSubview:threeLineImageView];
    [informationImageView addSubview:secondLineImageView];
    [informationImageView addSubview:lineImageView];
    [self.view addSubview:informationImageView];
    [informationImageView release];
    [secondLineImageView release];
    [lineImageView release];
    [threeLineImageView release];
    
    regainbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    regainbutton.userInteractionEnabled = NO;
    regainbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    regainbutton.frame=CGRectMake(20.0f, 160.0f, 128.0f, 38.0f);
    [regainbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [regainbutton setBackgroundImage:[UIImage imageNamed:@"u190_normal.png"] forState:UIControlStateNormal];
    [regainbutton setTitle:@"重新获取验证码(60s)" forState:UIControlStateNormal];
    [regainbutton addTarget:self action:@selector(getSMSCodeAgain:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regainbutton];
    
    UIButton*  completebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    completebutton.userInteractionEnabled = YES;
    completebutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    completebutton.frame=CGRectMake(168.0f, 160.0f, 128.0f, 38.0f);
    [completebutton setBackgroundImage:[UIImage imageNamed:@"u175_normal.png"] forState:UIControlStateNormal];
    [completebutton setTitle:@"完成" forState:UIControlStateNormal];
    [completebutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [completebutton addTarget:self action:@selector(pushCompleteView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completebutton];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startASetNumber:) userInfo:nil repeats:YES];
}


-(void)viewDidDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;

}
-(void)dealloc
{
    [topImageView release];
    [returenNews release];
    [optype release];
    [mobilNumber release];
    [_judge release];
    [verificationText release];
    [confirmText release];
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
