//
//  DriverViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DriverViewController.h"
#import "CONST.h"
#import "SBJson.h"
#import "AppDelegate.h"

#import "DriveLocationViewController.h"
@interface DriverViewController ()

@end

@implementation DriverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)getExecutionOrderStatus
{
    NSString * baseUrl = [NSString stringWithFormat:EXECORDERS,ShareApp.mobilNumber];
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:baseUrl];
    requestOrderStatus = [ASIHTTPRequest requestWithURL:url];
    [requestOrderStatus setTag:100];
    [requestOrderStatus setDelegate:self];
    [requestOrderStatus startAsynchronous];


}
-(void)getDriverStatus
{
    NSString * baseUrl = [NSString stringWithFormat:POSITIONDRIVER,ShareApp.mobilNumber];
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:baseUrl];
    requestDriveStatus = [ASIHTTPRequest requestWithURL:url];
    [requestDriveStatus setTag:101];
    [requestDriveStatus setDelegate:self];
    [requestDriveStatus startAsynchronous];

}


-(void)parseStatusStringJson:(NSString*)str
{ 
    
    NSArray* jsonParser =[str JSONValue];
    
    if ([jsonParser count]==5) {
        centerLable.text = @"正在为您分派司机，目前暂时无法定位司机位置";

    }else {
        NSDictionary * jsonParserDict = [jsonParser objectAtIndex:0];
        
        NSString* status = [jsonParserDict objectForKey:@"status"];
        NSString* driver = [jsonParserDict objectForKey:@"driver"];
        NSString* geo = [jsonParserDict objectForKey:@"geo"];
        
        NSString* mobile =[jsonParserDict objectForKey:@"mobile"];
        NSString*leader = [jsonParserDict objectForKey:@"leader"];
        if(![status isEqualToString:@""])
        {
            driverStatus = YES;
            NSArray * geoArray= [geo componentsSeparatedByString:@","];
            double Latitude = [[geoArray objectAtIndex:1] doubleValue];
            double Longtitude = [[geoArray objectAtIndex:0] doubleValue];
            if (![leader isEqualToString:@""]) {
                
                centerLable.text =@"您的司机正在赶路，一会儿见";
                [driveMap initWithTitle:driver withSubtitle:mobile withLatitude:Latitude  withLongtitude:Longtitude];
                
            }else {
                [driveMap  initWithTitle:@"带队司机" withSubtitle:mobile withLatitude:Latitude withLongtitude:Longtitude];
            }
            
        }else {
            driverStatus = NO;
            centerLable.text = @"正在为您分派司机，目前暂时无法定位司机位置";
        }

    }
    
   
   
}
-(void)parseStringJson:(NSString *)str
{
    
    NSString * status;
    NSArray* jsonParser =[str JSONValue];
    NSLog(@"收拾收拾%@",jsonParser);
    for(int i = 0;i<[jsonParser count];i++){
        NSDictionary * diidyDict = [jsonParser objectAtIndex:i];
                
        NSString* currentStatus = [diidyDict objectForKey:@"status"];
        if([currentStatus floatValue]>=1.0&&[currentStatus floatValue]<=4.0){
            status = @"已受理";
        }else if ([currentStatus floatValue]==5.0) {
            status = @"完成";
        }else {
           status = @"已取消";
        }
        
    }
    if([status isEqualToString:@"已受理"]){
    
        [self getDriverStatus];
        
        
    }else {
        driverStatus = NO;
        centerLable.text = @"您目前尚未预约代驾司机";
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"%@",[request responseString]);
    
    if(request.tag ==100){
       
        [self parseStringJson:[request responseString]];
    }else if(request.tag ==101) {

        [self parseStatusStringJson:[request responseString]];
    }else {
        [self parseStatusStringJson:[request responseString]];

    }
}
-(void)requestFailed:(ASIHTTPRequest *)request
{

    NSLog(@"7654321");

}
#pragma Button Call
-(void)returnStartView:(id)sender
{
    [driveMap backToTheOriginalPosition];

}
-(void)seeDrivers:(id)sender
{
   // [driveMap initWithTitle:nil withSubtitle:nil withLatitude:0 withLongtitude:0];
    if (driverStatus) {
        NSString * baseUrl = [NSString stringWithFormat:POSITIONDRIVER,ShareApp.mobilNumber];
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * url = [NSURL URLWithString:baseUrl];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setTag:110];
        [request setDelegate:self];
        [request startAsynchronous];
    }
    
}
-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];

}

#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    UIImageView* topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    [topImageView release];
    
    UIButton*rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    rigthbutton.frame=CGRectMake(260.0, 5.0, 55.0, 35.0);
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    [rigthbutton setTitle:@"主页" forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    UILabel *topCenterLable = [[UILabel alloc] initWithFrame:CGRectMake(120.0, 0.0, 100.0, 44.0)];
    topCenterLable.text = @"看司机";
    topCenterLable.textColor = [UIColor orangeColor];
    topCenterLable.backgroundColor = [UIColor clearColor];
    topCenterLable.textAlignment = UITextAlignmentCenter;
    topCenterLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:topCenterLable];
    [topCenterLable release];
    
    
    driveMap =[[DriveLocationViewController alloc] init];
    driveMap.view.frame = CGRectMake(0.0f, 40.0f, 320.0f, 340.0f);
    [self.view addSubview:driveMap.view];
    
    UIButton * seeDriversButton = [UIButton buttonWithType:UIButtonTypeCustom];
    seeDriversButton.titleLabel.font =[UIFont fontWithName:@"Arial" size:14.0f];
    seeDriversButton.frame=CGRectMake(100.0f,380.f, 120.0f, 32.0f);
    [seeDriversButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [seeDriversButton  setBackgroundImage:[UIImage imageNamed:@"u56_normal.png.png"] forState:UIControlStateNormal];
    [seeDriversButton setTitle:@"看司机" forState:UIControlStateNormal];
    [seeDriversButton  addTarget:self action:@selector(seeDrivers:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seeDriversButton];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame=CGRectMake(270.0f,383.f, 31.0f, 30.0f);
    [startButton  setBackgroundImage:[UIImage imageNamed:@"u62_normal.png"] forState:UIControlStateNormal];
    [startButton  addTarget:self action:@selector(returnStartView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:14.0];
    [self.view addSubview:centerLable];
//    UIImageView * promptImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u16_dnormal.png"]];
//    promptImageView.frame = CGRectMake(0, 0, 320, 40);
//    [promptImageView addSubview:centerLable];
//    [self.view addSubview:promptImageView];
//    [promptImageView release];
    
    [self getExecutionOrderStatus];
}


-(void)dealloc
{
    [driveMap release];
    [centerLable release];
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
