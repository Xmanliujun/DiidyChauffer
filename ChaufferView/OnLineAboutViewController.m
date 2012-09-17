//
//  OnLineAboutViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OnLineAboutViewController.h"
#import "SearchDepartureViewController.h"
#import "AppDelegate.h"
#import "FillOrdersViewController.h"
#import "MainViewController.h"
#import "MapViewController.h"
#import "LocationDemoViewController.h"
@interface OnLineAboutViewController ()

@end

@implementation OnLineAboutViewController

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
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"在线约";
    self.hidesBottomBarWhenPushed = YES;
       
    self.tabBarController.tabBar.hidden = YES;
    
    UIImage * rigthImage =[UIImage imageNamed:@"u966_normal.png"];
    UIButton *rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:rigthImage forState:UIControlStateNormal];
    rigthbutton.frame=CGRectMake(0.0, 100.0, rigthImage.size.width, rigthImage.size.height);
    [rigthbutton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithCustomView:rigthbutton];
    self.navigationItem.rightBarButtonItem = nextItem;
    [nextItem release];

    
    startAddrSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 41)];  
    startAddrSearchBar.delegate = self;  
    startAddrSearchBar.barStyle = UIBarStyleDefault;  
    startAddrSearchBar.showsSearchResultsButton = YES;
    startAddrSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;  
    startAddrSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;  
    startAddrSearchBar.placeholder = @"您也可以在此搜索出发地....";  
    startAddrSearchBar.keyboardType =  UIKeyboardTypeDefault;  
    
    UIView *segment = [startAddrSearchBar.subviews objectAtIndex:0];  
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u0_normal.png"]];  
    [segment addSubview: bgImage];  
    [bgImage release];
    [self.view addSubview:startAddrSearchBar]; 
    
//    MapViewController * map =[[MapViewController alloc] init];
//    map.LocationDelegate = self;
//    map.view.frame = CGRectMake(0.0f, 40.0f, 320.0f, 420.0f);
//    [self.view addSubview:map.view];
    LocationDemoViewController* location = [[LocationDemoViewController alloc] init];
    location.LocationDelegate = self;
    location.view.frame =CGRectMake(0.0f, 40.0f, 320.0f, 420.0f);
    [self.view addSubview:location.view];
     
   
  
}
-(void)returnMainView:(id)sender
{
     MainViewController * main = [[MainViewController alloc] init];
    [ShareApp.window setRootViewController:main];
    [main release];

}

-(void)selectTheCurrentLocationOnLine:(NSString *)text
{
    if([ShareApp.logInState isEqualToString:@"s"]){
        
        FillOrdersViewController * fillOrder = [[FillOrdersViewController alloc] initWithDeparture:text];
        UINavigationController * fillNa = [[UINavigationController alloc] initWithRootViewController:fillOrder];
        fillOrder.landed = YES;
        [self presentModalViewController:fillNa animated:NO];
        [fillNa release];
        [fillOrder release];
    }else {
        FillOrdersViewController * fillOrder = [[FillOrdersViewController alloc] initWithDeparture:text];
        UINavigationController * fillNa = [[UINavigationController alloc] initWithRootViewController:fillOrder];
        fillOrder.landed = NO;
       
        [self presentModalViewController:fillNa animated:NO];
        [fillNa release];
        [fillOrder release];
        
    }

}
-(void)returnLandingView:(id)sender
{

  }
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    SearchDepartureViewController * search =[[SearchDepartureViewController alloc] init];
    UINavigationController * seachNa = [[UINavigationController alloc] initWithRootViewController:search];
    
    [self presentModalViewController:seachNa animated:NO];
    [seachNa release];
    [search release];
    return NO;
    
    
}
-(void)dealloc
{
    [startAddrSearchBar release]; 
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
