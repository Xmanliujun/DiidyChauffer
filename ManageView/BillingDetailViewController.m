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
-(void)downLoadTheOrderDetail
{
    NSString * baseUrl = [NSString stringWithFormat:BILLINGDETAIL,orderID];
    NSLog(@"%@",baseUrl);
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:baseUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setTag:102];
    [request startAsynchronous];
    

}

-(void)parseStringJson:(NSString *)str
{
    
    NSDictionary * jsonParser =[str JSONValue];
    NSLog(@"%@",jsonParser);
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
    
    [self parseStringJson:[request responseString]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.hidesBackButton = YES;
      self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    self.title = @"结算明细";
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"u13_normal.png"] forState:UIControlStateNormal];
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    leftbutton.frame=CGRectMake(10.0, 4.0, 70.0, 35.0);
    [leftbutton addTarget:self action:@selector(returnOrderDetailView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];
    
    [self downLoadTheOrderDetail];
}
-(void)returnOrderDetailView:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)dealloc
{
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
