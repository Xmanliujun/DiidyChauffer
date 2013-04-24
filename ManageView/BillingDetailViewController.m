//
//  BillingDetailViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BillingDetailViewController.h"
#import "CONST.h"
#import "JSONKit.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
@interface BillingDetailViewController ()

@end

@implementation BillingDetailViewController
@synthesize enioyCardString,giftCardString,discountString,diidyWalletString,couponString,feesReceivablString, implementationFeesString;
@synthesize orderID,bill_request;

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
    
    if (![ShareApp connectedToNetwork]) {
        
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
   
    if (HUD){
        
        [HUD removeFromSuperview];
        [HUD release];
         HUD = nil;
    }

  
    NSDictionary * jsonParser =[str objectFromJSONString];
    self.couponString = [jsonParser objectForKey:@"account_coupon"];
    self.enioyCardString =  [jsonParser objectForKey:@"account_discount"];
    self.giftCardString= [jsonParser objectForKey:@"account_giftcard"];
    //NSString* account_money= [jsonParser objectForKey:@"account_money"];
    self.diidyWalletString= [jsonParser objectForKey:@"account_mywallet"];
    self.discountString=[jsonParser objectForKey:@"discount"];
    self.feesReceivablString = [jsonParser objectForKey:@"receivable"];
    self.implementationFeesString= [jsonParser objectForKey:@"received"];
    [orderTableView reloadData];
          
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
    [HUD removeFromSuperview];
    [HUD release];
    HUD = nil;
    
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
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
}

-(void)returnOrderDetailView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - System Approach

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    [self setTheNavigationBar];

    orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f) style:UITableViewStyleGrouped];
    orderTableView.backgroundColor = [UIColor clearColor];
    orderTableView.scrollEnabled = NO;
    orderTableView.backgroundView=nil;
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    [self.view addSubview:orderTableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

        return 1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[[UIView alloc] init] autorelease];
    myView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, 22)];
    titleLabel.textColor=[UIColor orangeColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    if (section==0)
        
        titleLabel.text = @"结算明细";
        
    [myView addSubview:titleLabel];
    [titleLabel release];
    return myView;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    

        
        return @"结算明细";
        
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
      return 44;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"cellID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID] autorelease];
        [cell setSelectionStyle:UITableViewCellEditingStyleNone];
        cell.backgroundColor = [UIColor whiteColor];
        
        UILabel*  markLable = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 80.0f, 44.0f)];
        markLable.font = [UIFont systemFontOfSize:14];
        markLable.textColor = [UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1];
        markLable.tag =60;
        markLable.numberOfLines=0;
        markLable.backgroundColor = [UIColor clearColor];
        markLable.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:markLable];
        [markLable release];
        
        UILabel*  messageLable = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 0.0f, 230.0f, 44.0f)];
        messageLable.font = [UIFont systemFontOfSize:14];
        messageLable.numberOfLines = 0;
        messageLable.tag = 61;
        messageLable.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
        messageLable.backgroundColor = [UIColor clearColor];
        messageLable.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:messageLable];
        [messageLable release];
    }
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    UILabel*markLable =(UILabel*)[cell.contentView viewWithTag:60];
    UILabel*  messageLable =(UILabel*)[cell.contentView viewWithTag:61];
    
    
    if (indexPath.section==0&&indexPath.row==0) {
        
        markLable.text = @"应收费用:";
        messageLable.text = self.feesReceivablString;

      }else if (indexPath.section==0&&indexPath.row==1) {
          
        markLable.text = @"优惠劵:";
        messageLable.text = self.couponString;
    
    }else if (indexPath.section==0&&indexPath.row==2) {
        
        markLable.text = @"畅享卡:";
        messageLable.text = self.enioyCardString;
              
    }else if (indexPath.section==0&&indexPath.row==3) {
        
        markLable.text = @"礼品卡:";
        messageLable.text = self.giftCardString;
       
    }else if(indexPath.section==0&&indexPath.row==4)
    {
        markLable.text = @"嘀嘀钱包:";
        messageLable.text = self.diidyWalletString;
       
    }else if(indexPath.section==0&&indexPath.row==5){
        
        markLable.text = @"折扣:";
        messageLable.text = self.discountString;
    
    }else if(indexPath.section==0&&indexPath.row==6){
        
        markLable.text = @"实收费用:";
        messageLable.text =  self.implementationFeesString;
       
    }
    
    return cell;
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    centerLable.hidden = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self downLoadTheOrderDetail];

}
-(void)dealloc
{
    if (billRequest) {
        
        [self.bill_request closeConnection];
        self.bill_request.m_delegate=nil;
        self.bill_request=nil;
    }
    [orderTableView release];
    [centerLable release];
    [topImageView release];
    [orderID release];
    [enioyCardString release];
    [giftCardString release];
    [discountString release];
    [diidyWalletString release];
    [couponString release];
    [feesReceivablString release];
    [implementationFeesString release];
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
