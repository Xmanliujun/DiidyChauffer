//
//  ManageMentViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ManageMentViewController.h"
#import "OrderDetailsViewController.h"
#import "CONST.h"
#import "SBJson.h"
#import "AppDelegate.h"
#import "DIIdyModel.h"
#import "ManageTableViewCell.h"
#import "QFDatabase.h"
#import "JSONKit.h"
#import "Reachability.h"

@interface ManageMentViewController ()

@end

@implementation ManageMentViewController
@synthesize HUD,m_request;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - Self Call
-(void)setTheNavigationBar
{
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, -2.0f, 320.0f, 49.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0f, 7.0f, 50.0f, 30.0f);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"订 单 列 表";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
    
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    rigthbutton.frame=CGRectMake(260.0f, 7.0f, 50.0f, 30.0f);
    [rigthbutton setTitle:@"刷新" forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(refreshStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
}

-(void)creatNOOrdersView
{
    
    UIImage * noOrderImage = [UIImage imageNamed:@"u145_normal.png"];
    UIImageView* noOrderImageView = [[UIImageView alloc] initWithImage:noOrderImage];
    noOrderImageView.frame = CGRectMake(20, 20, noOrderImage.size.width, noOrderImage.size.height);
    
    UILabel * noOrderLable = [[UILabel alloc] initWithFrame:CGRectMake(35.0, 35.0, noOrderImage.size.width -30.0, noOrderImage.size.height -30.0)];
    noOrderLable.text =ORDERPROMPT;
    noOrderLable.textColor = [UIColor orangeColor];
    noOrderLable.backgroundColor = [UIColor clearColor];
    noOrderLable.font = [UIFont fontWithName:@"Arial" size:16.0];
    noOrderLable.lineBreakMode = UILineBreakModeWordWrap;
    noOrderLable.numberOfLines = 0;
    
    [self.view addSubview:noOrderLable];
    [self.view addSubview:noOrderImageView];
    
    [noOrderImageView release];
    [noOrderLable release];
    
}


-(void)creatHaveOrderView
{
    CGRect rect;
    
    if (100*[listOrderArray count]>400) {
        
        rect =self.view.bounds;
        
    }else {
        
        rect = CGRectMake(0.0, 0.0, 320.0, 100*[listOrderArray count]);
        
    }
    
    UITableView * orderTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    orderTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    //orderTableView.backgroundColor = [UIColor whiteColor];
    orderTableView.backgroundView=nil;
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    
    if (100*[listOrderArray count]>400) {
        
        orderTableView.scrollEnabled = YES;
        
    }else {
        
        orderTableView.scrollEnabled = NO;
    }

    orderTableView.separatorColor = [UIColor colorWithRed:182.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1];
    
    [self.view addSubview:orderTableView];
    [orderTableView release];
    
}
#pragma mark-button
-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
    
}
-(void)refreshStep:(id)sender
{
    Reachability * r =[Reachability reachabilityWithHostName:@"www.apple.com"];
    
    if ([r currentReachabilityStatus]==0) {
        
    }else{
        [self goToTheDownLoadPage];
    }
    

    
}
#pragma mark-HTTPDown

-(void)requFinish:(NSString *)requestString order:(int)nOrder{
    
    NSLog(@"%@",requestString);
    
    if ([requestString length]==0) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"请检查网络是否连接"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];
        
    }else{
        
        [self  parseStringJson:requestString];
        
    }
    
    
}

-(void)showWithDetails{
    
    self.HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"Loading";
    HUD.detailsLabelText=@"获取订单信息...";
    HUD.square=YES;
    [HUD show:YES];
    
    HTTPRequest *request = [[HTTPRequest alloc] init];
    self.m_request = request;
    self.m_request.m_delegate = self;
    self.m_request.hasTimeOut = YES;
    [request release];
    
    [self.m_request requestByUrlByGet: baseUrl];
}
-(void)requesttimeout
{
    
    [self closeConnection];
    
}

