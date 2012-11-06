//
//  BillingDetailViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BillingDetailViewController.h"
#import "SBJson.h"
#import "CONST.h"
#import "JSONKit.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
@interface BillingDetailViewController ()

@end

@implementation BillingDetailViewController
@synthesize enioyCardLable,giftCardLable,discountLable,diidyWalletLable,couponLable,feesReceivableLable,implementationFeesLable;
@synthesize orderID,bill_request,HUD;
@synthesize billInforView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma HTTPdownLoad
-(void)downLoadTheOrderDetail
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

        NSString * baseUrl = [NSString stringWithFormat:BILLINGDETAIL,orderID];
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.delegate=self;
        HUD.labelText=@"Loading";
        HUD.detailsLabelText=@"获取结算信息...";
        HUD.square=YES;
        [HUD show:YES];
    
    
        HTTPRequest *request = [[HTTPRequest alloc] init];
        self.bill_request = request;
        self.bill_request.m_delegate = self;
        self.bill_request.hasTimeOut = YES;
        [request release];
    
        [self.bill_request requestByUrlByGet: baseUrl];
    }
    
}

-(void)parseStringJson:(NSString *)str
{
   
    if (self.HUD){
        
        [HUD removeFromSuperview];
        [HUD release];
         HUD = nil;
    }

  
    NSDictionary * jsonParser =[str objectFromJSONString];
    self.couponLable.text = [jsonParser objectForKey:@"account_coupon"];
    self.enioyCardLable.text =  [jsonParser objectForKey:@"account_discount"];
    self.giftCardLable.text= [jsonParser objectForKey:@"account_giftcard"];
    //NSString* account_money= [jsonParser objectForKey:@"account_money"];
    self.diidyWalletLable.text= [jsonParser objectForKey:@"account_mywallet"];
    self.discountLable.text =[jsonParser objectForKey:@"discount"];
    self.feesReceivableLable.text = [jsonParser objectForKey:@"receivable"];
    self.implementationFeesLable.text= [jsonParser objectForKey:@"received"];
          
}


-(void)requFinish:(NSString *)requestString order:(int)nOrder
{
    if ([requestString length]==0) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
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
    [self.HUD removeFromSuperview];
    [self.HUD release];
    self.HUD = nil;
    
}

#pragma mark-setBar
-(void)setTheNavigationBar
{
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0, 7.0, 50.0, 30.0);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnOrderDetailView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"结 算 明 细";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
}

-(void)returnOrderDetailView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - System Approach
-(void)setBillView
{

    self.billInforView.backgroundColor=[UIColor whiteColor];
    [[self.billInforView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[self.billInforView layer] setShadowRadius:5];
    [[self.billInforView layer] setShadowOpacity:1];
    [[self.billInforView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[self.billInforView layer] setCornerRadius:7];
    [[self.billInforView layer] setBorderWidth:1];
    [[self.billInforView layer] setBorderColor:[UIColor grayColor].CGColor];

    [self.view sendSubviewToBack:self.billInforView];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    [self setTheNavigationBar];
    
    self.feesReceivableLable.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.couponLable.textColor=[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.enioyCardLable.textColor =[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.giftCardLable.textColor =[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.diidyWalletLable.textColor =[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.discountLable.textColor =[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.implementationFeesLable.textColor =[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    
    [self downLoadTheOrderDetail];
    [self setBillView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    centerLable.hidden = YES;
}

-(void)dealloc
{
    [centerLable release];
    [topImageView release];
    [orderID release];
    [enioyCardLable release];
    [giftCardLable release];
    [discountLable release];
    [diidyWalletLable release];
    [couponLable release];
    [feesReceivableLable release];
    [implementationFeesLable release];
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
