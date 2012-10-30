//
//  FeedBackViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FeedBackViewController.h"
#import "AppDelegate.h"
#import "CONST.h"
#import "SBJson.h"
#import "JSONKit.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
@interface FeedBackViewController ()

@end

@implementation FeedBackViewController
@synthesize judge,feedBack_request;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)returnORSubmit:(UIButton*)sender
{

    if (sender.tag==201) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else {
        
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

            NSString * baseUrl = [NSString stringWithFormat:FEEDBACK,ShareApp.mobilNumber,feedBackText.text]; 
            baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.delegate=self;
            HUD.labelText=@"正在提交...";
            //HUD.detailsLabelText=@"正在加载...";
            HUD.square=YES;
            [HUD show:YES];
            
            HTTPRequest *request = [[HTTPRequest alloc] init];
            request.forwordFlag = 10;
            self.feedBack_request = request;
            self.feedBack_request.m_delegate = self;
            self.feedBack_request.hasTimeOut = YES;
            [request release];
            
            [self.feedBack_request requestByUrlByGet: baseUrl];
        }
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
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:returenNews,@"return", nil];
    if ([self.judge isEqualToString:@"more"]) {
        
         [[NSNotificationCenter defaultCenter] postNotificationName:MORE_QUEST object:self userInfo:dict];
        
    }else {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:REQUEST_COMPLETE object:self userInfo:dict];
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



-(void)creatNavigationBar
{
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthbutton.frame=CGRectMake(260.0f, 7.0f, 50.0f, 30.0f);
    rigthbutton.tag = 200;
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    [rigthbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rigthbutton setTitle:@"提交" forState:UIControlStateNormal];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(returnORSubmit:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.text = @"意见反馈";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0f];
    [self.navigationController.navigationBar addSubview:centerLable];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.tag = 201;
    returnButton.frame=CGRectMake(7.0f, 7.0f, 50.0f, 30.0f);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnORSubmit:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, -2.0f, 320.0f, 49.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    [self creatNavigationBar];
    
    UILabel * landingLable = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 10.0f, 300.0f, 30.0f)];
    landingLable.text = @"您的意见将帮助我们改进产品和服务";
    landingLable.backgroundColor = [UIColor clearColor];
    landingLable.textColor = [UIColor orangeColor];
    landingLable.font = [UIFont fontWithName:@"Arial" size:16.0f];
    [self.view addSubview:landingLable];
    [landingLable release];
    
    
    UIView *feedBackView =[[UIView alloc] initWithFrame: CGRectMake(6.0f, 40.f, 308.0f, 120.0f)];

    feedBackView.backgroundColor=[UIColor whiteColor];
    [[feedBackView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[feedBackView layer] setShadowRadius:5];
    [[feedBackView layer] setShadowOpacity:1];
    [[feedBackView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[feedBackView layer] setCornerRadius:7];
    [[feedBackView layer] setBorderWidth:1];
    [[feedBackView layer] setBorderColor:[UIColor grayColor].CGColor];
    [self.view addSubview:feedBackView];
    [feedBackView release];
    
    feedBackText = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 44.0f, 300.0f, 110.0f)];
    feedBackText.textColor = [UIColor blackColor];
    feedBackText.text = @"提几句建议吧。。。";
    [feedBackText becomeFirstResponder];
    feedBackText.returnKeyType = UIReturnKeyDefault;
    feedBackText.font = [UIFont fontWithName:@"Arial" size:14.0f];
    feedBackText.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:feedBackText];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    topImageView.hidden = YES;
    centerLable.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;

}
-(void)dealloc
{
    [centerLable release];
    [feedBackText release];
    [judge release];
    [topImageView release];
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
