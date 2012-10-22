//
//  CouponViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CouponViewController.h"
#import "DetailPageViewController.h"
#import "SBJson.h"
#import "CONST.h"
#import "DIIdyModel.h"
#import "AppDelegate.h"
#import "CouponTableCell.h"
#import "ActivityViewController.h"
#import "JSONKit.h"
@interface CouponViewController ()

@end

@implementation CouponViewController
@synthesize order_request;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma Button Call
-(void)viewActivity:(UIButton*)sender
{
    
    ActivityViewController * active = [[ActivityViewController alloc] init];
    if (sender.tag==1) {
        active.diidyContent = HUNDREDYUAN;
        active.diidyTitle = @"不计里程，百元两次";
    }else if (sender.tag ==2) {
        active.diidyContent = ENJOYCARD;
        active.diidyTitle = @"代驾实惠无边，畅想会员特权！";
    }else if (sender.tag==3) {
        active.diidyContent = PREFERRNTIAL;
        active.diidyTitle = @"0元用代驾！优惠无底线！";
    }else if (sender.tag==4) {
        active.diidyContent = STUDENTCARD;
        active.diidyTitle = @"学生接送卡，准时接送，安全呵护。";
    }else if (sender.tag ==5) {
        active.diidyContent = REGISTERCARD;
        active.diidyTitle = @"注册即送50元！";
    }
    [self.navigationController pushViewController:active animated:YES];
    [active release];
    
}

-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
    
}

-(void)timerFired:(NSTimer *)timer{
    
    if (page>4) {
        page=-1;
    }
    couponPage.currentPage = page;
    page++;
    CGRect frame=couponScrollView.frame;
    frame.origin.x=frame.size.width*page;
    frame.origin.y=0;
    [couponScrollView  scrollRectToVisible:frame animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat pageWidth = scrollView.frame.size.width;
     page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    couponPage.currentPage = page;
    
}
#pragma mark-TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [dataArry count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * ID = @"cellID";
    CouponTableCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil)
    {
        cell = [[[CouponTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID] autorelease];
        //cell.backgroundColor = [UIColor grayColor];
        cell.contentView.backgroundColor = [UIColor darkGrayColor];
    }
  
    DIIdyModel *diidy = [dataArry objectAtIndex:indexPath.row];
    NSString * nameNumber = [NSString stringWithFormat:@"%@ X%@",diidy.name,diidy.number];
    cell.nameLable.text =nameNumber ;
    cell.closeDataLable.text = diidy.close_date;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DIIdyModel * diidyModel = [dataArry objectAtIndex:indexPath.row];
    DetailPageViewController * detail = [[DetailPageViewController alloc] init];
    detail.couponID =diidyModel.ID;
    detail.detailCoupon = diidyModel.name;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}
#pragma DownLoad Parsing
-(void)parseStringJson:(NSString *)str
{
    if (HUD){
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }

   // NSArray* jsonParser =[str JSONValue];
    NSArray* jsonParser =[str objectFromJSONString];
    if (dataArry) {
        [dataArry removeAllObjects];
    }else{
        dataArry = [[NSMutableArray alloc] initWithCapacity:0];;
    }
    
    for (int i = 0; i<[jsonParser count]; i++) {
        DIIdyModel * diidy = [[DIIdyModel alloc] init];
        NSDictionary * diidyDict = [jsonParser objectAtIndex:i];
        diidy.ID = [diidyDict objectForKey:@"id"];
        diidy.name = [diidyDict objectForKey:@"name"];
        diidy.type = [diidyDict objectForKey:@"type"];
        diidy.number = [diidyDict objectForKey:@"number"];
        diidy.close_date = [diidyDict objectForKey:@"close_date"];
        diidy.amount = [diidyDict objectForKey:@"amount"];
        [dataArry addObject:diidy];
        [diidy release];
    }
    CGRect rect;
    if([jsonParser count]!=0){
        messgeLable.text = MESSAGE; 
    
        if (60*[jsonParser count]>270) {
            rect = CGRectMake(0.0, 150.0, 320.0, 270);
        }else {
             rect = CGRectMake(0.0, 150.0, 320.0, 60*[jsonParser count]);
        }
        
        UITableView * couponTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        couponTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        couponTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
        //couponTableView.backgroundColor = [UIColor whiteColor];
        [couponTableView setSeparatorColor:[UIColor blackColor]];
        couponTableView.separatorStyle = UITableViewCellEditingStyleNone;
        couponTableView.delegate = self;
        couponTableView.dataSource = self;
        [self.view addSubview:couponTableView];
        [couponTableView release];
        
    }else {
        messgeLable.text = NOMESSAGE;
    }
    
}
-(void)requesttimeout
{
    [self closeConnection];

}

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
        
        [self parseStringJson:requestString];
        
    }
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
    [HUD release];
    HUD = nil;
}

