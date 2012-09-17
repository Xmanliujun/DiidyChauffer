//
//  SelectCouponViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectCouponViewController.h"
#import "DIIdyModel.h"
#import "OrdersPreviewViewController.h"
#import "OrdersPreviewTwoViewController.h"
@interface SelectCouponViewController ()

@end

@implementation SelectCouponViewController
@synthesize selectCouponAray,rowNumber;
@synthesize delegate,mark,orderPreArray;
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
   
    useSelectCouponArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"u108_normalp.png"] forState:UIControlStateNormal];
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    leftbutton.frame=CGRectMake(0.0, 100.0, 43.0, 25.0);
    [leftbutton addTarget:self action:@selector(returnFillOrderView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];

    UILabel *centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 30.0f)];
    centerLable.font = [UIFont systemFontOfSize:17];
    centerLable.textColor = [UIColor blackColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.text = @"选 择 优 惠 劵";
    self.navigationItem.titleView = centerLable;
    [centerLable release]; 
    
    NSString * title;
    if(self.mark){
        title = @"下一步";
    
    }else {
        title = @"完成";
    }
    
    
    UIButton *rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"u927_normal.png"] forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rigthbutton setTitle:title forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rigthbutton.frame=CGRectMake(0.0f, 100.0f, 65.0f, 34.0f);
    [rigthbutton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
     
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];
    
    UILabel *promptLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 303.0f, 50.0f)];
    promptLable.font = [UIFont systemFontOfSize:14];
    promptLable.textColor = [UIColor blackColor];
    promptLable.backgroundColor = [UIColor clearColor];
    promptLable.textAlignment = UITextAlignmentCenter;
    promptLable.text = @"选 择 优 惠 劵";
   
    UIImage * promptImage = [UIImage imageNamed:@"u689_normal.png"];
    UIImageView * promptImageView = [[UIImageView alloc] initWithImage:promptImage];
    promptImageView.frame = CGRectMake(8.0f, 0.0f, promptImage.size.width, promptImage.size.height);
    [promptImageView addSubview:promptLable];
    [self.view addSubview:promptImageView];
    [promptImageView release];
    [promptLable release];
    
    NSLog(@"%d",rowNumber);
    CGRect  rect ;
    if((140.f+self.rowNumber*44.0f)>394){
        rect = CGRectMake(0.0f, 52.0f, 320.0f,394.0f);
        
    }else {
        rect = CGRectMake(0.0f, 52.0f, 320.0f, 140.0f+(rowNumber-2)*44.0f);
    }
        
    
    UITableView * orderTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [orderTableView setEditing:YES animated:YES];
    orderTableView.separatorColor = [UIColor grayColor];
    orderTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    orderTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    [orderTableView setSeparatorColor:[UIColor grayColor]];
    [self.view addSubview:orderTableView];
    [orderTableView release];
    
    UIImage * skipImage = [UIImage imageNamed:@"u663_normal.png"];
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton setBackgroundImage:skipImage forState:UIControlStateNormal];
    [skipButton setTitle:@"跳过,本次订单不适用优惠劵" forState:UIControlStateNormal];
    [skipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    skipButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    skipButton.frame=CGRectMake(5.0, 374.0, skipImage.size.width, skipImage.size.height);
    [skipButton addTarget:self action:@selector(skipCouponView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipButton];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [selectCouponAray count];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    DIIdyModel * diidyModel = [selectCouponAray objectAtIndex:0];
    return [diidyModel.number intValue];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    
    DIIdyModel * diidyMbdel = [selectCouponAray objectAtIndex:0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
    cell.textLabel.text = diidyMbdel.name;
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSIndexPath *willDeleteIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    [useSelectCouponArray addObject:willDeleteIndexPath];

}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (NSIndexPath *ip in useSelectCouponArray) {
        if (ip.section == indexPath.section && ip.row == indexPath.row) {
            [useSelectCouponArray removeObject:ip];
            break;
        }
    }
}

-(void)returnFillOrderView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)skipCouponView:(id)sender
{
    OrdersPreviewTwoViewController * order = [[OrdersPreviewTwoViewController alloc] init];
    order.orderArray =  self.orderPreArray;
    [self.navigationController pushViewController:order animated:YES];
    [order release];



}
-(void)nextStep:(id)sender
{
    if(!self.mark){
        [delegate selectedCoupon:useSelectCouponArray];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        OrdersPreviewViewController * order = [[OrdersPreviewViewController alloc] init];
        order.orderArray =  self.orderPreArray;
        order.selectArray =useSelectCouponArray;
        order.useCouponArray = selectCouponAray;
        [self.navigationController pushViewController:order animated:YES];
        [order release];
    }
    
}

-(void)dealloc
{
    [orderPreArray release];
    [useSelectCouponArray release];
    [selectCouponAray release];
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
