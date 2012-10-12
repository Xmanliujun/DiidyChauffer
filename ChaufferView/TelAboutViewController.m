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
    UIActionSheet *menu = [[[UIActionSheet alloc]
                           initWithTitle:nil
                           delegate:self
                           cancelButtonTitle:@"取消"
                           destructiveButtonTitle:@"400 696 0666"
                           otherButtonTitles:nil] autorelease];
    [menu showInView:self.view];



}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:@"tel:4006960666"];
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.view addSubview:callWebview]; 
        [callWebview release];
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
    topImageView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    [topImageView release];
    
    UILabel *centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    centerLable.font = [UIFont fontWithName:@"Arial" size:17];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.text = @"电 话 约";
    self.navigationItem.titleView = centerLable;
    [centerLable release]; 
    
    UIImage * rigthImage =[UIImage imageNamed:@"33.png"];
    UIButton *rigthBarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthBarbutton setBackgroundImage:rigthImage forState:UIControlStateNormal];
    [rigthBarbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    rigthBarbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [rigthBarbutton setTitle:@"主页" forState:UIControlStateNormal];
    rigthBarbutton.frame=CGRectMake(260.0, 5.0, 55.0, 35.0);
    [rigthBarbutton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBarbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];
    
    
    UIImage * telImage = [UIImage imageNamed:@"call_btn_d.png"];
    UIButton * telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    telButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    telButton.frame=CGRectMake(90.0, 250.0, 140.0, 40.0);
    [telButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [telButton setBackgroundImage:telImage forState:UIControlStateNormal];
    //[telButton setTitle:@"4006-960-666" forState:UIControlStateNormal];
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
