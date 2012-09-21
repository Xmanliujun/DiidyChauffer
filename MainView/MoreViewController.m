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
@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize moreNameArray;
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
    if (sender.tag==201) {
        [self dismissModalViewControllerAnimated:NO];
    }else {
        
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationItem.hidesBackButton = YES;   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRequestCompelte:) name:MORE_QUEST object:nil];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0, 5.0, 55.0, 35.0);
    returnButton.tag = 201;
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnORLandingView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"更 多";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
    [centerLable release];

    self.moreNameArray = [NSArray  arrayWithObjects:@"密码修改",@"意见反馈",@"关于滴滴",@"新手引导",@"注销", nil];
    
    UITableView * moreTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    moreTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    [moreTableView setSeparatorColor:[UIColor blackColor]];
    moreTableView.delegate = self;
    moreTableView.dataSource = self;
    [self.view addSubview:moreTableView];
    [moreTableView release];
    
    }
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        cell.backgroundColor = [UIColor whiteColor];
    
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    }else if (indexPath.section==1&&indexPath.row ==1) {
        AboutDiiDyViewController*aboutDiidy = [[AboutDiiDyViewController alloc] initWithNibName:@"AboutDiiDyViewController" bundle:nil];
        [self.navigationController pushViewController:aboutDiidy animated:YES];
    }else if (indexPath.section==1&&indexPath.row==2) {
        NoviceGuidanceViewController * noviceGudice= [[NoviceGuidanceViewController alloc] init];
        noviceGudice.noviceGuidan = @"more";
        [self.navigationController pushViewController:noviceGudice animated:YES];
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

-(void)viewWillDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    centerLable.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    topImageView.hidden = NO;
    returnButton.hidden = NO;
    centerLable.hidden = NO;

}
-(void)dealloc
{
   
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
