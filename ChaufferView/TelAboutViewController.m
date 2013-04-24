//
//  TelAboutViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TelAboutViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "MobClick.h"
@interface TelAboutViewController ()

@end

@implementation TelAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)makeACall:(id)sender
{
    [MobClick event:@"m03_d001_0001"];

    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel:4006960666"];
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
    [callWebview release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(buttonIndex==0){
        
             // [actionSheet release];
    }else {
       // [actionSheet release];
    }
    
}

-(void)returnMainView:(id)sender
{
    
    MainViewController * main = [[MainViewController alloc] init];
    [ShareApp.window setRootViewController:main];
    [main release];


}
#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    UIImageView* topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    [topImageView release];
    
    UILabel *centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    centerLable.font = [UIFont fontWithName:@"Arial" size:17];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.text = @"电 话 约";
    self.navigationItem.titleView = centerLable;
    [centerLable release]; 
    
    UIImage * rigthImage =[UIImage imageNamed:@"33.png"];
    UIButton *rigthBarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthBarbutton setBackgroundImage:rigthImage forState:UIControlStateNormal];
    [rigthBarbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rigthBarbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    [rigthBarbutton setTitle:@"主页" forState:UIControlStateNormal];
    rigthBarbutton.frame=CGRectMake(260.0, 7.0, 50.0, 30.0);
    [rigthBarbutton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBarbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];
//    
//    UILabel *cententLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 280, 60)];
//    cententLable.numberOfLines = 0;
//    cententLable.font = [UIFont fontWithName:@"Arial" size:15];
//    cententLable.textColor = [UIColor blackColor];
//    cententLable.backgroundColor = [UIColor clearColor];
//    cententLable.textAlignment = NSTextAlignmentLeft;
//    cententLable.text = @"欢迎拨打400电话预约嘀嘀代驾,嘀嘀会为您选择最合适的司机";
//    [self.view addSubview:cententLable];
//    [centerLable release];
//
    
    UIImage * telImage = [UIImage imageNamed:@"orderDetail2.png"];
    UIImage*telImage2 = [UIImage imageNamed:@"orderDetail1.png"];
   
    UIButton * telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    telButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16.0f];
    telButton.frame=CGRectMake(87.0, 270.0, 146.0, 40.0);
    [telButton setTitle:@"4006 960 666" forState:UIControlStateNormal];
    [telButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [telButton setBackgroundImage:telImage2 forState:UIControlStateSelected];
    [telButton setBackgroundImage:telImage forState:UIControlStateNormal];
    [telButton addTarget:self action:@selector(makeACall:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:telButton];
    
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
