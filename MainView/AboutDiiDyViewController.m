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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    self.navigationItem.hidesBackButton = YES;
    self.title =@"关于滴滴";
    
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

}
-(void)returnORMoreView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

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
