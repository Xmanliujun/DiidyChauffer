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
#import "AppDelegate.h"
#import "DIIdyModel.h"
#import "ManageTableViewCell.h"
#import "QFDatabase.h"
#import "JSONKit.h"
#import "Reachability.h"
#import "MobClick.h"
#import <QuartzCore/QuartzCore.h>
#import "MobClick.h"

@interface ManageMentViewController ()

@end

@implementation ManageMentViewController
@synthesize m_request,manageStat;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)init
{
    self = [super init];
    if (self) {
          
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
    
    UIImage * noOrderImage = [UIImage imageNamed:@"lifeViewLine2.png"];
    UIImageView* noOrderImageView = [[UIImageView alloc] initWithImage:noOrderImage];
    noOrderImageView.frame = CGRectMake(20, 20,278.0f,153.0f);
    
    UILabel * noOrderLable = [[UILabel alloc] initWithFrame:CGRectMake(35.0, 35.0, 278.0f-30.0,153.0f-30.0)];
    noOrderLable.text =ORDERPROMPT;
    noOrderLable.textColor = [UIColor orangeColor];
    noOrderLable.backgroundColor = [UIColor clearColor];
    noOrderLable.font = [UIFont fontWithName:@"Arial" size:16.0];
    noOrderLable.numberOfLines = 0;
    [self.view addSubview:noOrderImageView];
    [self.view addSubview:noOrderLable];
    [noOrderImageView release];
    [noOrderLable release];
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
}
-(void)creatHaveOrderView
{
    if (orderTableView) {
        
        [orderTableView release];
        orderTableView=nil;
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, 320.0, 460.0-44.0);
    orderTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    orderTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    orderTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    orderTableView.backgroundView=nil;
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    orderTableView.separatorColor = [UIColor colorWithRed:182.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1];
    
    [self.view addSubview:orderTableView];
    [self setExtraCellLineHidden:orderTableView];
    
    [NSThread detachNewThreadSelector:@selector(downloadNewData:) toTarget:self withObject:nil];
    
}
#pragma mark-button
-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
    
}
-(void)refreshStep:(id)sender
{
    
    [MobClick event:@"m04_o001_0001_0003"];

    if (![ShareApp connectedToNetwork]) {
        
    }else{
        
        [self goToTheDownLoadPage];
    }
}
#pragma mark-HTTPDown

