//
//  DetailPageViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailPageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CONST.h"
#import "AppDelegate.h"

@interface DetailPageViewController ()

@end

@implementation DetailPageViewController
@synthesize couponID,detailCoupon;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)creatGiftToFriendView
{
    
    UILabel * giftNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 10.0, 90.0, 40.0)];
    giftNumberLable.text = @"赠送给(手机号) :";
    giftNumberLable.backgroundColor = [UIColor clearColor];
    giftNumberLable.textAlignment = UITextAlignmentCenter;
    giftNumberLable.font = [UIFont fontWithName:@"Arial" size:12.0];
    
    UIImage * giftImage = [UIImage imageNamed:@"u84_line.png"];
    UIImageView * giftLineImage = [[UIImageView alloc] initWithImage:giftImage];
    giftLineImage.frame = CGRectMake(5.0, 55.0, 300.0, giftImage.size.height);
    
    giftNumberText = [[UITextView alloc] initWithFrame:CGRectMake(100.0, 12.0,160.0, 40.0)];
    giftNumberText.textColor = [UIColor blackColor];
    giftNumberText.text = @"";
    giftNumberText.returnKeyType = UIReturnKeyDefault;
    giftNumberText.font = [UIFont fontWithName:@"Arial" size:16.0];
    giftNumberText.keyboardType = UIKeyboardTypePhonePad;
        
    UIImage * determineImage = [UIImage imageNamed:@"u102_normal.png"];
    UIButton* determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    determineButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    determineButton.frame=CGRectMake(20.0,145.0 , determineImage.size.width, determineImage.size.height);
    [determineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [determineButton setBackgroundImage:determineImage forState:UIControlStateNormal];
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(determineSender:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImage *cancelImage = [UIImage imageNamed:@"u104_normal.png"];
    UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    cancelButton.frame=CGRectMake(170.0,145.0 , determineImage.size.width, determineImage.size.height);
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:cancelImage forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelSender:) forControlEvents:UIControlEventTouchUpInside];
    
    contentView = [[UITextView alloc] initWithFrame:CGRectMake(10.0,70.0,290.0, 70.0)];
    [contentView.layer setBorderColor: [[UIColor grayColor] CGColor]];      
    [contentView.layer setBorderWidth: 1.0];      
    [contentView.layer setCornerRadius:4.0f];      
    [contentView.layer setMasksToBounds:YES]; 
    contentView.textColor = [UIColor blackColor];
    
    NSString * content = [NSString stringWithFormat:@"您的朋友%@送您1张%@，喝酒了疲劳了不想开车了，记着找嘀嘀！记住电话4006960666,客户端约代驾更方便，+wap嘀嘀代驾客户端下载地址。",ShareApp.mobilNumber,self.detailCoupon];
    contentView.text = content;
    contentView.delegate = self;
    contentView.returnKeyType = UIReturnKeyDone;
    contentView.font = [UIFont fontWithName:@"Arial" size:14.0];
    contentView.keyboardType = UIKeyboardTypeDefault;
    
    giftFrientImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u97_normal.png"]];
    giftFrientImage.frame = CGRectMake(5.0,0.0, 310.0, 200.0);
    giftFrientImage.userInteractionEnabled = YES;
    giftFrientImage.hidden = YES;
    
    [giftFrientImage addSubview:contentView];
    [giftFrientImage addSubview:cancelButton];
    [giftFrientImage addSubview:determineButton];
    [giftFrientImage addSubview:giftNumberText];
    [giftFrientImage addSubview:giftLineImage];
    [giftFrientImage addSubview:giftNumberLable];
    [self.view addSubview:giftFrientImage];
    [giftNumberLable release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.navigationItem.hidesBackButton = YES;
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    detailCenterLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    detailCenterLable.text = @"优 惠 劵 详 情 页";
    detailCenterLable.textColor = [UIColor whiteColor];
    detailCenterLable.backgroundColor = [UIColor clearColor];
    detailCenterLable.textAlignment = UITextAlignmentCenter;
    detailCenterLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:detailCenterLable];

    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0, 5.0, 55.0, 35.0);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnDetailPageView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];

    
    
    UIImage * lineImage = [UIImage imageNamed:@"u84_line.png"];
    UIImageView * lineImageView =[[UIImageView alloc] initWithImage:lineImage];
    lineImageView.frame = CGRectMake(15.0, 100.0, lineImage.size.width, lineImage.size.height);
    [self.view addSubview:lineImageView];
    [lineImageView release];
    
    
    UIImage * nameImage = [UIImage imageNamed:@"u80_normal.png"];
    UIImageView * detailNameImage = [[UIImageView alloc] initWithImage:nameImage];
    detailNameImage.frame = CGRectMake(10.0, 12.0, nameImage.size.width, nameImage.size.height);
    [self.view addSubview:detailNameImage];
    [detailNameImage release];
    
    UILabel * detailLable = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 12.0, 140.0,75.0)];
    detailLable.backgroundColor = [UIColor clearColor];
    detailLable.textColor = [UIColor orangeColor];
    detailLable.font = [UIFont fontWithName:@"Arial" size:14.0];
    detailLable.text = detailCoupon;
    [self.view addSubview:detailLable];
    [detailLable release];
    
    UIButton*  presentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    presentionButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    presentionButton.frame=CGRectMake(10.0, 120.0, 124.0, 38.0);
    [presentionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [presentionButton setBackgroundImage:[UIImage imageNamed:@"u102_normal.png"] forState:UIControlStateNormal];
    [presentionButton setTitle:@"赠送" forState:UIControlStateNormal];
    [presentionButton addTarget:self action:@selector(pushGiftToFriendView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentionButton];

    UIButton* telFreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    telFreeButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    telFreeButton.frame=CGRectMake(180.0, 120.0, 124.0, 38.0);
    [telFreeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [telFreeButton setBackgroundImage:[UIImage imageNamed:@"u104_normal.png"] forState:UIControlStateNormal];
    [telFreeButton setTitle:@"400免费咨询电话" forState:UIControlStateNormal];
    [telFreeButton addTarget:self action:@selector(freeConsultationCalls:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:telFreeButton];

    UIImage * detailImage =[UIImage imageNamed:@"u88_normal.png"];
    UIImageView* detailImageView = [[UIImageView alloc] initWithImage:detailImage];
    detailImageView.frame = CGRectMake(10.0, 170.0, detailImage.size.width, detailImage.size.height);
    [self.view addSubview:detailImageView];
    

    [self creatGiftToFriendView];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [contentView resignFirstResponder];
    
    }
    return YES;

}
-(void)returnDetailPageView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)freeConsultationCalls:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel:4006960666"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview]; 

}
-(void)pushGiftToFriendView:(id)sender
{
    giftFrientImage.hidden = NO;
    [giftNumberText becomeFirstResponder];

}
-(void)cancelSender:(id)sender
{
    giftNumberText.text = @"";
    giftFrientImage.hidden = YES;
    [giftNumberText resignFirstResponder];
    [contentView resignFirstResponder];

}


