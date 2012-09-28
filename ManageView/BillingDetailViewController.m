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
@interface BillingDetailViewController ()

@end

@implementation BillingDetailViewController
@synthesize enioyCardLable,giftCardLable,discountLable,diidyWalletLable,couponLable,feesReceivableLable,implementationFeesLable;
@synthesize orderID;
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
    NSString * baseUrl = [NSString stringWithFormat:BILLINGDETAIL,orderID];
    NSLog(@"%@",baseUrl);
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:baseUrl];
    billRequest = [ASIHTTPRequest requestWithURL:url];
    [billRequest setDelegate:self];
    [billRequest setTag:102];
    [billRequest startAsynchronous];
}

-(void)parseStringJson:(NSString *)str
{
    
    NSDictionary * jsonParser =[str JSONValue];
    self.couponLable.text = [jsonParser objectForKey:@"account_coupon"];
    self.enioyCardLable.text =  [jsonParser objectForKey:@"account_discount"];
    self.giftCardLable.text= [jsonParser objectForKey:@"account_giftcard"];
    //NSString* account_money= [jsonParser objectForKey:@"account_money"];
    self.diidyWalletLable.text= [jsonParser objectForKey:@"account_mywallet"];
    self.discountLable.text =[jsonParser objectForKey:@"discount"];
    self.feesReceivableLable.text = [jsonParser objectForKey:@"receivable"];
    self.implementationFeesLable.text= [jsonParser objectForKey:@"received"];
          
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    billRequest = nil;
    [self parseStringJson:[request responseString]];
}
-(void)setTheNavigationBar
{
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0, 5.0, 55.0, 35.0);
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    [self setTheNavigationBar]; 
    [self downLoadTheOrderDetail];
}
-(void)viewWillDisappear:(BOOL)animated
{
    if (billRequest) {
        [billRequest clearDelegatesAndCancel];
        [billRequest release];
    }
    

}
-(void)viewDidDisappear:(BOOL)animated
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
