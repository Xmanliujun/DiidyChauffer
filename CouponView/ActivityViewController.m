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
@synthesize diidyTitle,diidyContent,eventName;
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
    topImageView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"优 惠 劵 列 表";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0, 5.0, 55.0, 35.0);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnCouponView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    
    self.eventName.text = self.diidyTitle;
    VerticallyAlignedLabel * activeLable = [[VerticallyAlignedLabel alloc] init];
    activeLable.frame = CGRectMake(0, 90, 320,460);
    activeLable.numberOfLines = 0;
    activeLable.text=self.diidyContent;
    activeLable.font = [UIFont fontWithName:@"Arial" size:14];
    activeLable.textColor = [UIColor whiteColor];
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
       
   
}
-(void)returnCouponView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)viewDidDisappear:(BOOL)animated
{
    centerLable.hidden = YES;
    topImageView.hidden = YES;
    returnButton.hidden = YES;
}
-(void)dealloc
{
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
