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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.title = @"电话约";
   
    UIImage * rigthImage =[UIImage imageNamed:@"u966_normal.png"];
    UIButton *rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:rigthImage forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rigthbutton.frame=CGRectMake(0.0, 100.0, rigthImage.size.width, rigthImage.size.height);
    [rigthbutton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];

    
    
    UIImage * telImage = [UIImage imageNamed:@"u75_normal.png"];
    UIButton * telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    telButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    telButton.frame=CGRectMake(20.0, 250.0, telImage.size.width, telImage.size.height);
    [telButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [telButton setBackgroundImage:telImage forState:UIControlStateNormal];
    [telButton setTitle:@"4006-960-666" forState:UIControlStateNormal];
    [telButton addTarget:self action:@selector(makeACall:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:telButton];

}
-(void)makeACall:(id)sender
{
    UIActionSheet *menu = [[UIActionSheet alloc]
                           initWithTitle:nil
                           delegate:self
                           cancelButtonTitle:@"取消"
                           destructiveButtonTitle:@"400 696 0666"
                           otherButtonTitles:nil];
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
        [actionSheet release];
    }else {
        [actionSheet release];
    }
    
}

-(void)returnMainView:(id)sender
{
    
    MainViewController * main = [[MainViewController alloc] init];
    [ShareApp.window setRootViewController:main];
    [main release];


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
