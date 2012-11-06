//
//  NoviceGuidanceViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NoviceGuidanceViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
@interface NoviceGuidanceViewController ()

@end

@implementation NoviceGuidanceViewController
@synthesize noviceGuidan;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    couponPage.currentPage = page;
}

-(void)goMainView:(id)sender
{
    if ([self.noviceGuidan isEqualToString:@"main"]) {
        
        MainViewController * mainView = [[MainViewController alloc] init];
        ShareApp.window.rootViewController = mainView;
        [mainView release];
    }else {
        //[self.navigationController popViewControllerAnimated:YES];
        [self dismissModalViewControllerAnimated:NO];
    }
   
}
-(void)returnORMoreView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)creatScrollView
{
    UIImageView * firstImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"w01.png"]];
    firstImageView .frame = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
    
    UIImageView * secondImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"w02.png"]];
    secondImageView .frame = CGRectMake(320.0f, 0.0f, 320.0f, 480.0f);
    
//    UIImageView * threeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"w03.png"]];
//    threeImageView.frame = CGRectMake(640.0f, 0.0f, 320.0f, 480.0f);
    
    UIImageView * fourImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"w04.png"]];
    fourImageView .frame = CGRectMake(640.0f, 0.0f, 320.0f, 480.0f);
    
    
    UIButton * diidyButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [diidyButton setBackgroundImage:[UIImage imageNamed:@"button_down.png"] forState:UIControlStateNormal];
    if ([self.noviceGuidan isEqualToString:@"main"]) {
        
        [diidyButton setTitle:@"返回主页" forState:UIControlStateNormal];
        
    }else {
        
        [diidyButton setTitle:@"返回更多" forState:UIControlStateNormal];
    }
    
    diidyButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    diidyButton.frame=CGRectMake(770.0f, 320.0f, 70.0f, 35.0f);
    
    [diidyButton addTarget:self action:@selector(goMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
    scrollView.contentSize = CGSizeMake(320.0f*3,80.0f);
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    [scrollView addSubview:firstImageView];
    [scrollView addSubview:secondImageView];
   // [scrollView addSubview:threeImageView];
    [scrollView addSubview:fourImageView];
    [scrollView addSubview:diidyButton];
    [self.view addSubview:scrollView];
    
    [scrollView release];
    [firstImageView release];
    [secondImageView release];
  //  [threeImageView release];
    [fourImageView release];
    
    couponPage= [[UIPageControl alloc] init];
    
    couponPage.frame = CGRectMake(150.0f, 400.0f, 30.0f, 20.0f);
    couponPage.numberOfPages = 3;
    couponPage.currentPage = 0;
    [self.view addSubview:couponPage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.hidesBackButton = YES;
    //[self.navigationController setNavigationBarHidden:YES];
   
    [self creatScrollView];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    if ([self.noviceGuidan isEqualToString:@"main"]) {
        
        
    }else {
        
        topImageView.hidden = YES;
        returnButton.hidden = YES;
        centerLable.hidden = YES;
    }

    
}

-(void)dealloc
{
    [couponPage release];
    [centerLable release];
    [noviceGuidan release];
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
