//
//  OrderDetailsViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "BillingDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MobClick.h"
@interface OrderDetailsViewController()

@end

@implementation OrderDetailsViewController


@synthesize clearingView,diidyModel;

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
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0f, 7.0f, 50.0f, 30.0f);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnManageMentView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"订 单 详 情";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
}

#pragma mark - Button Approach

-(void)returnManageMentView:(id)sender
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"MANAGE",@"STATUS", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MANAGESTAT" object:self userInfo:dict];
    [self.navigationController popToRootViewControllerAnimated:YES];
   
}


#pragma mark - System Approach


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.navigationItem.hidesBackButton = YES;
    [self setTheNavigationBar];
  
   UITableView*  orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f) style:UITableViewStyleGrouped];
    orderTableView.backgroundColor = [UIColor clearColor];
    orderTableView.backgroundView=nil;
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    [self.view addSubview:orderTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    if([self.diidyModel.status isEqualToString:@"已受理"]){
        
        return 4;
      
    }else if ([self.diidyModel.status isEqualToString:@"完成"]) {
        
        return 4;
        
    }else
        
        return 3;

    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
       
        return 44;
    }else if (indexPath.section==1&&indexPath.row==1)
    {
        CGSize size1 = [self.diidyModel.startAddr sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(230, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        if (size1.height==18.0||size1.height==0) {
            return 44;
        }else
            return 30+size1.height-18;
        
    }else if(indexPath.section==1&&indexPath.row==4)
    {
        
        
        CGSize size2 = [self.diidyModel.endAddr sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
        
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
        
        return 2;
        
    }else if(section==1)
        
        return 5;
    else if(section==2){
        
        return 3;
    }else
        return 1;
       
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
        
        
        UILabel*  markLable = [[UILabel alloc] initWithFrame:CGRectMake(3.0f, 0.0f, 80.0f, 44.0f)];
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
    
    CGSize size1 = [self.diidyModel.startAddr sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(230, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
        CGSize size2 = [self.diidyModel.endAddr sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:UILineBreakModeCharacterWrap];

    
    if (indexPath.section==1&&indexPath.row==1) {
        
        if (size1.height==18.0||size1.height==0) {
            messageLable.frame = CGRectMake(65.0f, 0.0f, 230.0f, 44);
            
        }else{
            
            messageLable.frame = CGRectMake(65.0f, 0.0f, 230.0f,30+size1.height-18);
            
        }
        
    }else if(indexPath.section==1&&indexPath.row==4){
        
        if (size2.height==18.0||size2.height==0) {
            
            messageLable.frame = CGRectMake(65.0f, 0.0f, 230.0f,44);
            
        }else{
            
            messageLable.frame = CGRectMake(65.0f, 0.0f, 230.0f,30+size2.height-18);
            
        }
        
    }else{
    
         messageLable.frame = CGRectMake(65.0f, 0.0f, 230.0f, 44);
    
    }
   
    if (indexPath.section==0&&indexPath.row==0) {
        
        markLable.text = @"订单编号:";
        messageLable.text = self.diidyModel.orderID;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;

    }else if (indexPath.section==0&&indexPath.row==1) {
        markLable.text = @"订单状态:";
        messageLable.text = self.diidyModel.status;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;

        
    }else if (indexPath.section==1&&indexPath.row==0) {
        
        markLable.text = @"下单时间:";
        messageLable.text = self.diidyModel.createTime;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;

    }else if (indexPath.section==1&&indexPath.row==1) {
        
        markLable.text = @"出发地:";
        messageLable.text = self.diidyModel.startAddr;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;


    }else if(indexPath.section==1&&indexPath.row==2)
    {
        markLable.text = @"开始时间:";
        messageLable.text = self.diidyModel.startTime;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;

        
    }else if(indexPath.section==1&&indexPath.row==3){
        
        
        markLable.text = @"人数:";
        messageLable.text =self.diidyModel.ordersNumber;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;

        
    }else if(indexPath.section==1&&indexPath.row==4){
        
        markLable.text = @"目的地:";
        messageLable.text =self.diidyModel.endAddr;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;


    }else if(indexPath.section==2&&indexPath.row==0){
        
        markLable.text = @"联系人:";
        messageLable.text =self.diidyModel.contactName;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;

    }else if(indexPath.section==2&&indexPath.row==1){
        
        markLable.text = @"手机号码:";
        messageLable.text =self.diidyModel.contactMobile;
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;

        
    }else if(indexPath.section==2&&indexPath.row==2){
        
        markLable.text = @"优惠劵:";
        if (self.diidyModel.coupon ==NULL||[self.diidyModel.coupon length]==0) {
            
            messageLable.text = @"未使用";
            
        }else{
            
            messageLable.text =self.diidyModel.coupon;
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        
    }else if (indexPath.section==3&&indexPath.row==0)
    {
        if([self.diidyModel.status isEqualToString:@"已受理"]){
            
            markLable.text = @"";
            messageLable.text =@"变更或取消订单拨打400电话";
            cell.backgroundColor = [UIColor orangeColor];
             cell.accessoryType = UITableViewCellAccessoryNone;
          
            
        }else if ([self.diidyModel.status isEqualToString:@"完成"]) {

       
            markLable.text = @"结算明细";
            messageLable.text =@"";
             cell.backgroundColor = [UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }


   return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==3&&indexPath.row==0)
    {
        if([self.diidyModel.status isEqualToString:@"已受理"]){
            
            [MobClick event:@"m04_o001_0001_0001"];
            UIWebView*callWebview =[[UIWebView alloc] init];
            NSURL *telURL =[NSURL URLWithString:@"tel:4006960666"];
            [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            //记得添加到view上
            [self.view addSubview:callWebview];
            [callWebview release];
            
        }else if ([self.diidyModel.status isEqualToString:@"完成"]) {
            
            [MobClick event:@"m04_o001_0001_0002"];

            BillingDetailViewController * billing = [[BillingDetailViewController alloc] init];
            billing.orderID= self.diidyModel.orderID;
            [self.navigationController pushViewController:billing animated:YES];
            [billing release];
        }
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    topImageView.hidden = NO;
    returnButton.hidden = NO;
    centerLable.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    centerLable.hidden = YES;

}

-(void)dealloc
{
    
    [super dealloc];
    [topImageView release];
    [centerLable release];
    [diidyModel release];
   
  
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
