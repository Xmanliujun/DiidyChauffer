//
//  FromPossibleViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FromPossibleViewController.h"
#import "OnLineAboutViewController.h"
@interface FromPossibleViewController ()

@end

@implementation FromPossibleViewController
@synthesize possibleCity;
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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *returnButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton  setBackgroundImage:[UIImage imageNamed:@"u108_normalp.png"] forState:UIControlStateNormal];
    [returnButton  setTitle:@"返回" forState:UIControlStateNormal];
    returnButton .titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton .frame=CGRectMake(0.0, 100.0, 43.0, 25.0);
    [returnButton  addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:returnButton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];
    
    
    UILabel *centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    centerLable.font = [UIFont systemFontOfSize:15];
    centerLable.textColor = [UIColor darkGrayColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.text = @"选择可能的出发地";
    self.navigationItem.titleView = centerLable;
    [centerLable release]; 
    
    UITableView * possibleTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
     possibleTableView.separatorColor = [UIColor grayColor];
     possibleTableView.separatorStyle =UITableViewCellEditingStyleNone;
     possibleTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
     possibleTableView.delegate = self;
     possibleTableView.dataSource = self;
     [possibleTableView  setSeparatorColor:[UIColor blackColor]];
     [self.view addSubview: possibleTableView ];
     [possibleTableView  release];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
        [lineImage release];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self dismissModalViewControllerAnimated:NO];

}

-(void)returnMainView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)dealloc
{
    [possibleCity release];
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
