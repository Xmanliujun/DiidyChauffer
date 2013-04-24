//
//  FromPossibleViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FromPossibleViewController.h"
#import "OnLineAboutViewController.h"
#import "BMapKit.h"
#import "MathViewController.h"
#import "TelAboutViewController.h"
#import "custom_tabbar.h"
#import "AppDelegate.h"
@interface FromPossibleViewController ()

@end

@implementation FromPossibleViewController
@synthesize possibleCity,possibleCityArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKPoiInfo * bmn = [self.possibleCityArray objectAtIndex:indexPath.row];
    NSString * cityName =bmn.name;
    NSString* addressd = bmn.address;
    
    CGSize size = [addressd sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(245, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    CGSize size2 = [cityName sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(260, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    if (size.height>22&&size2.height>22) {
        
        return size.height+size2.height;
        
    }else if(size.height<22&&size2.height>22){
        
        return 22.0+size2.height;
        
    }else if(size.height>22&&size2.height<22){
        
        return size.height+22;
        
    }else {
        
        return 44;
    }
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"sssssss   %@",tableView.dataSource);
    return [self.possibleCityArray count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
   
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView * startImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start.png"]];
        startImageView.tag = 80;
        startImageView.frame = CGRectMake(10.0, 0.0, 30.0, 44.0);
        [cell.contentView addSubview:startImageView];
        [startImageView release];
        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(50.0, 0.0, 260.0,22.0)];
        nameLable.numberOfLines = 0;
       // nameLable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
        nameLable.backgroundColor =[UIColor clearColor];
        nameLable.font = [UIFont fontWithName:@"Arial" size:14];
        nameLable.textColor = [UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1];
        nameLable.tag = 81;
        [cell.contentView addSubview:nameLable];
        [nameLable release];
        
        UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(50.0,22.0, 245.0,22.0)];
        addressLable.numberOfLines = 0;
       // addressLable.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
        addressLable.backgroundColor = [UIColor clearColor];
        addressLable.font = [UIFont fontWithName:@"Arial" size:12];
        addressLable.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
        addressLable.tag = 82;
        [cell.contentView addSubview:addressLable];
        [addressLable release];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    BMKPoiInfo * bmn = [self.possibleCityArray objectAtIndex:indexPath.row];
    NSString * cityName =bmn.name;
    NSString* addressd = bmn.address;
    
    CGSize size = [addressd sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(245, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    CGSize size1 = [cityName sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(260, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    UILabel * nameLable = (UILabel *)[cell.contentView viewWithTag:81];
   
    if (size1.height>22) {
        
        nameLable.frame = CGRectMake(50,0, 270,size1.height);
        
    }else {
        
         nameLable.frame = CGRectMake(50,0, 270,22);
        
    }
         nameLable.text = cityName;
    
    
    UILabel * addressLable = (UILabel*)[cell.contentView viewWithTag:82];
    
    if (size.height <22) {
        
        addressLable.frame = CGRectMake(50,nameLable.frame.size.height, 245,22);
        
    }else {
        
         addressLable.frame = CGRectMake(50,nameLable.frame.size.height, 245,size.height);
        
    }
   
        addressLable.text = addressd;
  
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BMKPoiInfo * bmn = [self.possibleCityArray objectAtIndex:indexPath.row];
    CLLocationCoordinate2D ptCenter = bmn.pt;
    NSString * cityName =bmn.name;
   
    TelAboutViewController * chau = [[[TelAboutViewController alloc] init] autorelease];
    ShareApp.pageManageMent = @"chauffer";
    
    UINavigationController * na = [[[UINavigationController alloc] initWithRootViewController:chau] autorelease];
    
    OnLineAboutViewController * online = [[[OnLineAboutViewController alloc] init] autorelease];
    online.possible = NO;
    online.coupossible=YES;
    online.possibleLocation = ptCenter;
    online.cityName = cityName;
    UINavigationController * onlineNa = [[[UINavigationController alloc] initWithRootViewController:online] autorelease];
    
    MathViewController *math = [[[MathViewController alloc] init] autorelease];
    UINavigationController * mathNa = [[[UINavigationController alloc] initWithRootViewController:math] autorelease];
        
    NSArray *viewControllerArray = [[[NSArray alloc] initWithObjects:na,onlineNa, mathNa, nil] autorelease];
    
    custom_tabbar * tabController  = [[custom_tabbar alloc] init];
    tabController.viewControllers = viewControllerArray;
    tabController.selectedIndex = 1;
    [ShareApp.window setRootViewController:tabController];
    
}

-(void)returnMainView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - System Approach

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0, 7.0, 50.0, 30.0);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.font = [UIFont systemFontOfSize:15.0f];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.text = @"选择可能的出发地";
    [self.navigationController.navigationBar addSubview:centerLable];
    
    CGRect rect = CGRectMake(0.0, 0.0, 320.0, 460.0-44.0);
        
    UITableView * possibleTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    possibleTableView.scrollEnabled = YES;
    possibleTableView.separatorColor =  [UIColor colorWithRed:182.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1];
    possibleTableView.backgroundColor = [UIColor clearColor];
    possibleTableView.delegate = self;
    possibleTableView.dataSource = self;
    [self.view addSubview: possibleTableView];
    [self setExtraCellLineHidden:possibleTableView];

    [possibleTableView  release];
        
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    centerLable.hidden = YES;

}
-(void)dealloc
{
    [centerLable release]; 
    [topImageView release];
    [possibleCityArray release];
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
