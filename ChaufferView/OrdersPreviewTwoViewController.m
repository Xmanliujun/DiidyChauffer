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
#import "MainViewController.h"
#import "JSONKit.h"
#import "Reachability.h"
#import "MobClick.h"
@interface OrdersPreviewTwoViewController ()

@end

@implementation OrdersPreviewTwoViewController

@synthesize orderArray;
@synthesize submit_request;
@synthesize markPre;

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
    if (self.markPre) {
    
         [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self dismissModalViewControllerAnimated:NO];
        
    }
}
-(void)submitOrders:(id)sender
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"确认提交订单" 
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
        
        [MobClick event:@"m03_d002_0003"];
        [MobClick event:@"m03_d002_0004_0002"];
        
        if (![ShareApp connectedToNetwork]) {
            
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                           message:@"联网失败,请稍后再试"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }else{
         
            NSString*departureString = [self.orderArray objectAtIndex:0];
            NSString*departureTimeString = [self.orderArray objectAtIndex:1];
            NSString*numberOfPeopleString = [self.orderArray objectAtIndex:2];
            NSString*destinationString = [self.orderArray objectAtIndex:3];
            NSString*contactString = [self.orderArray objectAtIndex:4];
            NSString*mobilNumberString = [self.orderArray objectAtIndex:5];
            
            
            if ([self.orderArray objectAtIndex:0]==NULL||[[self.orderArray objectAtIndex:0] length]==0) {
                
                
                departureString = @"无";

                
            }
            if ([self.orderArray objectAtIndex:1]==NULL||[[self.orderArray objectAtIndex:1] length]==0) {
                
                departureTimeString =@"无";
            }
            
           if ([self.orderArray objectAtIndex:2]==NULL||[[self.orderArray objectAtIndex:2] length]==0) {
                
               numberOfPeopleString = @"无";
                
            }
            if ([self.orderArray objectAtIndex:3]==NULL||[[self.orderArray objectAtIndex:3] length]==0) {
               
                destinationString = @"无";
                
            }

            if ([self.orderArray objectAtIndex:4]==NULL||[[self.orderArray objectAtIndex:4] length]==0) {
                
               contactString  = @"无";
                
            }
            if ([self.orderArray objectAtIndex:5]==NULL||[[self.orderArray objectAtIndex:5] length]==0) {
                
                mobilNumberString = @"无";
                
            }
        

            NSString * baseUrl = [NSString stringWithFormat:SUBMITORDERS,departureTimeString, departureString,numberOfPeopleString,destinationString,mobilNumberString,contactString,@"无",ShareApp.mobilNumber];
            NSLog(@"xxx   %@",baseUrl);
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
     [MobClick event:@"m03_d002_0002"];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];

    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0, 7.0, 50.0, 30.0);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnFillOrderView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    
    //orderPre
    [rigthbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    rigthbutton.frame=CGRectMake(256.0f, 7.0f, 58.0f, 31.0f);
    [rigthbutton setTitle:@"提交订单" forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(submitOrders:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.font = [UIFont systemFontOfSize:17];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.text =@"订 单 预 览";
    [self.navigationController.navigationBar addSubview:centerLable];

    UITableView*  orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f) style:UITableViewStyleGrouped];
    orderTableView.backgroundColor = [UIColor clearColor];
    orderTableView.backgroundView=nil;
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    [self.view addSubview:orderTableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[[UIView alloc] init] autorelease];
    myView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, 22)];
    titleLabel.textColor=[UIColor orangeColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    if (section==0) {
        
        titleLabel.text = @"订单信息";
        
    }else if (section==1){
        
       titleLabel.text = @"联系人信息";
    
    }
    [myView addSubview:titleLabel];
    [titleLabel release];
    return myView;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   
    if (section==0) {
      
        return @"订单信息";
        
    }else
        
       return @"联系人信息";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        
         CGSize size1 = [[self.orderArray objectAtIndex:0] sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(230, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
     
        if (size1.height==18.0) {
            
            return 44;
            
        }else
            
        return 30+size1.height-18;
        
    }else if (indexPath.section==0&&indexPath.row==3){
        
          CGSize size2 = [[self.orderArray objectAtIndex:3] sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(230, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        
        if (size2.height==18.0||size2.height==0) {
            
            return 44;
            
        }else
            
            return 30+size2.height-18;
    
    }
            return 44;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        
        return 4;
        
    }else
        
        return 2;
    
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
        UILabel*  markLable = [[UILabel alloc] initWithFrame:CGRectMake(3.0f, 0.0f, 60.0f, 44.0f)];
        markLable.font = [UIFont systemFontOfSize:14];
        markLable.textColor = [UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1];
        markLable.tag =60;
        markLable.numberOfLines=0;
        markLable.backgroundColor = [UIColor clearColor];
        markLable.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:markLable];
        [markLable release];
        
         UILabel*  messageLable = [[UILabel alloc] initWithFrame:CGRectMake(65.0f, 0.0f, 230.0f, 44.0f)];
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
    
    CGSize size = [[self.orderArray objectAtIndex:0] sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(230, 1000) lineBreakMode:UILineBreakModeCharacterWrap];

    CGSize size2 = [[self.orderArray objectAtIndex:3] sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(230, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    if (indexPath.section==0&&indexPath.row==0) {
        
        if (size.height==18.0) {
            
            messageLable.frame = CGRectMake(65.0f, 0.0f, 230.0f, 44);
        
        }else{
            
            messageLable.frame = CGRectMake(65.0f, 0.0f, 230.0f,30+size.height-18 );
            
        }
            
    }else if(indexPath.section==0&&indexPath.row==3){
        
        
        if (size2.height==18.0) {
            
            messageLable.frame = CGRectMake(65.0f, 0.0f, 230.0f, 44);
            
        }else{
            
            messageLable.frame = CGRectMake(65.0f, 0.0f, 230.0f,30+size2.height-18 );
    
        }
    }else{
    
        messageLable.frame = CGRectMake(65.0f, 0.0f, 230.0f, 44);
    }


    if (indexPath.section==0&&indexPath.row==0) {
    
        markLable.text = @"出发地:";
        messageLable.text = [self.orderArray objectAtIndex:0];

    }else if (indexPath.section==0&&indexPath.row==1) {
        
         markLable.text = @"出发时间:";
         messageLable.text = [self.orderArray objectAtIndex:1];
        
    }else if (indexPath.section==0&&indexPath.row==2) {
        
         markLable.text = @"司机个数:";
         messageLable.text = [self.orderArray objectAtIndex:2];
        
    }else if (indexPath.section==0&&indexPath.row==3) {
        
         markLable.text = @"目的地:";
         messageLable.text = [self.orderArray objectAtIndex:3];
    }
    if (indexPath.section==1&&indexPath.row==0) {
        
        markLable.text = @"姓名:";
        messageLable.text = [self.orderArray objectAtIndex:4];
        
    }else if(indexPath.section==1&&indexPath.row==1)
    {
        markLable.text = @"手机号:";
        if ([self.orderArray objectAtIndex:5]==NULL||[[self.orderArray objectAtIndex:5]length]==0) {
           
            messageLable.text = ShareApp.mobilNumber;
            
        }else
            
            messageLable.text = [self.orderArray objectAtIndex:5];

        }
    
        return cell;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;
    centerLable.hidden = YES;
}
-(void)dealloc
{
    [centerLable release];
    [orderArray release];
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
