//
//  AboutDiiDyViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AboutDiiDyViewController.h"

@interface AboutDiiDyViewController ()

@end

@implementation AboutDiiDyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)versionUpGrades:(id)sender
{
    
    NSLog(@"dddd");
}
-(void)returnORMoreView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.navigationItem.hidesBackButton = YES;
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.text = @"意见反馈";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0f];
    [self.navigationController.navigationBar addSubview:centerLable];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.tag = 201;
    returnButton.frame=CGRectMake(5.0f, 5.0f, 55.0f, 35.0f);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnORMoreView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    [versionButton setTitle:@"检查更新" forState:UIControlStateNormal];
    [versionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    versionButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [versionButton setBackgroundImage:[UIImage imageNamed:@"button_down.png"] forState:UIControlStateNormal];
    [versionButton addTarget:self action:@selector(versionUpGrades:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    centerLable.hidden = YES;
    returnButton.hidden = YES;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc
{
    [centerLable release];
    [topImageView release];
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