#pragma Self Call
-(void)setTheNavigationBar
{
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"优 惠 劵 列 表";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0f, 7.0f, 50.0f, 30.0f);
    [returnButton setTitle:@"返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];

}


-(void)creatScrollView
{
    
    UIImageView * zeroImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon_0.jpg"]];
    zeroImageView .frame = CGRectMake(0, 0, 320, 90);
    
    
    UIImageView * firstImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon_1.jpg"]];
    firstImageView .frame = CGRectMake(320, 0, 320, 90);
    
    UIImageView * secondImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon_2.jpg"]];
    secondImageView .frame = CGRectMake(640, 0, 320, 90);
    
    UIImageView * threeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon_3.jpg"]];
    threeImageView.frame = CGRectMake(960, 0, 320, 90);
    
    UIImageView * fourImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon_4.jpg"]];
    fourImageView .frame = CGRectMake(1280, 0, 320, 90);
    
    couponScrollView = [[UIScrollView alloc] init];
    couponScrollView.frame = CGRectMake(0.0, 0.0, 320.0, 90.0);
    couponScrollView.contentSize = CGSizeMake(320.0*5,80.0);
    couponScrollView.backgroundColor = [UIColor grayColor];
    couponScrollView.showsVerticalScrollIndicator = NO;
    couponScrollView.showsHorizontalScrollIndicator = NO;
    couponScrollView.delegate = self;
    couponScrollView.userInteractionEnabled = YES;
    couponScrollView.pagingEnabled = YES;
    couponScrollView.scrollEnabled = YES;
    [couponScrollView addSubview:zeroImageView];
    [couponScrollView addSubview:firstImageView];
    [couponScrollView addSubview:secondImageView];
    [couponScrollView addSubview:threeImageView];
    [couponScrollView addSubview:fourImageView];
    
    [zeroImageView release];
    [firstImageView release];
    [secondImageView release];
    [threeImageView release];
    [fourImageView release];
    
    for (int i=0; i<5; i++) {
        UIButton * couButton = [UIButton buttonWithType:UIButtonTypeCustom];
        couButton.frame = CGRectMake(i*320, 0, 320, 90);
        couButton.tag = i+1;
        [couButton addTarget:self action:@selector(viewActivity:) forControlEvents:UIControlEventTouchUpInside];
        [couponScrollView addSubview:couButton];
    }
    [self.view addSubview:couponScrollView];
    
    couponPage= [[UIPageControl alloc] init];
    couponPage.frame = CGRectMake(150.0, 90.0, 30.0, 20.0);
    couponPage.numberOfPages = 5;
    couponPage.currentPage = 0;
    [self.view addSubview:couponPage];
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



-(void)showWithDetails{
    
    HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"Loading";
    HUD.detailsLabelText=@"获取优惠劵信息...";
    HUD.square=YES;
    [HUD show:YES];
    //此处进入多线程处理
 
    NSString * baseUrl = [NSString stringWithFormat:COUPON,ShareApp.mobilNumber];
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HTTPRequest *request = [[HTTPRequest alloc] init];
    self.order_request = request;
    self.order_request.m_delegate = self;
    self.order_request.hasTimeOut = YES;
    [request release];
    
    [self.order_request requestByUrlByGet: baseUrl];
}
-(void)regainData:(NSNotification *) notify {
    
    [self showWithDetails];
   
}

#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regainData:) name:@"ChangeTheme" object:nil];
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.navigationItem.hidesBackButton = YES;
    [self setTheNavigationBar];
     
    page = -1;
    dataArry = [[NSMutableArray alloc] initWithCapacity:0];
    
    messgeLable = [[UILabel alloc] init];
    messgeLable.frame = CGRectMake(0, 110, 320, 40);
    messgeLable.numberOfLines = 0;
    messgeLable.backgroundColor = [UIColor clearColor];
    messgeLable.font = [UIFont fontWithName:@"Arial" size:14];
    messgeLable.textColor = [UIColor orangeColor];
    [self.view addSubview:messgeLable];
   
    [self creatScrollView];
    [self showWithDetails];

    couponTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    centerLable.hidden = NO;
    topImageView.hidden = NO;
    returnButton.hidden = NO;
}
-(void)viewDidDisappear:(BOOL)animated
{
    centerLable.hidden = YES;
    topImageView.hidden = YES;
    returnButton.hidden = YES;

}
-(void)dealloc
{
    [couponPage release];
    [couponScrollView release];
    [topImageView release];
    [centerLable release];
    [messgeLable release];
    [dataArry release];
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
