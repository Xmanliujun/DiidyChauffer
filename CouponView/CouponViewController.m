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
@interface CouponViewController ()

@end

@implementation CouponViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)creatScrollView
{
    UIImageView * firstImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon_1.jpg"]];
    firstImageView .frame = CGRectMake(0, 0, 320, 90);
    
    UIImageView * secondImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon_2.jpg"]];
    secondImageView .frame = CGRectMake(320, 0, 320, 90);
    
    UIImageView * threeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon_3.jpg"]];
    threeImageView.frame = CGRectMake(640, 0, 320, 90);
    
    UIImageView * fourImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon_4.jpg"]];
    fourImageView .frame = CGRectMake(960, 0, 320, 90);
    
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0.0, 0.0, 320.0, 90.0);
    scrollView.contentSize = CGSizeMake(320.0*4,80.0);
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    [scrollView addSubview:firstImageView];
    [scrollView addSubview:secondImageView];
    [scrollView addSubview:threeImageView];
    [scrollView addSubview:fourImageView];
    [self.view addSubview:scrollView];
    [scrollView release];
    
    couponPage= [[UIPageControl alloc] init];
    couponPage.frame = CGRectMake(150.0, 90.0, 30.0, 20.0);
    couponPage.numberOfPages = 4;
    couponPage.currentPage = 0;
    [self.view addSubview:couponPage];
}
-(void)downLoadTheCouponData
{
    
    NSString * baseUrl = [NSString stringWithFormat:COUPON,ShareApp.mobilNumber];
    NSLog(@"%@",baseUrl);
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:baseUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    
    [request startAsynchronous];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    dataArry = [[NSMutableArray alloc] initWithCapacity:0];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"优 惠 劵 列 表";
    centerLable.textColor = [UIColor darkGrayColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
    
    UILabel * leftLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 70.0, 35.0)];
    leftLable.text = @"返回";
    leftLable.backgroundColor = [UIColor clearColor];
    leftLable.textAlignment = UITextAlignmentCenter;
    leftLable.font = [UIFont fontWithName:@"Arial" size:12.0];
    
    leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u13_normal.png"]];
    leftImage.frame = CGRectMake(10.0, 4.0, 70.0, 35.0);
    leftImage.userInteractionEnabled = YES;
    [leftImage addSubview:leftLable];
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0.0, 0.0, 70.0, 35.0);
    [leftButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [leftImage addSubview:leftButton];
    [self.navigationController.navigationBar addSubview:leftImage];
    
    messgeLable = [[UILabel alloc] init];
    messgeLable.frame = CGRectMake(0, 110, 320, 40);
    messgeLable.numberOfLines = 0;
    messgeLable.backgroundColor = [UIColor clearColor];
    messgeLable.font = [UIFont fontWithName:@"Arial" size:14];
    [self.view addSubview:messgeLable];
    
    [self downLoadTheCouponData];
    
    [self creatScrollView];
    [centerLable release];
    [leftLable release];
    [leftImage release];
    
}
-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    couponPage.currentPage = page;
    
    
}

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
    NSLog(@"row %d",indexPath.row);
    NSString * ID = @"cellID";
    CouponTableCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil)
    {
        cell = [[[CouponTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID] autorelease];
                
    }
  
    DIIdyModel *diidy = [dataArry objectAtIndex:0];
    cell.nameLable.text = diidy.name;
    cell.closeDataLable.text = diidy.close_date;
    NSString * number = [NSString stringWithFormat:@"X%@",diidy.number];
    cell.numberLable.text = number;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DIIdyModel * diidyModel = [dataArry objectAtIndex:indexPath.row];
    DetailPageViewController * detail = [[DetailPageViewController alloc] init];
    detail.couponID =diidyModel.ID;
    detail.detailCoupon = diidyModel.name;
    leftImage.hidden = YES;
    centerLable.hidden = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
}

-(void)parseStringJson:(NSString *)str
{
    
    DIIdyModel * diidy = [[DIIdyModel alloc] init];
    NSArray* jsonParser =[str JSONValue];
    
    for (int i = 0; i<[jsonParser count]; i++) {
        NSDictionary * diidyDict = [jsonParser objectAtIndex:i];
        diidy.ID = [diidyDict objectForKey:@"id"];
        diidy.name = [diidyDict objectForKey:@"name"];
        diidy.type = [diidyDict objectForKey:@"type"];
        diidy.number = [diidyDict objectForKey:@"number"];
        diidy.close_date = [diidyDict objectForKey:@"close_date"];
        diidy.amount = [diidyDict objectForKey:@"amount"];
        [dataArry addObject:diidy];
    }
    if([jsonParser count]!=0){
        messgeLable.text = MESSAGE; 
        CGRect rect = CGRectMake(0.0, 150.0, 320.0, 350.0);
        UITableView * couponTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        couponTableView.contentInset = UIEdgeInsetsMake(YINSET, 0, 0, 0);
        couponTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
        [couponTableView setSeparatorColor:[UIColor blackColor]];
        //couponTableView.separatorStyle = UITableViewCellEditingStyleNone;
        couponTableView.delegate = self;
        couponTableView.dataSource = self;
        [self.view addSubview:couponTableView];
        [couponTableView release];
        
    }else {
        messgeLable.text = NOMESSAGE;
    }
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self parseStringJson:[request responseString]];
}

-(void)viewWillAppear:(BOOL)animated
{
    centerLable.hidden = NO;
    leftImage.hidden = NO;
}

-(void)dealloc
{
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
