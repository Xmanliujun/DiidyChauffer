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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)creatScrollView
{
    UIImageView * firstImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"w01.png"]];
    firstImageView .frame = CGRectMake(0, 0, 320, 480);
    
    UIImageView * secondImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"w02.png"]];
    secondImageView .frame = CGRectMake(320, 0, 320, 480);
    
    UIImageView * threeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"w03.png"]];
    threeImageView.frame = CGRectMake(640, 0, 320, 480);
    
    UIImageView * fourImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"w04.png"]];
    fourImageView .frame = CGRectMake(960, 0, 320, 480);
    
    
    UIButton * diidyButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [diidyButton setBackgroundImage:[UIImage imageNamed:@"u13_normal.png"] forState:UIControlStateNormal];
    [diidyButton setTitle:@"返回" forState:UIControlStateNormal];
    diidyButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    diidyButton.frame=CGRectMake(960.0f, 300.0, 70.0, 35.0);
    
    [diidyButton addTarget:self action:@selector(goMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0.0, 0.0, 320.0, 480.0);
    scrollView.contentSize = CGSizeMake(320.0*4,80.0);
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    [scrollView addSubview:firstImageView];
    [scrollView addSubview:secondImageView];
    [scrollView addSubview:threeImageView];
    [scrollView addSubview:fourImageView];
    [scrollView addSubview:diidyButton];
    [self.view addSubview:scrollView];
    [scrollView release];
    
    couponPage= [[UIPageControl alloc] init];
    
    couponPage.frame = CGRectMake(150.0, 400.0, 30.0, 20.0);
    couponPage.numberOfPages = 4;
    couponPage.currentPage = 0;
    [self.view addSubview:couponPage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.hidesBackButton = YES;
    self.title = @"新手指导";
   
    UIButton * leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"u13_normal.png"] forState:UIControlStateNormal];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    leftButton.frame=CGRectMake(0.0f, 100.0, 70.0, 35.0);
    leftButton.tag = 201;
    [leftButton addTarget:self action:@selector(returnORMoreView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];
    
    [self creatScrollView];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    couponPage.currentPage = page;
    
    
}

-(void)goMainView:(id)sender
{
    MainViewController * mainView = [[MainViewController alloc] init];
    ShareApp.window.rootViewController = mainView;
    [mainView release];

}
-(void)returnORMoreView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

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
