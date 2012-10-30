//
//  ChangePasswordViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "CONST.h"
#import "NSString+Hashing.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "MoreViewController.h"
#import "JSONKit.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
@synthesize changePassword_request;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark-Button
-(void)returMoreViewView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)saveNewPassWord:(id)sender
{
    
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

        if (newPassWordText.text==NULL||[newPassWordText.text length]==0||confirmPassWordText.text==NULL||[confirmPassWordText.text length]==0) {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                           message:@"密码不能为空"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确认"
                                                 otherButtonTitles:nil ];
            [alert show];
            [alert release];
        }else{
            if ([newPassWordText.text isEqualToString:confirmPassWordText.text]) {
            
                if (oldPasswordText.text==NULL||[oldPasswordText.text length]==0) {
                
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                               message:@"旧密码不能为空"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确认"
                                                     otherButtonTitles:nil ];
                    [alert show];
                    [alert release];
                
                }else{
                
                    NSString * baseUrl = [NSString stringWithFormat:CHANGEPASSWORD,ShareApp.mobilNumber,[oldPasswordText.text MD5Hash],[newPassWordText.text MD5Hash]]; 
                    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
                    HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
                    [self.navigationController.view addSubview:HUD];
                    HUD.delegate=self;
                    HUD.labelText=@"正在修改...";
                    //HUD.detailsLabelText=@"正在加载...";
                    HUD.square=YES;
                    [HUD show:YES];

                    HTTPRequest *request = [[HTTPRequest alloc] init];
                    request.forwordFlag = 500;
                    self.changePassword_request = request;
                    self.changePassword_request.m_delegate = self;
                    self.changePassword_request.hasTimeOut = YES;
                    [request release];
                    [self.changePassword_request requestByUrlByGet: baseUrl];
                }

            }else {
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                           message:@"您输入的两次密码不一致哦，再试试看"
                                                          delegate:nil 
                                                 cancelButtonTitle:@"确认" 
                                                 otherButtonTitles:nil ];
                [alert show];
                [alert release];

            }
        }
    }
}
#pragma mark-Http
-(void)parseStringJson:(NSString *)str
{
   
    if (HUD){
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }
    
    NSDictionary * jsonParser =[str objectFromJSONString];
    NSString * returenNews =[jsonParser objectForKey:@"r"];
    
    if([returenNews isEqualToString:@"s"])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil 
                                                       message:@"您的密码修改成功"
                                                      delegate:self 
                                             cancelButtonTitle:@"确认" 
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];
    }else if([returenNews isEqualToString:@"f"]){
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil 
                                                       message:@"密码修改失败,请重试"
                                                      delegate:nil 
                                             cancelButtonTitle:@"确认" 
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];

    }else if([returenNews isEqualToString:@"pwderror"]){
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil 
                                                       message:@"您的旧密码有误,请重试"
                                                      delegate:nil 
                                             cancelButtonTitle:@"确认" 
                                             otherButtonTitles:nil ];
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
        
        [self parseStringJson:requestString];
              
    }

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



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    MoreViewController * more = [[MoreViewController alloc] init];
    [self.navigationController pushViewController:more animated:YES];
    [more release];
    
}
#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;   
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, -2.0f, 320.0f, 49.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0f, 7.0f, 50.0f, 30.0f);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returMoreViewView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    [rigthbutton setTitle:@"完成" forState:UIControlStateNormal];
    rigthbutton.frame=CGRectMake(260.0f, 7.0f, 50.0f, 30.0f);
    [rigthbutton addTarget:self action:@selector(saveNewPassWord:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.font = [UIFont systemFontOfSize:17.0f];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.text =@"修 改 密 码";
    [self.navigationController.navigationBar addSubview:centerLable];
       
    UIImageView * lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    lineImageView.frame = CGRectMake(2.0f, 40.0f, 290.0f, 3.0f);
    
    UIImageView * secondLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    secondLineImageView.frame = CGRectMake(2.0f, 80.0f, 290.0f, 3.0f);
    
    UIImageView * threeLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u125_line.png"]];
    threeLineImageView.frame = CGRectMake(80.0f, 2.0f, 3.0f, 118.0f);
    
    oldPasswordText = [[UITextField alloc] initWithFrame:CGRectMake(85.0f, 5.0f, 160.0f,35.0f)];
    oldPasswordText.backgroundColor = [UIColor clearColor];
    oldPasswordText.keyboardType = UIKeyboardTypeDefault;
    oldPasswordText.font = [UIFont fontWithName:@"Arial" size:15.0f];
    oldPasswordText.borderStyle = UITextBorderStyleNone;
    oldPasswordText.autocorrectionType = UITextAutocorrectionTypeYes;
    oldPasswordText.placeholder = @"4-30位数字和字母";
    oldPasswordText.returnKeyType = UIReturnKeyDone;
    oldPasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    oldPasswordText.delegate = self;
    
    newPassWordText = [[UITextField alloc] initWithFrame:CGRectMake(85.0f, 45.0f, 160.0f,35.0f)];
    newPassWordText.backgroundColor = [UIColor clearColor];
    newPassWordText.keyboardType = UIKeyboardTypeDefault;
    newPassWordText.font = [UIFont fontWithName:@"Arial" size:15.0f];
    newPassWordText.borderStyle = UITextBorderStyleNone;
    newPassWordText.autocorrectionType = UITextAutocorrectionTypeYes;
    newPassWordText.placeholder = @"4-30位数字和字母";
    newPassWordText.returnKeyType = UIReturnKeyDone;
    newPassWordText.secureTextEntry = YES;
    newPassWordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    newPassWordText.delegate = self;
    
    confirmPassWordText = [[UITextField alloc] initWithFrame:CGRectMake(85.0f, 85.0f, 160.0f,35.0f)];
    confirmPassWordText.backgroundColor = [UIColor clearColor];
    confirmPassWordText.keyboardType = UIKeyboardTypeDefault;
    confirmPassWordText.font = [UIFont fontWithName:@"Arial" size:15.0f];
    confirmPassWordText.borderStyle = UITextBorderStyleNone;
    confirmPassWordText.autocorrectionType = UITextAutocorrectionTypeYes;
    confirmPassWordText.placeholder = @"请重复一遍密码";
    confirmPassWordText.returnKeyType = UIReturnKeyDone;
    confirmPassWordText.secureTextEntry = YES;
    confirmPassWordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    confirmPassWordText.delegate = self;
    
       
    UIView *changePasswordView =[[UIView alloc] initWithFrame: CGRectMake(10.0, 20.0, 294.0f, 121.0f)];
    changePasswordView.backgroundColor=[UIColor whiteColor];
    [[changePasswordView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[changePasswordView layer] setShadowRadius:5];
    [[changePasswordView layer] setShadowOpacity:1];
    [[changePasswordView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[changePasswordView layer] setCornerRadius:7];
    [[changePasswordView layer] setBorderWidth:1];
    [[changePasswordView layer] setBorderColor:[UIColor grayColor].CGColor];
        
    
    NSArray * lableBArray = [NSArray arrayWithObjects:@"旧密码",@"新密码",@"确认密码", nil];
    
    for(int i = 0;i<3;i++){
        UILabel * firstLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 40.0f*i, 80.0f, 40.0f)];
        
        firstLable.text = [lableBArray objectAtIndex:i];
        
        firstLable.backgroundColor = [UIColor clearColor];
        firstLable.textAlignment = UITextAlignmentCenter;
        firstLable.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [changePasswordView addSubview:firstLable];
        [firstLable release];
    }
    
    [changePasswordView addSubview:confirmPassWordText];
    [changePasswordView addSubview:oldPasswordText];
    [changePasswordView addSubview:newPassWordText];
    [changePasswordView addSubview:threeLineImageView];
    [changePasswordView addSubview:secondLineImageView];
    [changePasswordView addSubview:lineImageView];
    [self.view addSubview:changePasswordView];
   
    [changePasswordView release];
    [lineImageView release];
    [secondLineImageView release];
    [threeLineImageView release];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;
    centerLable.hidden = YES;
    
}
-(void)dealloc
{
    [centerLable release];
    [topImageView release];
    [oldPasswordText release];
    [newPassWordText release];
    [confirmPassWordText release];
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
