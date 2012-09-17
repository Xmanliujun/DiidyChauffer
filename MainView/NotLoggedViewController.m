//
//  NotLoggedViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NotLoggedViewController.h"
#import "FeedBackViewController.h"
#import "AboutDiiDyViewController.h"
#import "CONST.h"
@interface NotLoggedViewController ()

@end

@implementation NotLoggedViewController
@synthesize  moreNameArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)creatNavigationBar
{
    UIButton*rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"u24_normal.png"] forState:UIControlStateNormal];
    [rightButton setTitle:@"登陆" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rightButton.tag = 200;
    rightButton.frame=CGRectMake(240.0, 4.0, 70.0, 35.0);
    [rightButton addTarget:self action:@selector(returnORLandingView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* logItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = logItem;    
    [logItem release];
    
    UIButton * leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"u13_normal.png"] forState:UIControlStateNormal];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    leftButton.frame=CGRectMake(0.0f, 100.0, 70.0, 35.0);
    leftButton.tag = 201;
    [leftButton addTarget:self action:@selector(returnORLandingView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.moreNameArray = [NSArray  arrayWithObjects:@"意见反馈",@"关于滴滴",@"新手引导", nil];
    self.navigationItem.title = @"更多";
    [self creatNavigationBar];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRequestCompelte:) name:REQUEST_COMPLETE object:nil];
    
    UITableView * moreTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    moreTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    [moreTableView setSeparatorColor:[UIColor blackColor]];
    moreTableView.delegate = self;
    moreTableView.dataSource = self;
    [self.view addSubview:moreTableView];
    [moreTableView release];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    cell.textLabel.text = [moreNameArray objectAtIndex:indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        FeedBackViewController * feedBack = [[FeedBackViewController alloc] init];
        feedBack.judge = @"notLog";
        [self.navigationController pushViewController:feedBack animated:YES];
        [feedBack release];
    }else if(indexPath.row ==1){
        AboutDiiDyViewController * aboutDiidy = [[AboutDiiDyViewController alloc] initWithNibName:@"AboutDiiDyViewController" bundle:nil];
        [self.navigationController pushViewController:aboutDiidy animated:YES];
        [aboutDiidy release];
    }
}
-(void)returnORLandingView:(UIButton*)sender
{
       if (sender.tag ==201) {
            [self dismissModalViewControllerAnimated:NO];
        }else {
            
        }
        
}
-(void)onRequestCompelte:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    NSString * returnNews = [dict objectForKey:@"return"];
    if ([returnNews isEqualToString:@"s"]) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil 
                                                       message:@"提交成功！我们会认真参考您的建议,非常感谢！"
                                                      delegate:nil 
                                             cancelButtonTitle:@"确认" 
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];
    }else {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil 
                                                       message:@"可能由于网络原因没有成功提交。您也可以拨打4006960666进行反馈。"
                                                      delegate:nil 
                                             cancelButtonTitle:@"确认" 
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];
    }

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
