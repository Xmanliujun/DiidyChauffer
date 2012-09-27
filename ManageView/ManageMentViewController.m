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
@interface ManageMentViewController ()

@end

@implementation ManageMentViewController

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
    topImageView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
       returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0, 5.0, 55.0, 35.0);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"订 单 列 表";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
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
    UITableView * orderTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    orderTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    [orderTableView setSeparatorColor:[UIColor blackColor]];
    [self.view addSubview:orderTableView];
    [orderTableView release];
    
}

-(void)goToTheDownLoadPage
{
    
    NSString * baseUrl = [NSString stringWithFormat:ORDERNUMBER,ShareApp.mobilNumber];
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:baseUrl];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];  
    urlConnecction = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];  
    //为了安全，捕捉不存在的连接  
    if(urlConnecction != nil)  {
        receivedData =[[NSMutableData data] retain];
        return;
    }
          
}
#pragma mark-HTTPDown
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{  
    
    [receivedData setLength:0];
    
}  

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{  
    
    [receivedData appendData:data];
    
    
}  
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{  
    
    [urlConnecction release]; 
    [receivedData release];
    NSLog(@"Connection failed! Error - %@ %@", 
          [error localizedDescription], 
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]); 
    
}  
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{  
    
   NSString *result = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];
    [self parseStringJson:result];
    [urlConnecction release]; 
    [receivedData release];

}  

-(void)parseStringJson:(NSString *)str
{
    NSArray* jsonParser =[str JSONValue];
    
    for(int i = 0;i<[jsonParser count];i++){
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
        
        [listOrderArray addObject:diidy];
        [diidy release];
        [ShareApp.mDatabase insertToDatabase:listOrderArray];
        NSArray * assss = [ShareApp.mDatabase readDataWithFMDB];
        NSLog(@"ssss%@",assss);
        
    }
//    if(([jsonParser count])==0)
//    {
//        [self creatNOOrdersView];
//    }else {
//        [self creatHaveOrderView];
//        
//    }
}

-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
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
        cell.backgroundColor = [UIColor whiteColor];
        
    }
    DIIdyModel * diidy = [listOrderArray objectAtIndex:indexPath.row];
    
    if ([diidy.status isEqualToString:@"已受理"]) {
        cell.statusLable.textColor = [UIColor redColor];
    }else if([diidy.status isEqualToString:@"完成"]){
        cell.statusLable.textColor = [UIColor greenColor];
    }else {
        cell.statusLable.textColor = [UIColor grayColor];
    }
    cell.statusLable.text = diidy.status;
    cell.orderNumberLable.text = diidy.orderID;
    cell.startTimeLable.text = diidy.startTime;
    cell.departureLable.text =diidy.startAddr;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
   
    listOrderArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self setTheNavigationBar];
    [self goToTheDownLoadPage];
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    centerLable.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
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
