//
//  OrderDetailsViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "BillingDetailViewController.h"
@interface OrderDetailsViewController()

@end

@implementation OrderDetailsViewController
@synthesize orderNumberLable,orderStatusLable;
@synthesize orderTimerLable,departureLable,departureTimeLable,numberOfPeopleLable,destinationLable,contactLable,mobilNumberLable,couponLable;
@synthesize diidyModel,leftDepartureTimeLable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Self Call

-(void)getOrderDetails
{
    
    self.orderNumberLable.text = self.diidyModel.orderID;
    self.orderStatusLable.text = self.diidyModel.status;
    self.orderTimerLable.text = self.diidyModel.createTime;
    self.departureLable.text = self.diidyModel.startAddr;
    self.departureTimeLable.text = self.diidyModel.startTime;
    self.numberOfPeopleLable.text = self.diidyModel.ordersNumber;
    NSString * end = [NSString stringWithFormat:@"%@",self.diidyModel.endAddr];
    
    if(![end isEqualToString:@"<null>"]){
        self.destinationLable.text = end;

    }
    self.contactLable.text =self.diidyModel.contactName;
    self.mobilNumberLable.text = self.diidyModel.contactMobile;
    self.couponLable.text =self.diidyModel.coupon;
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
    [returnButton addTarget:self action:@selector(returnManageMentView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"订 单 列 表";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
}

#pragma mark - Button Approach

-(void)returnManageMentView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)changeOrCancelTheOrder:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel:4006960666"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview]; 
    [callWebview release];
}
-(void)billingDetailView:(id)sender
{
    BillingDetailViewController * billing = [[BillingDetailViewController alloc] init];
    billing.orderID= self.diidyModel.orderID;
    [self.navigationController pushViewController:billing animated:YES];
    [billing release];

}

#pragma mark - System Approach

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.navigationItem.hidesBackButton = YES;
    self.departureLable.numberOfLines = 0;
    [self setTheNavigationBar];
    NSLog(@"%@",self.diidyModel.status);
    if([self.diidyModel.status isEqualToString:@"已受理"]){
        NSLog(@"1");
        self.leftDepartureTimeLable.text = @"出发时间";
        UIImage * changeOrderImage =[UIImage imageNamed:@"u14_normal.png" ];
        UIButton*changeOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        changeOrderButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        [changeOrderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        changeOrderButton.frame=CGRectMake(60.0, 365.0,200, changeOrderImage.size.height);
        [changeOrderButton setBackgroundImage:changeOrderImage forState:UIControlStateNormal];
        [changeOrderButton setTitle:@"变更或者取消订单 拨打400电话" forState:UIControlStateNormal];
        [changeOrderButton addTarget:self action:@selector(changeOrCancelTheOrder:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:changeOrderButton];    
    }else if ([self.diidyModel.status isEqualToString:@"完成"]) {
        NSLog(@"2");
        self.leftDepartureTimeLable.text = @"开始时间";
        UIImage * billingDetailImage =[UIImage imageNamed:@"u148_normal.png" ];
        UIButton*billingDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        billingDetailButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
        
        billingDetailButton.frame=CGRectMake(5.0, 365.0,billingDetailImage.size.width, billingDetailImage.size.height);
        [billingDetailButton setBackgroundImage:billingDetailImage forState:UIControlStateNormal];
        [billingDetailButton setTitle:@"结算明细                                                 >" forState:UIControlStateNormal];
        [billingDetailButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [billingDetailButton addTarget:self action:@selector(billingDetailView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:billingDetailButton];
    }else {
        NSLog(@"3");
        self.leftDepartureTimeLable.text = @"出发时间";
    }
    
       [self getOrderDetails];
}

-(void)viewWillAppear:(BOOL)animated
{
    topImageView.hidden = NO;
    returnButton.hidden = NO;
    centerLable.hidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    centerLable.hidden = YES;

}
-(void)dealloc
{
    [topImageView release];
    [centerLable release];
    [leftDepartureTimeLable release];
    [diidyModel release];
    [orderNumberLable release];
    [orderStatusLable release];
    [orderTimerLable release];
    [departureLable release];
    [departureTimeLable release];
    [numberOfPeopleLable release];
    [destinationLable release];
    [contactLable release];
    [mobilNumberLable release];
    [couponLable release];
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
