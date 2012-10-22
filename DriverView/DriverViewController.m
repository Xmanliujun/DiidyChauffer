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
#import "JSONKit.h"
#import "DriveLocationViewController.h"
@interface DriverViewController ()

@end

@implementation DriverViewController
//@synthesize urlordering,urlpositionDriver;
@synthesize OrderStatus_request,DriverStatus_request,seeDrive_request;
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
    HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"正在定位我的司机...";
    // HUD.detailsLabelText=@"正在加载...";
    HUD.square=YES;
    [HUD show:YES];

    
    NSString * baseUrl = [NSString stringWithFormat:EXECORDERS,ShareApp.mobilNumber];
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HTTPRequest *request = [[HTTPRequest alloc] init];
    request.forwordFlag = 100;
    self.OrderStatus_request = request;
    self.OrderStatus_request.m_delegate = self;
    self.OrderStatus_request.hasTimeOut = YES;
    [request release];
    
    [self.OrderStatus_request requestByUrlByGet:baseUrl];


}

-(void)getDriverStatus
{
    
    NSString * baseUrlb = [NSString stringWithFormat:POSITIONDRIVER,ShareApp.mobilNumber];
    baseUrlb = [baseUrlb stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    HTTPRequest *request = [[HTTPRequest alloc] init];
    request.forwordFlag = 101;
    self.OrderStatus_request = request;
    self.OrderStatus_request.m_delegate = self;
    self.OrderStatus_request.hasTimeOut = YES;
    [request release];
    
    [self.OrderStatus_request requestByUrlByGet:baseUrlb];
}


-(void)parseStatusStringJson:(NSString*)str
{
    
    if (HUD){
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }
    

    NSArray* jsonParser =[str objectFromJSONString];

    
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
        NSArray* jsonParser =[str objectFromJSONString];
    
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



-(void)requFinish:(NSString *)requestString order:(int)nOrder{

    if ([requestString length]==0) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"请检查网络是否连接"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];
        
    }else{
        if(nOrder ==100){
            
            [self parseStringJson:requestString];
            
        }else if(nOrder ==101) {
            [self parseStatusStringJson:requestString];
        }else {
            [self parseStatusStringJson:requestString];
            
        }
    }



}
-(void)closeConnection
{
    
    if (HUD){
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)requesttimeout
{
  [self closeConnection];
}


- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
    [HUD release];
     HUD = nil;
}


#pragma Button Call
-(void)returnStartView:(id)sender
{
    [driveMap backToTheOriginalPosition];

}
-(void)seeDrivers:(id)sender
{

    if (driverStatus) {
        NSString * baseUrlk = [NSString stringWithFormat:POSITIONDRIVER,ShareApp.mobilNumber];
        baseUrlk = [baseUrlk stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        HTTPRequest *request = [[HTTPRequest alloc] init];
        request.forwordFlag = 110;
        self.seeDrive_request= request;
        self.seeDrive_request.m_delegate = self;
        self.seeDrive_request.hasTimeOut = YES;
        [request release];
        
        [self.OrderStatus_request requestByUrlByGet:baseUrlk];

    }
    
}
-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
   // [self dismissViewControllerAnimated:NO completion:nil];

}

#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    UIImageView* topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    [topImageView release];
    
    UIButton*rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    rigthbutton.frame=CGRectMake(260.0, 7.0, 50.0, 30.0);
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    [rigthbutton setTitle:@"主页" forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    UILabel *topCenterLable = [[UILabel alloc] initWithFrame:CGRectMake(120.0, 0.0, 100.0, 44.0)];
    topCenterLable.text = @"看司机";
    topCenterLable.textColor = [UIColor whiteColor];
    topCenterLable.backgroundColor = [UIColor clearColor];
    topCenterLable.textAlignment = NSTextAlignmentCenter;
    topCenterLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:topCenterLable];
    [topCenterLable release];
    
    driveMap =[[DriveLocationViewController alloc] init];
    driveMap.view.frame = CGRectMake(0.0f, 5.0f, 320.0f, 360.0f);
    [self.view addSubview:driveMap.view];
    
    UIButton * seeDriversButton = [UIButton buttonWithType:UIButtonTypeCustom];
    seeDriversButton.titleLabel.font =[UIFont fontWithName:@"Arial" size:14.0f];
    seeDriversButton.frame=CGRectMake(100.0f,375.f, 120.0f, 32.0f);
    [seeDriversButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [seeDriversButton  setBackgroundImage:[UIImage imageNamed:@"u56_normal.png.png"] forState:UIControlStateNormal];
    [seeDriversButton setTitle:@"看司机" forState:UIControlStateNormal];
    [seeDriversButton  addTarget:self action:@selector(seeDrivers:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seeDriversButton];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame=CGRectMake(270.0f,375.0f, 31.0f, 30.0f);
    [startButton  setBackgroundImage:[UIImage imageNamed:@"my_location_h.png"] forState:UIControlStateNormal];
    [startButton  setBackgroundImage:[UIImage imageNamed:@"my_location_l.png"] forState:UIControlStateHighlighted];
    [startButton  addTarget:self action:@selector(returnStartView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:14.0];
    [self.view addSubview:centerLable];
    UIImageView * promptImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transparent.png"]];
    promptImageView.frame = CGRectMake(0, 0, 320, 40);
    [promptImageView addSubview:centerLable];
    [self.view addSubview:promptImageView];
    [promptImageView release];
    
    [self getExecutionOrderStatus];
}

-(void)viewWillDisappear:(BOOL)animated{

    [self.OrderStatus_request closeConnection];

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
