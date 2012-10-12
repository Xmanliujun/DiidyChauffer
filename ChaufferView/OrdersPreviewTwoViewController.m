//
//  OrdersPreviewTwoViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrdersPreviewTwoViewController.h"
#import "CONST.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "MainViewController.h"
#import "JSONKit.h"
@interface OrdersPreviewTwoViewController ()

@end

@implementation OrdersPreviewTwoViewController

@synthesize departureLable,departureTimeLable,numberOfPeopleLable,destinationLable,contactLable,mobilNumberLable,orderArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark-Button
-(void)returnFillOrderView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)submitOrders:(id)sender
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                   message:nil                                                 
                                                  delegate:self 
                                         cancelButtonTitle:@"取消" 
                                         otherButtonTitles:@"确认",nil];
    [alert show];
    [alert release];
    
}
#pragma mark-HttpDown
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
    }else {
        
        
        if ([self.departureTimeLable.text isEqualToString:@""]) {
            self.departureTimeLable.text = @"无";
        }
        
        if ([self.departureLable.text isEqualToString:@""]) {
            self.departureLable.text =@"无";
        }
        if ([self.numberOfPeopleLable.text isEqualToString:@""]) {
            self.numberOfPeopleLable.text = @"无";
        }
        if ([self.contactLable.text isEqualToString:@""]) {
            self.contactLable.text = @"无";
        }
        if ([self.destinationLable.text isEqualToString:@""]) {
            self.destinationLable.text = @"无";
        }
        if ([self.mobilNumberLable.text isEqualToString:@""]) {
            self.mobilNumberLable.text = @"无";
        }
        if ([self.contactLable.text isEqualToString:@""]) {
            self.contactLable.text = @"无";
        }
        

        NSString * baseUrl = [NSString stringWithFormat:SUBMITORDERS,self.departureTimeLable.text,self.departureLable.text,self.numberOfPeopleLable.text,self.destinationLable.text,self.mobilNumberLable.text,self.contactLable.text,@"无",ShareApp.mobilNumber];
        NSLog(@"%@",baseUrl);
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * url = [NSURL URLWithString:baseUrl];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setTimeOutSeconds:15.0];
        [request setDelegate:self];
        [request setTag:505];
        [request startAsynchronous];
    }
    
}
-(void)parseStringJson:(NSString *)str
{
//    NSDictionary * jsonParser =[str JSONValue];
    NSDictionary * jsonParser =[str objectFromJSONString];
    NSString * returenNews =[jsonParser objectForKey:@"r"];
    if ([returenNews isEqualToString:@"s"]) {
        
        MainViewController * main = [[MainViewController alloc] init];
        ShareApp.window.rootViewController = main;
        [main release];
        
        
        
    }else {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                       message:@"提交失败请重试"                                                 
                                                      delegate:self 
                                             cancelButtonTitle:nil 
                                             otherButtonTitles:@"确认",nil];
        [alert show];
        [alert release];
    }
    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    [self parseStringJson:[request responseString]];
}

#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0, 5.0, 55.0, 35.0);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnFillOrderView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"button3.png"] forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    rigthbutton.frame=CGRectMake(260.0f, 5.0f, 55.0f, 35.0f);
    [rigthbutton addTarget:self action:@selector(submitOrders:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
    self.departureLable.text =[self.orderArray objectAtIndex:0];//出发地
    self.departureTimeLable.text = [self.orderArray objectAtIndex:1];//出发时间
    self.numberOfPeopleLable.text =[self.orderArray objectAtIndex:2];//人数
    self.destinationLable.text = [self.orderArray objectAtIndex:3];//目的地
    self.contactLable.text = [self.orderArray objectAtIndex:4];//联系人
    self.mobilNumberLable.text = [self.orderArray objectAtIndex:5];//手机号码
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.font = [UIFont systemFontOfSize:17];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.text =@"订 单 预 览";
    [self.navigationController.navigationBar addSubview:centerLable];
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;
    centerLable.hidden = YES;
}
-(void)dealloc
{
    [contactLable release];
    [centerLable release];
    [departureLable release];
    [departureTimeLable release];
    [destinationLable release];
    [orderArray release];
    [mobilNumberLable release];
    [numberOfPeopleLable  release]; 
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
