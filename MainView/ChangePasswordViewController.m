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
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"修改密码";
    
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"u13_normal.png"] forState:UIControlStateNormal];
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    leftbutton.frame=RECTMAKE(0.0, 100.0, 70.0, 35.0);    
    [leftbutton addTarget:self action:@selector(returMoreViewView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];
    
    
    UIButton *rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"u927_normal.png"] forState:UIControlStateNormal];
    [rigthbutton setTitle:@"保存" forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rigthbutton.frame=CGRectMake(0.0, 100.0, 65.0, 34.0);
    [rigthbutton addTarget:self action:@selector(saveNewPassWord:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];

    UIImageView * lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    lineImageView.frame = CGRectMake(4.0, 40.0, 290.0, 3.0);
    
    UIImageView * secondLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    secondLineImageView.frame = CGRectMake(4.0, 80.0, 290.0, 3.0);
    
    UIImageView * threeLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u125_line.png"]];
    threeLineImageView.frame = CGRectMake(80.0, 4.0, 3.0, 115.0);
    
    oldPasswordText = [[UITextField alloc] initWithFrame:CGRectMake(85.0, 5.0, 160,35.0)];
    oldPasswordText.backgroundColor = [UIColor clearColor];
    oldPasswordText.keyboardType = UIKeyboardTypeDefault;
    oldPasswordText.font = [UIFont fontWithName:@"Arial" size:15.0];
    oldPasswordText.borderStyle = UITextBorderStyleNone;
    oldPasswordText.autocorrectionType = UITextAutocorrectionTypeYes;
    oldPasswordText.placeholder = @"4-30位数字和字母";
    oldPasswordText.returnKeyType = UIReturnKeyDone;
    oldPasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    oldPasswordText.delegate = self;
    
    newPassWordText = [[UITextField alloc] initWithFrame:CGRectMake(85.0, 45.0, 160.0,35.0)];
    newPassWordText.backgroundColor = [UIColor clearColor];
    newPassWordText.keyboardType = UIKeyboardTypeDefault;
    newPassWordText.font = [UIFont fontWithName:@"Arial" size:15.0];
    newPassWordText.borderStyle = UITextBorderStyleNone;
    newPassWordText.autocorrectionType = UITextAutocorrectionTypeYes;
    newPassWordText.placeholder = @"4-30位数字和字母";
    newPassWordText.returnKeyType = UIReturnKeyDone;
    newPassWordText.secureTextEntry = YES;
    newPassWordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    newPassWordText.delegate = self;
    
    confirmPassWordText = [[UITextField alloc] initWithFrame:CGRectMake(85.0, 85.0, 160.0,35.0)];
    confirmPassWordText.backgroundColor = [UIColor clearColor];
    confirmPassWordText.keyboardType = UIKeyboardTypeDefault;
    confirmPassWordText.font = [UIFont fontWithName:@"Arial" size:15.0];
    confirmPassWordText.borderStyle = UITextBorderStyleNone;
    confirmPassWordText.autocorrectionType = UITextAutocorrectionTypeYes;
    confirmPassWordText.placeholder = @"请重复一遍密码";
    confirmPassWordText.returnKeyType = UIReturnKeyDone;
    confirmPassWordText.secureTextEntry = YES;
    confirmPassWordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    confirmPassWordText.delegate = self;
    
    UIImage * informationImage = [UIImage imageNamed:@"u90_normal.png"];
    UIImageView * informationImageView = [[UIImageView alloc] initWithImage:informationImage];
    informationImageView.frame = CGRectMake(10.0, 20.0, informationImage.size.width, informationImage.size.height);
    informationImageView.userInteractionEnabled = YES;
    
    
    NSArray * lableBArray = [NSArray arrayWithObjects:@"旧密码",@"新密码",@"确认密码", nil];
    
    for(int i = 0;i<3;i++){
        UILabel * firstLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*i, 80.0, 40.0)];
        
        firstLable.text = [lableBArray objectAtIndex:i];
        
        firstLable.backgroundColor = [UIColor clearColor];
        firstLable.textAlignment = UITextAlignmentCenter;
        firstLable.font = [UIFont fontWithName:@"Arial" size:14.0];
        [informationImageView addSubview:firstLable];
        [firstLable release];
    }
    [informationImageView addSubview:confirmPassWordText];
    [informationImageView addSubview:oldPasswordText];
    [informationImageView addSubview:newPassWordText];    
    [informationImageView addSubview:threeLineImageView];
    [informationImageView addSubview:secondLineImageView];
    [informationImageView addSubview:lineImageView];
    [self.view addSubview:informationImageView];
    [informationImageView release];

}

-(void)returMoreViewView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)saveNewPassWord:(id)sender
{
    if ([newPassWordText.text isEqualToString:confirmPassWordText.text]&&![newPassWordText.text isEqualToString:@""]) {
        NSString * baseUrl = [NSString stringWithFormat:CHANGEPASSWORD,ShareApp.mobilNumber,[oldPasswordText.text MD5Hash],[newPassWordText.text MD5Hash]]; 
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * url = [NSURL URLWithString:baseUrl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        NSLog(@"%@",url);
        [request setDelegate:self];
        [request startSynchronous];
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

-(void)parseStringJson:(NSString *)str
{

    
    NSDictionary * jsonParser =[str JSONValue];
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

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self parseStringJson:[request responseString]];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    MoreViewController * more = [[MoreViewController alloc] init];
    [self.navigationController pushViewController:more animated:YES];
    [more release];
    
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
