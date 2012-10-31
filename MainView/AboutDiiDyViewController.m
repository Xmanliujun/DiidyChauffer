//
//  AboutDiiDyViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AboutDiiDyViewController.h"
#import "CONST.h"
#import "JSONKit.h"
#import "Reachability.h"
@interface AboutDiiDyViewController ()

@end

@implementation AboutDiiDyViewController
@synthesize delegate;
@synthesize aboutDiidy_request,main_request;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

int my_strcmp(const char *s1,const char *s2){
    while((*s2 == *s1)&& *s2)
    {
        s1++;
        s2++;}
      return *s1-*s2;
    
}
char* getoutpoint(char* s)
{
    int i, j,len = strlen(s);
    char* out =malloc(len);
    for(i=0,j=0; i<len;i++)
    {
        if(*(s+i)!='.')
        {
            out[j]= *(s+i);
           
            j++;
            
        }
    }
    out[j] = '\0';
    return out;
}
char* getlf(char* s)
{
    int i, j,len = strlen(s);
    char* out =malloc(len);
    for(i=0,j=0; i<len;i++)
    {
        if(*(s+i)!='\n')
        {
            out[j]= *(s+i);
            
            j++;
            
        }
    }
    out[j] = '\0';
    return out;
}
-(void)checkNewVersion
{
    NSString * baseUrl = [NSString stringWithFormat:@"%@",VERSION];
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
    HTTPRequest *request = [[HTTPRequest alloc] init];
    request.forwordFlag = 10;
    self.main_request = request;
    self.main_request.m_delegate = self;
    self.main_request.hasTimeOut = YES;
    [request release];
    
    [self.main_request requestByUrlByGet: baseUrl];

}


-(void)versionUpGrades:(id)sender
{
    
    Reachability * r =[Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([r currentReachabilityStatus]==0) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"联网失败,请稍后再试"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }else{

        HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.delegate=self;
        HUD.labelText=@"正在检查版本";
        //HUD.detailsLabelText=@"正在加载...";
        HUD.square=YES;
        [HUD show:YES];
    
        NSString * baseUrl = [NSString stringWithFormat:@"%@",VERSION];
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        HTTPRequest *request = [[HTTPRequest alloc] init];
        request.forwordFlag = 11;
        self.aboutDiidy_request = request;
        self.aboutDiidy_request.m_delegate = self;
        self.aboutDiidy_request.hasTimeOut = YES;
        [request release];
    
        [self.aboutDiidy_request requestByUrlByGet: baseUrl];
    }
}

#pragma DownLoad Parsing
-(void)parseNewStringJson:(NSString*)res
{
    
    char* responschar = (char*)[res UTF8String];
    char*nlf = getlf(responschar);
    char* point1 = getoutpoint(responschar);
    char* lf = getlf(point1);
    char *aaa = (char*)[CURRENTVERSION UTF8String];
    char* point2 = getoutpoint(aaa);
    
    res = [NSString stringWithFormat:@"%s",nlf];
    int returnJudge = my_strcmp(lf,point2);
    [self.delegate completeDownLoadVerson:returnJudge withVerson:res];

}
-(void)parseStringJson:(NSString*)responseString
{

    if (HUD){
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }

    char* responschar = (char*)[responseString UTF8String];
    char* point1 = getoutpoint(responschar);
    char* lf = getlf(point1);
    char *aaa = (char*)[CURRENTVERSION UTF8String];
    char* point2 = getoutpoint(aaa);

    int returnJudge = my_strcmp(lf,point2);
    if ([responseString length]==0) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"登陆失败"
                                                   message:@"请检查网络是否连接"
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil ];
        [alert show];
        [alert release];
        
    }else{
    
        if (returnJudge==0) {
            
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"您已是最新版本"
                                                      delegate:nil
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil ];
            [alert show];
            [alert release];
            
        }else{
            
            NSString * nerVer = [NSString stringWithFormat:@"检测到%@新版本",responseString];
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                           message:nerVer
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"更新新版本",nil ];
            [alert show];
            [alert release];

        }
    
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSString *webLink = @"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=4574";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webLink]];
    }else
    {
        
        
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


-(void)requFinish:(NSString *)requestString order:(int)nOrder
{
    
    if (nOrder==10) {
        
            [self parseNewStringJson:requestString];
        
    }else{
        
        if ([requestString length]==0) {
            
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"登陆失败"
                                                           message:@"请检查网络是否连接"
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil ];
            [alert show];
            [alert release];
        }else{

            [self parseStringJson:requestString];
            
        }
      
    }

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

-(void)returnORMoreView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)cancelConnection
{
    [self.main_request closeConnection];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.navigationItem.hidesBackButton = YES;
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, -2.0f, 320.0f, 49.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.text = @"关于嘀嘀";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0f];
    [self.navigationController.navigationBar addSubview:centerLable];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.tag = 201;
    returnButton.frame=CGRectMake(7.0f, 7.0f, 50.0f, 30.0f);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
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
    [super viewWillDisappear:animated];
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
