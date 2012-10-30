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
@interface OrderDetailsViewController()

@end

@implementation OrderDetailsViewController
@synthesize orderNumberLable,orderStatusLable;
@synthesize orderTimerLable,departureLable,departureTimeLable,numberOfPeopleLable,destinationLable,contactLable,mobilNumberLable,couponLable;
@synthesize diidyModel,leftDepartureTimeLable;
@synthesize statInforView,reservatInforView,clearingView;
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
    
    CGSize size = [self.departureLable.text sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:CGSizeMake(214, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    if (size.height==16) {
        
    }else{
        
    self.departureLable.frame = CGRectMake(self.departureLable.frame.origin.x, self.departureLable.frame.origin.y, self.departureLable.frame.size.width, size.height);
   
    }
    
    if(![end isEqualToString:@"<null>"]){
        
        self.destinationLable.text = end;

    }
    
    CGSize size2 = [self.destinationLable.text sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:CGSizeMake(214, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    if (size2.height==32) {
        
         self.destinationLable.frame = CGRectMake(self.destinationLable.frame.origin.x, self.destinationLable.frame.origin.y, self.destinationLable.frame.size.width, size2.height+5);
        
    }else{
        
       
    }

    self.contactLable.text =self.diidyModel.contactName;
    self.mobilNumberLable.text = self.diidyModel.contactMobile;
    self.couponLable.text =self.diidyModel.coupon;
}
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

-(void)setViewStatus{
    
    self.statInforView.backgroundColor=[UIColor whiteColor];
    [[self.statInforView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[self.statInforView layer] setShadowRadius:5];
    [[self.statInforView layer] setShadowOpacity:1];
    [[self.statInforView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[self.statInforView layer] setCornerRadius:7];
    [[self.statInforView layer] setBorderWidth:1];
    [[self.statInforView layer] setBorderColor:[UIColor grayColor].CGColor];
    [self.view sendSubviewToBack:self.statInforView];
    
    self.reservatInforView.backgroundColor=[UIColor whiteColor];
    [[self.reservatInforView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[self.reservatInforView layer] setShadowRadius:5];
    [[self.reservatInforView layer] setShadowOpacity:1];
    [[self.reservatInforView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[self.reservatInforView layer] setCornerRadius:7];
    [[self.reservatInforView layer] setBorderWidth:1];
    [[self.reservatInforView layer] setBorderColor:[UIColor grayColor].CGColor];
    [self.view sendSubviewToBack:self.reservatInforView];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.navigationItem.hidesBackButton = YES;
    
    self.departureLable.numberOfLines = 0;
    self.destinationLable.numberOfLines= 0;
    self.orderStatusLable.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];;
    self.orderNumberLable.textColor =[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.orderTimerLable.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.departureLable.textColor=[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.departureTimeLable.textColor=[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.numberOfPeopleLable.textColor=[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.destinationLable.textColor=[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.contactLable.textColor=[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.mobilNumberLable.textColor=[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    self.couponLable.textColor=[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
   // self.leftDepartureTimeLable.textColor=[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    
    [self setTheNavigationBar];
    
    [self setViewStatus];
   
    if([self.diidyModel.status isEqualToString:@"已受理"]){
    
        self.leftDepartureTimeLable.text = @"出发时间:";
        UIImage * changeOrderImage =[UIImage imageNamed:@"orderDetail1.png"];
        UIImage * changeOrderImage2 =[UIImage imageNamed:@"orderDetail2.png"];
        UIButton*changeOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [changeOrderButton setTitle:@"变更或取消订单拨打400电话" forState:UIControlStateNormal];
        changeOrderButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [changeOrderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        changeOrderButton.frame=CGRectMake(60.0, 365.0,changeOrderImage.size.width-118.0, changeOrderImage.size.height-25.0);
        changeOrderButton.frame=CGRectMake(5.0, 365.0,310, changeOrderImage.size.height);
        [changeOrderButton setBackgroundImage:changeOrderImage forState:UIControlStateNormal];
         [changeOrderButton setBackgroundImage:changeOrderImage2 forState:UIControlStateSelected];
        [changeOrderButton addTarget:self action:@selector(changeOrCancelTheOrder:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:changeOrderButton];
        
    }else if ([self.diidyModel.status isEqualToString:@"完成"]) {
        
        self.leftDepartureTimeLable.text = @"开始时间:";
      //  UIImage * billingDetailImage =[UIImage imageNamed:@"u148_normal.png" ];
        
        self.clearingView = [[UIView alloc] initWithFrame:CGRectMake(6.0, 365.0,308.0,40.0)];
        
        self.clearingView.backgroundColor=[UIColor whiteColor];
        [[self.clearingView layer] setShadowOffset:CGSizeMake(1, 1)];
        [[self.clearingView layer] setShadowRadius:5];
        [[self.clearingView layer] setShadowOpacity:1];
        [[self.clearingView layer] setShadowColor:[UIColor whiteColor].CGColor];
        [[self.clearingView layer] setCornerRadius:7];
        [[self.clearingView layer] setBorderWidth:1];
        [[self.clearingView layer] setBorderColor:[UIColor grayColor].CGColor];
      
        UIButton*billingDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
       billingDetailButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
        
        billingDetailButton.frame=CGRectMake(0.0,0.0,310, 40);
       // [billingDetailButton setBackgroundImage:billingDetailImage forState:UIControlStateNormal];
        [billingDetailButton setTitle:@"结算明细                                                 >" forState:UIControlStateNormal];
        [billingDetailButton setTitleColor:[UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1] forState:UIControlStateNormal];
        [billingDetailButton addTarget:self action:@selector(billingDetailView:) forControlEvents:UIControlEventTouchUpInside];
        [self.clearingView addSubview:billingDetailButton];
        [self.view addSubview:self.clearingView];
    }else {
        
        self.leftDepartureTimeLable.text = @"出发时间:";
        
    }
    
       [self getOrderDetails];
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
