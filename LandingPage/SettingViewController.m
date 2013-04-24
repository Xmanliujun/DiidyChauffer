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

#import "AppDelegate.h"
#import "NSString+Hashing.h"
#import "CouponViewController.h"
#import "ManageMentViewController.h"
#import "JSONKit.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import "MobClick.h"
@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize mobilNumber,optype,again_request,comRequest_request;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(id)initWithRegisteredOrForgot:(NSString*)judge
{
    self=[super init];
    if(self)
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

-(void)startASync{
   
    if([_judge isEqualToString:@"TRUE"]){
        
        if([passWordText.text length]!=0){
            
            if([passWordText.text isEqualToString:confirmText.text]){
                
                NSString * baseUrl = [NSString stringWithFormat:SETUP,verificationText.text,[passWordText.text MD5Hash],[confirmText.text MD5Hash],mobilNumber,optype,ShareApp.uniqueString,ShareApp.reachable,ShareApp.phoneVerion,ShareApp.deviceName];
                baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                HTTPRequest *request = [[HTTPRequest alloc] init];
                request.forwordFlag = 100;
                self.comRequest_request = request;
                self.comRequest_request.m_delegate = self;
                self.comRequest_request.hasTimeOut = YES;
                [request release];
                
                [self.comRequest_request requestByUrlByGet: baseUrl];
                
            }else {
                
                if (HUD){
                    [HUD removeFromSuperview];
                    [HUD release];
                    HUD = nil;
                }
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                               message:@"您输入的两次密码不一致哦，再试试看"
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
                [alert show];
                [alert release];
                
                
            }
            
        }else {
            
            if (HUD){
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
            }

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
                
                HTTPRequest *request = [[HTTPRequest alloc] init];
                request.forwordFlag = 101;
                self.comRequest_request = request;
                self.comRequest_request.m_delegate = self;
                self.comRequest_request.hasTimeOut = YES;
                [request release];
                
                [self.comRequest_request requestByUrlByGet: baseUrl];

                
            }else {
                
                if (HUD){
                    [HUD removeFromSuperview];
                    [HUD release];
                    HUD = nil;
                }

                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                               message:@"您输入的两次密码不一致哦，再试试看"
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
                [alert show];
                [alert release];
                
                
            }
            
        }else {
            
            if (HUD){
                
                [HUD removeFromSuperview];
                [HUD release];
                HUD = nil;
                
            }

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




-(void)parseAgainStringJson:(NSString*)againStr
{

    NSDictionary * jsonAgainParser =[againStr objectFromJSONString];
    NSString * returnAgainString = [jsonAgainParser objectForKey:@"r"];
    if ([returnAgainString isEqualToString:@"s"]) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"获取验证码成功!"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        
        [alert show];
        [alert release];
        
    }else if ([returnAgainString isEqualToString:@"f"])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"获取验证码失败!"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        
        [alert show];
        [alert release];
    
    }else if ([returnAgainString isEqualToString:@"no register"])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"您还未注册,请先注册!"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        
        [alert show];
        [alert release];
    
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
    returenNews =[[jsonParser objectForKey:@"r"] retain];
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *plugin1 = [[NSMutableDictionary alloc]init];
    [plugin1 setObject:returenNews forKey:@"status"];
    [plugin1 setObject:self.mobilNumber forKey:@"telephone"];
    
    [dictplist setObject:plugin1 forKey:@"statusDict"];
    
    [dictplist writeToFile:plistPath atomically:YES];
    [plugin1 release];
    [dictplist release];
   
    if([_judge isEqualToString:@"TRUE"]){
       
        if([returenNews isEqualToString:@"s"]){
            [MobClick event:@"m09_u001_0002_0001"];

            if([ShareApp.pageManageMent isEqualToString:@"coupon"]){
               
                CouponViewController * cou = [[[CouponViewController alloc] init] autorelease];
                [self.navigationController pushViewController:cou animated:YES];
                
            }else {
                
                ManageMentViewController * manage = [[[ManageMentViewController alloc] init] autorelease];
                 manage.manageStat = YES;
                [self.navigationController pushViewController:manage animated:YES];
                
            }
        }else {
            
            [MobClick event:@"m09_u001_0002_0002"];
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
          
            [MobClick event:@"m09_u003_0002_0001"];
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                           message:@"您已成功修改密码"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil];
            
            
            [alert show];
            [alert release];

       }else{
           
            [MobClick event:@"m09_u003_0002_0002"];
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
#pragma mark-HTTP

-(void)requFinish:(NSString *)requestString order:(int)nOrder
{
    
    if ([requestString length]==0) {
        
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
        if (nOrder==102) {
            
            [self parseAgainStringJson:requestString];
            
        }else{
            
            [self parseStringJson:requestString];
        }
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

-(void)pushCompleteView:(id)sender
{
     if (![ShareApp connectedToNetwork]) {
         
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"联网失败,请稍后再试"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }else{

        HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.delegate=self;
        //HUD.labelText=baseStatus;
        HUD.detailsLabelText=@"正在加载...";
        HUD.square=YES;
        [HUD show:YES];
    
        [self startASync];
    }
    
}

-(void)returRegisteredView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([_judge isEqualToString:@"TRUE"]){
        
        [MobClick event:@"m09_u001_0002"];
    
    }else
    {
        [MobClick event:@"m09_u003_0002"];
    
    }


}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [verificationText resignFirstResponder];
    [confirmText resignFirstResponder];
    [passWordText resignFirstResponder];
    return YES;
    
}

-(void)getSMSCodeAgain:(id)sender
{
    [MobClick event:@"m09_u001_0003"];

     if (![ShareApp connectedToNetwork]) {
         
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"联网失败,请稍后再试"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }else{

        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startASetNumber:) userInfo:nil repeats:YES];
        currentTime = 60;
        regainbutton.userInteractionEnabled = NO;
    
        NSString * baseUrl = [NSString stringWithFormat:REGAIN,mobilNumber]; 
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        HTTPRequest *request = [[HTTPRequest alloc] init];
        request.forwordFlag = 102;
        self.again_request = request;
        self.again_request.m_delegate = self;
        self.again_request.hasTimeOut = YES;
        [request release];
    
        [self.again_request requestByUrlByGet: baseUrl];
    }
}

#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    currentTime = 60;
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, -2.0f, 320.0f, 49.0f);
    [self.navigationController.navigationBar addSubview:topImageView];    
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0f, 7.0f, 50.0f, 30.0f);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returRegisteredView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    UIImageView * lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    lineImageView.frame = CGRectMake(2.0f, 40.0f, 290.0f, 3.0f);
    
    UIImageView * secondLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    secondLineImageView.frame = CGRectMake(2.0f, 80.0f, 290.0f, 3.0f);
    
    UIImageView * threeLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u125_line.png"]];
    threeLineImageView.frame = CGRectMake(80.0f, 2.0f, 3.0f, 118.0f);
    
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
    
    UIView *informationView =[[UIView alloc] initWithFrame: CGRectMake(10.0, 20.0, 294.0f, 121.0f)];
    informationView.backgroundColor=[UIColor whiteColor];
    [[informationView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[informationView layer] setShadowRadius:5];
    [[informationView layer] setShadowOpacity:1];
    [[informationView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[informationView layer] setCornerRadius:7];
    [[informationView layer] setBorderWidth:1];
    [[informationView layer] setBorderColor:[UIColor grayColor].CGColor];
    
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
        firstLable.textAlignment = NSTextAlignmentCenter;
        firstLable.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [informationView addSubview:firstLable];
        [firstLable release];
    }
    
    [informationView addSubview:confirmText];
    [informationView addSubview:passWordText];
    [informationView addSubview:verificationText];
    [informationView addSubview:threeLineImageView];
    [informationView addSubview:secondLineImageView];
    [informationView addSubview:lineImageView];
    [self.view addSubview:informationView];
    
    [informationView release];
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
    [super viewDidDisappear:animated];
    topImageView.hidden = YES;
    returnButton.hidden = YES;

}
-(void)dealloc
{
    if (comRequest_request) {
        
        [self.comRequest_request closeConnection];
        self.comRequest_request.m_delegate=nil;
        self.comRequest_request=nil;
    }
    
    if (again_request) {
        
        [self.again_request closeConnection];
        self.again_request.m_delegate=nil;
        self.again_request=nil;
    }
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
