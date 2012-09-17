//
//  EditDepartureViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditDepartureViewController.h"

@interface EditDepartureViewController ()

@end

@implementation EditDepartureViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    
	UILabel *centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    centerLable.font = [UIFont systemFontOfSize:17];
    centerLable.textColor = [UIColor blackColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.text = @"编 辑 出 发 地";
    self.navigationItem.titleView = centerLable;
    [centerLable release]; 

    UILabel *departureLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 30)];
    departureLable.font = [UIFont systemFontOfSize:14];
    departureLable.textColor = [UIColor blackColor];
    departureLable.backgroundColor = [UIColor clearColor];
    departureLable.textAlignment = UITextAlignmentLeft;
    departureLable.text = @"出发地:";
    [self.view addSubview:departureLable];
    [departureLable release];
    
    
    displayLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 300, 60)];
    displayLable.font = [UIFont systemFontOfSize:14];
    displayLable.textColor = [UIColor blackColor];
    displayLable.textAlignment = UITextAlignmentLeft;
    [self.view addSubview:displayLable];
    
    
    UILabel *peripheryLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 120, 30)];
    peripheryLable.font = [UIFont systemFontOfSize:14];
    peripheryLable.textColor = [UIColor blackColor];
    peripheryLable.backgroundColor = [UIColor clearColor];
    peripheryLable.textAlignment = UITextAlignmentLeft;
    peripheryLable.text = @"周边:";
    [self.view addSubview:peripheryLable];
    [peripheryLable release];
    
    UIImageView * lineImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    lineImageView.frame = CGRectMake(0,168, 320, 3);
    [self.view addSubview:lineImageView];
    [lineImageView release];
    
    UITableView * orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 170, 320, self.view.bounds.size.height -45) style:UITableViewStylePlain];
    orderTableView.separatorColor = [UIColor grayColor];
    orderTableView.separatorStyle =UITableViewCellEditingStyleNone;
    orderTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    [orderTableView setSeparatorColor:[UIColor blackColor]];
    [self.view addSubview:orderTableView];
    [orderTableView release];
    
    UIButton *rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"u927_normal.png"] forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rigthbutton setTitle:@"确定" forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rigthbutton.frame=CGRectMake(0.0, 100.0, 65.0, 34.0);
    [rigthbutton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        
        UIImageView * lineImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
        lineImage.frame = CGRectMake(0,44, 320, 3);
        [cell.contentView addSubview:lineImage];
        
    }
    cell.imageView.image = [UIImage imageNamed:@"u899_normal.png"];
    return cell;
}
-(void)dealloc
{
    [displayLable release];
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
