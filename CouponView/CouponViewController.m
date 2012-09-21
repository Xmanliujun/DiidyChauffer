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
    
    
    couponScrollView = [[UIScrollView alloc] init];
    couponScrollView.frame = CGRectMake(0.0, 0.0, 320.0, 90.0);
    couponScrollView.contentSize = CGSizeMake(320.0*4,80.0);
    couponScrollView.backgroundColor = [UIColor grayColor];
    couponScrollView.showsVerticalScrollIndicator = NO;
    couponScrollView.showsHorizontalScrollIndicator = NO;
    couponScrollView.delegate = self;
    couponScrollView.userInteractionEnabled = YES;
    couponScrollView.pagingEnabled = YES;
    couponScrollView.scrollEnabled = YES;
    [couponScrollView addSubview:firstImageView];
    [couponScrollView addSubview:secondImageView];
    [couponScrollView addSubview:threeImageView];
    [couponScrollView addSubview:fourImageView];
    
    for (int i=0; i<4; i++) {
        UIButton * couButton = [UIButton buttonWithType:UIButtonTypeCustom];
        couButton.frame = CGRectMake(i*320, 0, 320, 90);
        couButton.tag = i+1;
        [couButton addTarget:self action:@selector(viewActivity:) forControlEvents:UIControlEventTouchUpInside];
         [couponScrollView addSubview:couButton];
    }
    [self.view addSubview:couponScrollView];
       
    couponPage= [[UIPageControl alloc] init];
    couponPage.frame = CGRectMake(150.0, 90.0, 30.0, 20.0);
    couponPage.numberOfPages = 4;
    couponPage.currentPage = 0;
    [self.view addSubview:couponPage];
}

-(void)viewActivity:(UIButton*)sender
{
    NSLog(@"%d",sender.tag);
    ActivityViewController * active = [[ActivityViewController alloc] init];
    [self.navigationController pushViewController:active animated:YES];
    [active release];
    
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
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.navigationItem.hidesBackButton = YES;
   
    dataArry = [[NSMutableArray alloc] initWithCapacity:0];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"优 惠 劵 列 表";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
   
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0, 5.0, 55.0, 35.0);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    messgeLable = [[UILabel alloc] init];
    messgeLable.frame = CGRectMake(0, 110, 320, 40);
    messgeLable.numberOfLines = 0;
    messgeLable.backgroundColor = [UIColor clearColor];
    messgeLable.font = [UIFont fontWithName:@"Arial" size:14];
    messgeLable.textColor = [UIColor orangeColor];
    [self.view addSubview:messgeLable];
    
    [self downLoadTheCouponData];
    [self creatScrollView];
    
    page = -1;
    couponTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
      
}

-(void)timerFired:(NSTimer *)timer{
    
    if (page>3) {
        page=-1;
    }
    couponPage.currentPage = page;
    page++;
    NSLog(@"%d",page);
    CGRect frame=couponScrollView.frame;
    frame.origin.x=frame.size.width*page;
    frame.origin.y=0;
    
    
    [couponScrollView  scrollRectToVisible:frame animated:YES];
}
-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat pageWidth = scrollView.frame.size.width;
     page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
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
        cell.backgroundColor = [UIColor whiteColor];      
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
        CGRect rect = CGRectMake(0.0, 150.0, 320.0, 60*[jsonParser count]);
        UITableView * couponTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        couponTableView.contentInset = UIEdgeInsetsMake(YINSET, 0, 0, 0);
        //couponTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
        couponTableView.backgroundColor = [UIColor whiteColor];
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

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self parseStringJson:[request responseString]];
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