-(void)requFinish:(NSString *)requestString order:(int)nOrder{
    
   
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
    
    
    HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
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

- (void)downloadNewData:(NSString*)ur{

    NSArray * sqlitArray = [ShareApp.mDatabase readDataWithFMDB];

        for (int i = 0; i<sqlitArray.count;i++) {
            
            DIIdyModel * itemMO = [sqlitArray objectAtIndex:i];
            
            if ([itemMO.status isEqualToString:@"已受理"]) {
                
                NSString*urlString = [NSString stringWithFormat:@"http://www.diidy.com/client/orderlist/%@/%@/%@",ShareApp.mobilNumber,itemMO.createTime,itemMO.orderID];
                NSLog(@"%@",urlString);
                urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *url=[NSURL URLWithString:urlString];

                NSError *error=nil;
                NSString *responseString=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
                NSArray* jsonParserstat =[responseString objectFromJSONString];
                
                
                for (int i=0;i<[jsonParserstat count];i++) {
                    NSDictionary * diidyDictSt = [jsonParserstat objectAtIndex:i];
                    
                    if([[diidyDictSt objectForKey:@"status"] intValue]==5||[[diidyDictSt objectForKey:@"status"] intValue]==6){
                        
                        DIIdyModel * diidy = [[DIIdyModel alloc] init];
                        diidy.orderID = [diidyDictSt objectForKey:@"orderid"];
                        diidy.startTime = [diidyDictSt objectForKey:@"starttime"];
                        diidy.startAddr = [diidyDictSt objectForKey:@"startaddr"];
                        diidy.endAddr = [diidyDictSt objectForKey:@"endaddr"];
                        diidy.ordersNumber = [diidyDictSt objectForKey:@"number"];
                        diidy.contactName = [diidyDictSt objectForKey:@"contactname"];
                        diidy.contactMobile = [diidyDictSt objectForKey:@"contactmobile"];
                        diidy.createTime = [diidyDictSt objectForKey:@"createtime"];
                        diidy.coupon = [diidyDictSt objectForKey:@"coupon"];
                        NSString* currentStatus = [diidyDictSt objectForKey:@"status"];
                        
                        if ([currentStatus intValue]==5) {
                            
                            diidy.status = @"完成";
                            
                        }else if ([currentStatus intValue]==6)  {
                            
                            diidy.status = @"已取消";
                            
                        }
                        
                            [ShareApp.mDatabase modifyData:diidy];
                            [diidy release];
                    
                    }
               
                }
                //回到主线程
                [self performSelectorOnMainThread:@selector(updateInformation) withObject:nil waitUntilDone:YES];
            }
    }
}

-(void)updateInformation
{
    
     NSArray * sqlitArray = [ShareApp.mDatabase readDataWithFMDB];
    
    if (listOrderArray) {
        
        [listOrderArray removeAllObjects];
        
    }else
    {
        listOrderArray = [[NSMutableArray alloc] initWithCapacity:0];
        
    }

    
    for (int i = 0;i<sqlitArray.count;i++) {
    
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

     [orderTableView reloadData];
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
        DIIdyModel*diiModel = [sqlitArray objectAtIndex:[sqlitArray count]-1];
       
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

    [self showWithDetails];
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
    [HUD release];
     HUD = nil;
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
    
    for(int i=[jsonParser count]-1-a;i>=0;i--){
       
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
        
        if([currentStatus intValue]>=1&&[currentStatus intValue]<=4){
            
            diidy.status = @"已受理";
            
        }else if ([currentStatus intValue]==5) {
            
            diidy.status = @"完成";
            
        }else if ([currentStatus intValue]==6){
            
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
     DIIdyModel * diidy = [listOrderArray objectAtIndex:[listOrderArray count]-indexPath.row-1];
     CGSize size = [diidy.startAddr sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:CGSizeMake(180, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    if (size.height==16||size.height==0) {
        
         return 100;
        
    }else{
        
     return 70+size.height;
    
    }
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
    DIIdyModel * diidy = [listOrderArray objectAtIndex:[listOrderArray count]-indexPath.row-1];
    
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
   
      CGSize size = [diidy.startAddr sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:CGSizeMake(180, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    if (size.height==16||size.height==0) {
        
        cell.departureLable.frame = CGRectMake(75, 65, 180, 30);
        
    }else
    {
        cell.departureLable.frame = CGRectMake(75, 65, 180, size.height);
    
    }
    
    cell.orderNumberLable.text = diidy.orderID;
    cell.startTimeLable.text = diidy.startTime;
    cell.departureLable.text =diidy.startAddr;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MobClick event:@"m04_o001_0001"];
    OrderDetailsViewController * orderDetail = [[OrderDetailsViewController alloc] initWithNibName:@"OrderDetailsViewController" bundle:nil];
    orderDetail.diidyModel = [listOrderArray objectAtIndex:[listOrderArray count]-indexPath.row-1];
     
    [self.navigationController pushViewController:orderDetail animated:YES];
    [orderDetail release];
    
}

#pragma mark - System Approach

-(void)loadView
{
    [super loadView];
    //self.navigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-1.png"]];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTheNavigationBar];

}
-(void)getManageStat:(NSNotification *)notify {
    
    self.manageStat = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    [MobClick event:@"m04_o001"];

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getManageStat:) name:@"MANAGESTAT" object:nil];
   
    sqlitBool = YES;
    listOrderArray = [[NSMutableArray alloc] initWithCapacity:0];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.manageStat) {
        
        [self goToTheDownLoadPage];
    }
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
    if (m_request) {
        
        [self.m_request closeConnection];
        self.m_request.m_delegate=nil;
        self.m_request=nil;
    }
    if (orderTableView) {
        
        [orderTableView release];
    }
    
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
