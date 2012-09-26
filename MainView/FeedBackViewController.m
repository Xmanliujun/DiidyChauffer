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
-(void)creatNavigationBar
{
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthbutton.frame=CGRectMake(260.0f, 5.0f, 55.0f, 35.0f);
    rigthbutton.tag = 200;
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [rigthbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rigthbutton setTitle:@"提交" forState:UIControlStateNormal];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(returnORSubmit:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.text = @"意见反馈";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0f];
    [self.navigationController.navigationBar addSubview:centerLable];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.tag = 201;
    returnButton.frame=CGRectMake(5.0f, 5.0f, 55.0f, 35.0f);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnORSubmit:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    [self creatNavigationBar];
    
    UILabel * landingLable = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 10.0f, 300.0f, 30.0f)];
    landingLable.text = @"您的意见将帮助我们改进产品和服务";
    landingLable.backgroundColor = [UIColor clearColor];
    landingLable.textColor = [UIColor orangeColor];
    landingLable.font = [UIFont fontWithName:@"Arial" size:16.0f];
    [self.view addSubview:landingLable];
    [landingLable release];
    
    UIImageView * textImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u165_normal.png"]];
    textImageView.frame = CGRectMake(6.0f, 40.f, 308.0f, 120.0f);
    [self.view addSubview:textImageView];
    [textImageView release];
    
    feedBackText = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 44.0f, 300.0f, 110.0f)];
    feedBackText.textColor = [UIColor blackColor];
    feedBackText.text = @"提几句建议吧。。。";
    [feedBackText becomeFirstResponder];
    feedBackText.returnKeyType = UIReturnKeyDefault;
    feedBackText.font = [UIFont fontWithName:@"Arial" size:14.0f];
    feedBackText.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:feedBackText];
}

-(void)viewWillDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    centerLable.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;

}
-(void)dealloc
{
    [centerLable release];
    [feedBackText release];
    [judge release];
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