- (void)displaySMSComposerSheet {
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    
    if (giftNumberText.text != nil) {
       NSString * content = [NSString stringWithFormat:@"您的朋友%@送您1张%@，喝酒了疲劳了不想开车了，记着找嘀嘀！记住电话4006960666,客户端约代驾更方便，+wap嘀嘀代驾客户端下载地址。",ShareApp.mobilNumber,self.detailCoupon];
        picker.body = [[NSString alloc] initWithString:content];
        }
    else {
       
        }
    NSArray *array = [NSArray arrayWithObjects:giftNumberText.text,nil];
    picker.recipients = array;
   [self presentModalViewController:picker animated:YES];
    [picker release];
   
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
        else if (result == MessageComposeResultSent)
            NSLog(@"Message sent");
            else 
                NSLog(@"Message failed") ; 
            }
-(void)determineSender:(id)sender
{
    
    NSString * baseUrl = [NSString stringWithFormat:GIFTCOUPONS,ShareApp.mobilNumber,giftNumberText.text,couponID];
    NSLog(@"%@",baseUrl);
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:baseUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setTag:100];
    [request startAsynchronous];
   
}

-(void)parseStringJson:(NSString *)str
{
    
    if([str isEqualToString:@"s"]){
   
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet];
            }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设备没有短信功能" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [alert show];
            [alert release];
            }
        }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"iOS版本过低,iOS4.0以上才支持程序内发送短信" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
        [alert release];
        }

    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"赠送失败，请重试" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    
    NSLog(@"%@",str);
    //[self.navigationController popViewControllerAnimated:YES];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self parseStringJson:[request responseString]];
}


-(void)viewWillDisappear:(BOOL)animated
{
    leftDetailImage.hidden = YES;
    detailCenterLable.hidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;

}
-(void)dealloc
{
    [detailCoupon release];
    [couponID release];
    [giftNumberText release];
    [giftFrientImage release];
    [leftDetailImage release];
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
