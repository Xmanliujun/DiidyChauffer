//
//  OrdersPreviewViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrdersPreviewViewController.h"
#import "DIIdyModel.h"
@interface OrdersPreviewViewController ()

@end

@implementation OrdersPreviewViewController


@synthesize departureLable,departureTimeLable,numberOfPeopleLable,destinationLable,contactLable,mobilNumberLable,remarkLable,couponTableView;
@synthesize orderArray,useCouponArray,selectArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    couponArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.couponTableView.delegate = self;
    self.couponTableView.dataSource =self;
    self.couponTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
//    for (NSIndexPath *ip in selectArray) {
//        DIIdyModel * diidy = [useCouponArray objectAtIndex:ip.section];
//        diidy.numberID++;
//        NSLog(@"%d",diidy.numberID);
//    }

    
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"u108_normalp.png"] forState:UIControlStateNormal];
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    leftbutton.frame=CGRectMake(0.0, 100.0, 43.0, 25.0);
    [leftbutton addTarget:self action:@selector(returnFillOrderView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];

    self.departureLable.text =[self.orderArray objectAtIndex:0];//出发地
    self.departureTimeLable.text = [self.orderArray objectAtIndex:1];//出发时间
    self.numberOfPeopleLable.text =[self.orderArray objectAtIndex:2];//人数
    self.destinationLable.text = [self.orderArray objectAtIndex:3];//目的地
    self.contactLable.text = [self.orderArray objectAtIndex:4];//联系人
    self.mobilNumberLable.text = [self.orderArray objectAtIndex:5];//手机号码
   
   
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
  
    UIButton *rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"u927_normal.png"] forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rigthbutton setTitle:@"提交订单" forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rigthbutton.frame=CGRectMake(0.0, 100.0, 65.0, 34.0);
    [rigthbutton addTarget:self action:@selector(submitOrders:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];

    
    UILabel *centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 30.0f)];
    centerLable.font = [UIFont systemFontOfSize:17];
    centerLable.textColor = [UIColor blackColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.text = @"订 单 预 览";
    self.navigationItem.titleView = centerLable;
    [centerLable release]; 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [selectArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    
    DIIdyModel * diidyMbdel = [useCouponArray objectAtIndex:0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
    cell.textLabel.text = diidyMbdel.name;
    
    return cell;
}

-(void)returnFillOrderView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)submitOrders:(id)sender
{
        

}

-(void)dealloc
{
    [selectArray release];
    [couponTableView release];
    [useCouponArray release];
    [orderArray release];
    [departureLable release];
    [departureTimeLable release];
    [numberOfPeopleLable  release];
    [destinationLable release];
    [contactLable release];
    [mobilNumberLable release];
    [remarkLable  release];
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
