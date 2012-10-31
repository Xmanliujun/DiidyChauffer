//
//  MoreViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "OnTheRoadViewController.h"
#import "ChangePasswordViewController.h"
#import "FeedBackViewController.h"
#import "AboutDiiDyViewController.h"
#import "NoviceGuidanceViewController.h"
#import "CONST.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize moreNameArray,whereLand;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)returnORLandingView:(UIButton*)sender
{
    if ([self.whereLand isEqualToString:@"Land"]) {
        MainViewController * main = [[MainViewController alloc] init];
        [ShareApp.window setRootViewController:main];
        [main release];
    }else {
        [self dismissModalViewControllerAnimated:NO];
    }
  
}
#pragma mark-TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section ==0){
        return 1;
    }else {
        return 4;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID] autorelease];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        UIImageView * moreImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_orange.png"]];
//        moreImageview.frame = CGRectMake(270.0f, 11.0f, 14.0f, 16.0f);
//        [cell.contentView addSubview:moreImageview];
//        [cell setBackgroundColor:[UIColor whiteColor]];
       // cell.contentView.backgroundColor = [UIColor darkGrayColor];
//        UIView *tempView = [[[UIView alloc] init] autorelease];
//        //tempView.backgroundColor = [UIColor darkGrayColor];
////        tempView.layer.cornerRadius = 5.0f;
////        tempView.layer.masksToBounds = YES;
////        tempView.opaque = NO;
//
//        [cell setBackgroundView:tempView];
//        cell.textLabel.backgroundColor = [UIColor clearColor];
       
       // cell.contentView.backgroundColor = [UIColor darkGrayColor];
    
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
    if(indexPath.section==0){
        cell.textLabel.text = [moreNameArray objectAtIndex:indexPath.row];
       
    }else {
        cell.textLabel.text = [moreNameArray objectAtIndex:indexPath.row+indexPath.section];

    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0&&indexPath.row ==0){
        
        ChangePasswordViewController * road =[[ChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:road animated:YES];
        [road release];
        
    }else if (indexPath.section==1&&indexPath.row==0) {
        
        FeedBackViewController * feedBack = [[FeedBackViewController alloc] init];
        feedBack.judge = @"more";
        [self.navigationController pushViewController:feedBack animated:YES];
        [feedBack release];
        
    }else if (indexPath.section==1&&indexPath.row ==1) {
        
        AboutDiiDyViewController*aboutDiidy = [[AboutDiiDyViewController alloc] initWithNibName:@"AboutDiiDyViewController" bundle:nil];
        [self.navigationController pushViewController:aboutDiidy animated:YES];
        [aboutDiidy release];
        
    }else if (indexPath.section==1&&indexPath.row==2) {
        
        NoviceGuidanceViewController * noviceGudice= [[NoviceGuidanceViewController alloc] init];
        noviceGudice.noviceGuidan = @"more";
         [self presentModalViewController:noviceGudice animated:NO];
        //[self.navigationController pushViewController:noviceGudice animated:YES];
        [noviceGudice release];
        
    }else if (indexPath.section==1&&indexPath.row ==3) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"确定要注销登陆吗？"
                                                       message:@""
                                                      delegate:self 
                                             cancelButtonTitle:@"确定" 
                                             otherButtonTitles:@"取消",nil ];
        [alert show];
        [alert release];

    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);  
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
        NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *plugin1 = [[NSMutableDictionary alloc]init];
        [plugin1 setObject:@"r"forKey:@"status"];
        [plugin1 setObject:@"" forKey:@"telephone"];
        [dictplist setObject:plugin1 forKey:@"statusDict"];
        [dictplist writeToFile:plistPath atomically:YES];
        [dictplist release];
        [plugin1 release];
        [self dismissModalViewControllerAnimated:NO];
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
#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRequestCompelte:) name:MORE_QUEST object:nil];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, -2.0f, 320.0f, 49.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0f,7.0f,50.0f,30.0f);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnORLandingView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f,0.0f,160.0f,44.0f)];
    centerLable.text = @"更 多";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0f];
    [self.navigationController.navigationBar addSubview:centerLable];
   
    self.moreNameArray = [NSArray  arrayWithObjects:@"密码修改",@"意见反馈",@"关于嘀嘀",@"新手引导",@"注销", nil];
    
    UITableView * moreTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    moreTableView.backgroundColor = [UIColor clearColor];
    moreTableView.backgroundView=nil;
    moreTableView.separatorColor = [UIColor colorWithRed:182.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1];
    moreTableView.delegate = self;
    moreTableView.dataSource = self;
    moreTableView.scrollEnabled = NO;
    moreTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:moreTableView];
    [moreTableView release];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    centerLable.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    topImageView.hidden = NO;
    returnButton.hidden = NO;
    centerLable.hidden = NO;

}

-(void)dealloc
{
    [centerLable release];
    [moreNameArray release];
    [whereLand release];
    [topImageView release];
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
