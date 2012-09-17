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
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    currentTime = 60;
    
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"u108_normalp.png"] forState:UIControlStateNormal];
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    leftbutton.frame=RECTMAKE(0.0, 100.0, 43.0, 25.0);    
    [leftbutton addTarget:self action:@selector(returRegisteredView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];
    
    UIImageView * lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    lineImageView.frame = CGRectMake(4.0, 40.0, 290.0, 3.0);
    
    UIImageView * secondLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    secondLineImageView.frame = CGRectMake(4.0, 80.0, 290.0, 3.0);
    
    UIImageView * threeLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u125_line.png"]];
    threeLineImageView.frame = CGRectMake(80.0, 4.0, 3.0, 115.0);
       
    verificationText = [[UITextField alloc] initWithFrame:CGRectMake(85.0, 5.0, 160,35.0)];
    verificationText.backgroundColor = [UIColor clearColor];
    verificationText.keyboardType = UIKeyboardTypeDefault;
    verificationText.font = [UIFont fontWithName:@"Arial" size:15.0];
    verificationText.borderStyle = UITextBorderStyleNone;
    verificationText.autocorrectionType = UITextAutocorrectionTypeYes;
    verificationText.placeholder = @"请输入验证码";
    verificationText.returnKeyType = UIReturnKeyDone;
    verificationText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    verificationText.delegate = self;
    
    passWordText = [[UITextField alloc] initWithFrame:CGRectMake(85.0, 45.0, 160.0,35.0)];
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

    confirmText = [[UITextField alloc] initWithFrame:CGRectMake(85.0, 85.0, 160.0,35.0)];
    confirmText.backgroundColor = [UIColor clearColor];
    confirmText.keyboardType = UIKeyboardTypeDefault;
    confirmText.font = [UIFont fontWithName:@"Arial" size:15.0];
    confirmText.borderStyle = UITextBorderStyleNone;
    confirmText.autocorrectionType = UITextAutocorrectionTypeYes;
    confirmText.placeholder = @"请输入确认密码";
    confirmText.returnKeyType = UIReturnKeyDone;
    confirmText.secureTextEntry = YES;
    confirmText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    confirmText.delegate = self;

    UIImage * informationImage = [UIImage imageNamed:@"u90_normal.png"];
    UIImageView * informationImageView = [[UIImageView alloc] initWithImage:informationImage];
    informationImageView.frame = CGRectMake(10.0, 20.0, informationImage.size.width, informationImage.size.height);
    informationImageView.userInteractionEnabled = YES;
    
    NSArray * lableAArray =[NSArray arrayWithObjects:@"验证码",@"密码",@"确认密码",nil];
    NSArray * lableBArray = [NSArray arrayWithObjects:@"验证码",@"新密码",@"确认密码", nil];
    
    for(int i = 0;i<3;i++){
        UILabel * firstLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*i, 80.0, 40.0)];
        
        if([_judge isEqualToString:@"TRUE"]){
            
            firstLable.text = [lableAArray objectAtIndex:i];
            
        }else {
            
            firstLable.text = [lableBArray objectAtIndex:i];
        }
        
            firstLable.backgroundColor = [UIColor clearColor];
            firstLable.textAlignment = UITextAlignmentCenter;
            firstLable.font = [UIFont fontWithName:@"Arial" size:14.0];
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
    
    regainbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    regainbutton.userInteractionEnabled = NO;
    regainbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    regainbutton.frame=CGRectMake(20.0, 160.0, 128.0, 38.0);
    [regainbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [regainbutton setBackgroundImage:[UIImage imageNamed:@"u190_normal.png"] forState:UIControlStateNormal];
    [regainbutton setTitle:@"重新获取验证码(60s)" forState:UIControlStateNormal];
    [regainbutton addTarget:self action:@selector(getSMSCodeAgain:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regainbutton];
    
    
    UIButton*  completebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    completebutton.userInteractionEnabled = YES;
    completebutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    completebutton.frame=CGRectMake(168.0, 160.0, 128.0, 38.0);
    [completebutton setBackgroundImage:[UIImage imageNamed:@"u175_normal.png"] forState:UIControlStateNormal];
    [completebutton setTitle:@"完成" forState:UIControlStateNormal];
    [completebutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [completebutton addTarget:self action:@selector(pushCompleteView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completebutton];
    
    UIButton* okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    okButton.frame=CGRectMake(82.0, 64.0, 106.0, 36.0);
    [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okButton setBackgroundImage:[UIImage imageNamed:@"u170_mouseOver.png"] forState:UIControlStateNormal];
    [okButton setTitle:@"好的" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(thanksIKnow:) forControlEvents:UIControlEventTouchUpInside];
    
    promtLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 250, 30)];
    promtLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    promtLable.backgroundColor = [UIColor clearColor];
    

    UIImage *promptImage = [UIImage imageNamed:@"u167_normal.png"];
    promptImageView = [[UIImageView alloc] initWithImage:promptImage];
    promptImageView.userInteractionEnabled = YES;
    promptImageView.hidden = YES;
    promptImageView.frame = CGRectMake(20, 210, promptImage.size.width, promptImage.size.height);
    [promptImageView addSubview:promtLable];
    [promptImageView addSubview:okButton];
    [self.view addSubview:promptImageView];
    
    UIButton* modifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    modifyButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    modifyButton.frame=CGRectMake(45.0, 44.0, 160.0, 25.0);
    [modifyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [modifyButton setBackgroundImage:[UIImage imageNamed:@"button_gray_down.png"] forState:UIControlStateNormal];
    [modifyButton setTitle:@"好的" forState:UIControlStateNormal];
    [modifyButton addTarget:self action:@selector(thanksIKnowModify:) forControlEvents:UIControlEventTouchUpInside];
    
    modifyLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 250, 30)];
    modifyLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    modifyLable.backgroundColor = [UIColor clearColor];
    modifyLable.textAlignment =UITextAlignmentCenter;
    
    UIImage *modifyImage = [UIImage imageNamed:@"u114_normal.png"];
    modifyImageView = [[UIImageView alloc] initWithImage:modifyImage];
    modifyImageView.userInteractionEnabled = YES;
    modifyImageView.hidden = YES;
    modifyImageView.frame = CGRectMake(35, 150, modifyImage.size.width, modifyImage.size.height);
    [modifyImageView addSubview:modifyLable];
    [modifyImageView addSubview:modifyButton];
    [self.view addSubview:modifyImageView];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startASetNumber:) userInfo:nil repeats:YES];
    
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

