//
//  OrdersPreviewTwoViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrdersPreviewTwoViewController.h"
#import "CONST.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "MainViewController.h"
#import "JSONKit.h"
#import "Reachability.h"
@interface OrdersPreviewTwoViewController ()

@end

@implementation OrdersPreviewTwoViewController

@synthesize departureLable,departureTimeLable,numberOfPeopleLable,destinationLable,contactLable,mobilNumberLable,orderArray;
@synthesize submit_request;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark-Button
-(void)returnFillOrderView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)submitOrders:(id)sender
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                   message:nil                                                 
                                                  delegate:self 
                                         cancelButtonTitle:@"取消" 
                                         otherButtonTitles:@"确认",nil];
    [alert show];
    [alert release];
    
}
#pragma mark-HttpDown
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
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

            if ([self.departureTimeLable.text isEqualToString:@""]) {
                self.departureTimeLable.text = @"无";
            }
        
            if ([self.departureLable.text isEqualToString:@""]) {
                self.departureLable.text =@"无";
            }
            if ([self.numberOfPeopleLable.text isEqualToString:@""]) {
                self.numberOfPeopleLable.text = @"无";
            }
            if ([self.contactLable.text isEqualToString:@""]) {
                self.contactLable.text = @"无";
            }
            if ([self.destinationLable.text isEqualToString:@""]) {
                self.destinationLable.text = @"无";
            }
            if ([self.mobilNumberLable.text isEqualToString:@""]) {
                self.mobilNumberLable.text = @"无";
            }
            if ([self.contactLable.text isEqualToString:@""]) {
                self.contactLable.text = @"无";
            }
        

            NSString * baseUrl = [NSString stringWithFormat:SUBMITORDERS,self.departureTimeLable.text,self.departureLable.text,self.numberOfPeopleLable.text,self.destinationLable.text,self.mobilNumberLable.text,self.contactLable.text,@"无",ShareApp.mobilNumber];
            baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
            HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.delegate=self;
            HUD.labelText=@"正在提交...";
            //HUD.detailsLabelText=@"正在加载...";
            HUD.square=YES;
            [HUD show:YES];
        
            HTTPRequest *request = [[HTTPRequest alloc] init];
            request.forwordFlag = 500;
            self.submit_request = request;
            self.submit_request.m_delegate = self;
            self.submit_request.hasTimeOut = YES;
            [request release];
            [self.submit_request requestByUrlByGet: baseUrl];

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
    if ([returenNews isEqualToString:@"s"]) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"提交成功"
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"确认",nil];
        [alert show];
        [alert release];
        
        MainViewController * main = [[MainViewController alloc] init];
        ShareApp.window.rootViewController = main;
        [main release];
        
        
    }else {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                       message:@"提交失败请重试"                                                 
                                                      delegate:nil
                                             cancelButtonTitle:nil 
                                             otherButtonTitles:@"确认",nil];
        [alert show];
        [alert release];
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

#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0, 7.0, 50.0, 30.0);
    [returnButton setTitle:@"返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnFillOrderView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rigthbutton.frame=CGRectMake(260.0f, 7.0f, 50.0f, 30.0f);
    [rigthbutton setTitle:@"提交订单" forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(submitOrders:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    self.departureLable.text =[self.orderArray objectAtIndex:0];//出发地
    self.departureTimeLable.text = [self.orderArray objectAtIndex:1];//出发时间
    self.numberOfPeopleLable.text =[self.orderArray objectAtIndex:2];//人数
    self.destinationLable.text = [self.orderArray objectAtIndex:3];//目的地
    self.contactLable.text = [self.orderArray objectAtIndex:4];//联系人
    self.mobilNumberLable.text = [self.orderArray objectAtIndex:5];//手机号码
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.font = [UIFont systemFontOfSize:17];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.text =@"订 单 预 览";
    [self.navigationController.navigationBar addSubview:centerLable];
    
    self.departureLable.numberOfLines = 0;
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;
    centerLable.hidden = YES;
}
-(void)dealloc
{
    [contactLable release];
    [centerLable release];
    [departureLable release];
    [departureTimeLable release];
    [destinationLable release];
    [orderArray release];
    [mobilNumberLable release];
    [numberOfPeopleLable  release]; 
    [topImageView release];
    [super dealloc];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
