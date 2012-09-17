//
//  FeedBackViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FeedBackViewController.h"
#import "AppDelegate.h"
#import "CONST.h"
#import "SBJson.h"
@interface FeedBackViewController ()

@end

@implementation FeedBackViewController
@synthesize judge;
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
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rightButton.tag = 200;
    rightButton.frame=CGRectMake(240.0, 4.0, 70.0, 35.0);
    [rightButton addTarget:self action:@selector(returnORSubmit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* logItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = logItem;    
    [logItem release];
    
    UIButton * leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"u13_normal.png"] forState:UIControlStateNormal];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    leftButton.frame=CGRectMake(0.0f, 100.0, 70.0, 35.0);
    leftButton.tag = 201;
    [leftButton addTarget:self action:@selector(returnORSubmit:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];
    
}
-(void)returnORSubmit:(UIButton*)sender
{

    if (sender.tag==201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        NSString * baseUrl = [NSString stringWithFormat:FEEDBACK,ShareApp.mobilNumber,feedBackText.text]; 
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * url = [NSURL URLWithString:baseUrl];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        NSLog(@"%@",url);
        [request setDelegate:self];
        [request startAsynchronous];
        [self.navigationController popViewControllerAnimated:YES];
        
    }

}

-(void)parseStringJson:(NSString *)str
{
    NSLog(@"%@",str);
    NSDictionary * jsonParser =[str JSONValue];
    NSString * returenNews =[jsonParser objectForKey:@"r"];
     NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:returenNews,@"return", nil];
    if ([self.judge isEqualToString:@"more"]) {
         [[NSNotificationCenter defaultCenter] postNotificationName:MORE_QUEST object:self userInfo:dict];
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:REQUEST_COMPLETE object:self userInfo:dict];
    }
       
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self parseStringJson:[request responseString]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.navigationItem.hidesBackButton = YES;
    UILabel * landingLable = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 10.0f, 300.0f, 30.0f)];
    landingLable.text = @"您的意见将帮助我们改进产品和服务";
    landingLable.backgroundColor = [UIColor clearColor];
    landingLable.font = [UIFont fontWithName:@"Arial" size:16.0f];
    [self.view addSubview:landingLable];
    [landingLable release];
    
    UIImageView * textImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u165_normal.png"]];
    textImageView.frame = CGRectMake(6.0f, 40.f, 308.0f, 120.0f);
    [self.view addSubview:textImageView];
    
    feedBackText = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 44.0, 300.0, 110.0)];
    feedBackText.textColor = [UIColor blackColor];
    feedBackText.text = @"";
    [feedBackText becomeFirstResponder];
    feedBackText.returnKeyType = UIReturnKeyDefault;
    feedBackText.font = [UIFont fontWithName:@"Arial" size:14.0];
    feedBackText.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:feedBackText];
    
    [self creatNavigationBar];
}
-(void)dealloc
{
    [judge release];
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
