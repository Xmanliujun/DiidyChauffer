//
//  ActivityViewController.m
//  DiidyChauffer
//
//  Created by diidy on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ActivityViewController.h"
#import "VerticallyAlignedLabel.h"
#import "CONST.h"
@interface ActivityViewController ()

@end

@implementation ActivityViewController
@synthesize diidyTitle,diidyContent,eventName,coponurl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setTheNavigationBar
{
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"优 惠 劵 列 表";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0, 7.0, 50.0, 30.0);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnCouponView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    
    self.eventName.text = self.diidyTitle;
    VerticallyAlignedLabel * activeLable = [[VerticallyAlignedLabel alloc] init];
    activeLable.frame = CGRectMake(0, 90, 320,460);
    activeLable.numberOfLines = 0;
    activeLable.text=self.diidyContent;
    activeLable.font = [UIFont fontWithName:@"Arial" size:14];
    activeLable.textColor = [UIColor blackColor];
    activeLable.verticalAlignment = VerticalAlignmentTop;
    activeLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:activeLable];
    [activeLable release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.navigationItem.hidesBackButton = YES;

    [self setTheNavigationBar];
    
     WebView  = [[UIWebView   alloc]initWithFrame: CGRectMake(0.0,0.0,320.0,416.0 )];
    [WebView setUserInteractionEnabled: YES ];
    [WebView setDelegate: self];
    [WebView setOpaque: NO ];
    //WebView.scalesPageToFit = YES;
    [self.view addSubview:WebView];
     NSURL* url = [[NSURL alloc ]initWithString :self.coponurl];
    [WebView loadRequest:[ NSURLRequest requestWithURL: url ]];
    
    
    opaqueview = [[UIView  alloc]initWithFrame:CGRectMake(0.0,0.0,320.0,416.0)];
    activityIndicator  = [[UIActivityIndicatorView  alloc]  initWithFrame: CGRectMake(0.0f,0.0f,60.0f,60.0f)];
    [activityIndicator  setCenter :  opaqueview. center];
    [activityIndicator  setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite];
    [opaqueview  setBackgroundColor:[UIColor blackColor]];
    
    [opaqueview setAlpha:0.6];
    [opaqueview  addSubview :activityIndicator];
    [self.view  addSubview : opaqueview];
    
}

- (void )webViewDidFinishLoad:(UIWebView *)webView {
    
    [activityIndicator stopAnimating];
    opaqueview.hidden  = YES ;
}



- (void )webViewDidStartLoad:(UIWebView *)webView {
    
    [activityIndicator startAnimating ];
    opaqueview.hidden  = NO ;
    
}


-(void)returnCouponView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    centerLable.hidden = YES;
    topImageView.hidden = YES;
    returnButton.hidden = YES;
}
-(void)dealloc
{
    [coponurl release];
    [centerLable release];
    [diidyTitle release];
    [diidyContent release];
    [eventName release];
    [topImageView release];
    [super dealloc];
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