-(void)goToTheDownLoadPage
{
    NSArray * sqlitArray = [ShareApp.mDatabase readDataWithFMDB];
    
    if (listOrderArray) {
        [listOrderArray removeAllObjects];
    }else
    {
        listOrderArray = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    
    if (sqlitArray.count!=0) {
        
        sqlitBool = YES;
        DIIdyModel*diiModel = [sqlitArray objectAtIndex:0];
        
        if (diiModel.startTime ==NULL||[diiModel.startTime length]==0) {
            
            baseUrl = [NSString stringWithFormat:ORDERNUMBER,ShareApp.mobilNumber];
            
        }else {
            
            baseUrl = [NSString stringWithFormat:ORDERNUMBERSTARTTIME,ShareApp.mobilNumber,diiModel.startTime];
        
        }
        
        if (!(diiModel.orderID==NULL||[diiModel.orderID length]==0)) {
            
            baseUrl = [baseUrl stringByAppendingFormat:@"/%@",diiModel.orderID];
            
        }
        for (int i = 0; i<sqlitArray.count; i++) {
            
            DIIdyModel * item = [sqlitArray objectAtIndex:i];
            item.orderID=item.orderID?item.orderID:@"";
            item.startTime=item.startTime?item.startTime:@"";
            item.startAddr=item.startAddr?item.startAddr:@"";
            item.endAddr=item.endAddr?item.endAddr:@"";
            item.ordersNumber=item.ordersNumber?item.ordersNumber:@"";
            item.contactName=item.contactName?item.contactName:@"";
            item.contactMobile=item.contactMobile?item.contactMobile:@"";
            item.createTime=item.createTime?item.createTime:@"";
            item.coupon = item.coupon?item.coupon:@"";
            item.status= item.status?item.status:@"";
            [listOrderArray addObject:item];
            
        }
        
    }else {
        
        sqlitBool = NO;
        baseUrl = [NSString stringWithFormat:ORDERNUMBER,ShareApp.mobilNumber];
        
    }
    
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Reachability * r =[Reachability reachabilityWithHostName:@"www.apple.com"];
    
    if ([r currentReachabilityStatus]==0) {
        
    }else{
        
        [self showWithDetails];
    }
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [self.HUD removeFromSuperview];
    [self.HUD release];
     self.HUD = nil;
    
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


-(void)parseStringJson:(NSString *)str
{
    
    if (HUD){
        
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }

    NSArray* jsonParser =[str objectFromJSONString];
    
    int a;
    
    if (sqlitBool) {
        
        a=1;
        
    }else {
        
        a=0;
        
    }
    
    for(int i=0 ;i<[jsonParser count]-a;i++){
        
        DIIdyModel * diidy = [[DIIdyModel alloc] init];
        NSDictionary * diidyDict = [jsonParser objectAtIndex:i];
        diidy.orderID = [diidyDict objectForKey:@"orderid"];
        diidy.startTime = [diidyDict objectForKey:@"starttime"];
        diidy.startAddr = [diidyDict objectForKey:@"startaddr"];
        diidy.endAddr = [diidyDict objectForKey:@"endaddr"];
        diidy.ordersNumber = [diidyDict objectForKey:@"number"];
        diidy.contactName = [diidyDict objectForKey:@"contactname"];
        diidy.contactMobile = [diidyDict objectForKey:@"contactmobile"];
        diidy.createTime = [diidyDict objectForKey:@"createtime"];
        diidy.coupon = [diidyDict objectForKey:@"coupon"];
        NSString* currentStatus = [diidyDict objectForKey:@"status"];
        
        if([currentStatus floatValue]>=1.0&&[currentStatus floatValue]<=4.0){
            
            diidy.status = @"已受理";
            
        }else if ([currentStatus floatValue]==5.0) {
            
            diidy.status = @"完成";
            
        }else {
            
            diidy.status = @"已取消";
            
        }
       
            
        [ShareApp.mDatabase insertItemWithFMDB:diidy];
            

       if (a==0) {
            
            [listOrderArray addObject:diidy];
            
        }else{
            
            [listOrderArray insertObject:diidy atIndex:0];
        }
            [diidy release];
        
    }
       if(([jsonParser count])==0){
           
         [self creatNOOrdersView];
           
    }else {
        
         [self creatHaveOrderView];
        
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [listOrderArray count];    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"cellID";
    
    ManageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell ==nil)
    {
        cell = [[[ManageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    DIIdyModel * diidy = [listOrderArray objectAtIndex:indexPath.row];
    
    if ([diidy.status isEqualToString:@"已受理"]) {
        
        cell.statusLable.textColor = [UIColor orangeColor];
        cell.statusLable.text = [NSString stringWithFormat:@"%@>",diidy.status];
        
    }else if([diidy.status isEqualToString:@"完成"]){
        
        cell.statusLable.textColor = [UIColor greenColor];
        cell.statusLable.text = [NSString stringWithFormat:@"已%@>",diidy.status];
        
    }else {
        
        cell.statusLable.textColor = [UIColor grayColor];
        cell.statusLable.text = [NSString stringWithFormat:@"%@>",diidy.status];
        
    }
   
    cell.orderNumberLable.text = diidy.orderID;
    cell.startTimeLable.text = diidy.startTime;
    cell.departureLable.text =diidy.startAddr;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailsViewController * orderDetail = [[OrderDetailsViewController alloc] init];
    orderDetail.diidyModel = [listOrderArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:orderDetail animated:YES];
    [orderDetail release];
}

#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
   
    sqlitBool = YES;
    listOrderArray = [[NSMutableArray alloc] initWithCapacity:0];
   
    [self setTheNavigationBar];
    [self goToTheDownLoadPage];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    centerLable.hidden = YES;
    rigthbutton.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    rigthbutton.hidden = NO;
    topImageView.hidden = NO;
    returnButton.hidden = NO;
    centerLable.hidden = NO;
}
-(void)dealloc
{
    [centerLable release];
    [listOrderArray release];
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