-(void)thanksIKnowModify:(id)sender
{
    modifyImageView.hidden = YES;
    
    if([returenNews isEqualToString:@"s"]){
        
        if([ShareApp.pageManageMent isEqualToString:@"coupon"]){
            
            CouponViewController * cou = [[CouponViewController alloc] init];
            [self.navigationController pushViewController:cou animated:YES];
            
        }else {
            
            ManageMentViewController * manage = [[ManageMentViewController alloc] init];
            [self.navigationController pushViewController:manage animated:YES];
        }
    }
}
-(void)thanksIKnow:(id)sender
{
    promptImageView.hidden = YES;
}
-(void)pushCompleteView:(id)sender
{
    if([_judge isEqualToString:@"TRUE"]){
    
        if(passWordText.text!=NULL){
    
            if([passWordText.text isEqualToString:confirmText.text]){
                
                NSString * baseUrl = [NSString stringWithFormat:SETUP,verificationText.text,[passWordText.text MD5Hash],[confirmText.text MD5Hash],mobilNumber,optype,ShareApp.uniqueString,ShareApp.reachable,ShareApp.phoneVerion,ShareApp.deviceName];
                baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL * url = [NSURL URLWithString:baseUrl];
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
                [request setDelegate:self];
                [request setTag:100];
                [request startAsynchronous];
                
            }else {
                
                promptImageView.hidden = NO;
                promtLable.text = @"您输入的两次密码不一致哦，再试试看";
                
            }

        }else {
                promptImageView.hidden = NO;
                promtLable.text = @"密码不能为空";
        }
        
    }else{
        if(passWordText.text!=NULL){
            
            if([passWordText.text isEqualToString:confirmText.text]){
                
                NSString * baseUrl = [NSString stringWithFormat:SETUP,verificationText.text,[passWordText.text MD5Hash],[confirmText.text MD5Hash],mobilNumber,optype,ShareApp.uniqueString,ShareApp.reachable,ShareApp.phoneVerion,ShareApp.deviceName];  
                baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL * url = [NSURL URLWithString:baseUrl];
                
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
                NSLog(@"url=%@",url);
                [request setDelegate:self];
                [request setTag:101];
                [request startAsynchronous];
                
            }else {
                promptImageView.hidden = NO;
                promtLable.text = @"您输入的两次密码不一致哦，再试试看";
            }
            
        }else {
                promptImageView.hidden = NO;
                promtLable.text = @"密码不能为空";
        }
        
    }
}
-(void)parseStringJson:(NSString *)str
{
    NSDictionary * jsonParser =[str JSONValue];
    returenNews =[[jsonParser objectForKey:@"r"] retain];
    if([_judge isEqualToString:@"TRUE"]){
       if([returenNews isEqualToString:@"s"]){
            if([ShareApp.pageManageMent isEqualToString:@"coupon"]){
                CouponViewController * cou = [[CouponViewController alloc] init];
                [self.navigationController pushViewController:cou animated:YES];
            }else {
                ManageMentViewController * manage = [[ManageMentViewController alloc] init];
                [self.navigationController pushViewController:manage animated:YES];
            }
        }else {
                promptImageView.hidden = NO;
                promtLable.text = @"输入错误,在试试看吧!";
        }
    }else {
        if([returenNews isEqualToString:@"s"]){
           
                modifyImageView.hidden = NO;
                modifyLable.text = @"您已成功修改密码";
       }else{
           
                modifyImageView.hidden = NO;
                modifyLable.text = @"您修改密码失败,请重试";

        }
    }
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self parseStringJson:[request responseString]];
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

-(void)dealloc
{
    [returenNews release];
    [optype release];
    [mobilNumber release];
    [_judge release];
    [promptImageView release];
    [promtLable release];
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
