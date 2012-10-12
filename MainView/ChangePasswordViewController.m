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

#pragma mark-Button
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
#pragma mark-Http
-(void)parseStringJson:(NSString *)str
{
//  NSDictionary * jsonParser =[str JSONValue];
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
#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;   
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0f, 5.0f, 55.0f, 35.0f);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returMoreViewView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [rigthbutton setTitle:@"保存" forState:UIControlStateNormal];
    rigthbutton.frame=CGRectMake(260.0f, 5.0f, 55.0f, 35.0f);
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
    lineImageView.frame = CGRectMake(4.0f, 40.0f, 290.0f, 3.0f);
    
    UIImageView * secondLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    secondLineImageView.frame = CGRectMake(4.0f, 80.0f, 290.0f, 3.0f);
    
    UIImageView * threeLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u125_line.png"]];
    threeLineImageView.frame = CGRectMake(80.0f, 4.0f, 3.0f, 115.0f);
    
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
    
    UIImage * informationImage = [UIImage imageNamed:@"u90_normal.png"];
    UIImageView * informationImageView = [[UIImageView alloc] initWithImage:informationImage];
    informationImageView.frame = CGRectMake(10.0, 20.0, informationImage.size.width, informationImage.size.height);
    informationImageView.userInteractionEnabled = YES;
    
    
    NSArray * lableBArray = [NSArray arrayWithObjects:@"旧密码",@"新密码",@"确认密码", nil];
    
    for(int i = 0;i<3;i++){
        UILabel * firstLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 40.0f*i, 80.0f, 40.0f)];
        
        firstLable.text = [lableBArray objectAtIndex:i];
        
        firstLable.backgroundColor = [UIColor clearColor];
        firstLable.textAlignment = UITextAlignmentCenter;
        firstLable.font = [UIFont fontWithName:@"Arial" size:14.0f];
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
    [lineImageView release];
    [secondLineImageView release];
    [threeLineImageView release];
}

-(void)viewWillDisappear:(BOOL)animated
{
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
