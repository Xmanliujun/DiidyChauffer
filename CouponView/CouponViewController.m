//
//  CouponViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CouponViewController.h"
#import "DetailPageViewController.h"
#import "SBJson.h"
#import "CONST.h"
#import "DIIdyModel.h"
#import "AppDelegate.h"
#import "CouponTableCell.h"
#import "ActivityViewController.h"
#import "JSONKit.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
@interface CouponViewController ()

@end

@implementation CouponViewController
@synthesize order_request,detailCoupon,couponID;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark-Button Call
-(void)viewActivity:(UIButton*)sender
{
    
    ActivityViewController * active = [[ActivityViewController alloc] init];
    if (sender.tag==1) {
        
        active.diidyContent = HUNDREDYUAN;
        active.diidyTitle = @"不计里程，百元两次";
        active.coponurl = COUPONTITLE0;
        
    }else if (sender.tag ==2) {
        
        active.diidyContent = ENJOYCARD;
        active.diidyTitle = @"代驾实惠无边，畅想会员特权！";
         active.coponurl = COUPONTITLE1;
        
    }else if (sender.tag==3) {
        
        active.diidyContent = PREFERRNTIAL;
        active.diidyTitle = @"0元用代驾！优惠无底线！";
         active.coponurl = COUPONTITLE2;
        
    }else if (sender.tag==4) {
        
        active.diidyContent = STUDENTCARD;
        active.diidyTitle = @"学生接送卡，准时接送，安全呵护。";
         active.coponurl = COUPONTITLE3;
        
    }else if (sender.tag ==5) {
        
        active.diidyContent = REGISTERCARD;
        active.diidyTitle = @"注册即送50元！";
         active.coponurl = COUPONTITLE4;
        
    }
    [self.navigationController pushViewController:active animated:YES];
    [active release];
    
}

-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
    
}

-(void)timerFired:(NSTimer *)timer{
    
    if (page>4) {
        page=-1;
    }
    couponPage.currentPage = page;
    page++;
    CGRect frame=couponScrollView.frame;
    frame.origin.x=frame.size.width*page;
    frame.origin.y=0;
    [couponScrollView  scrollRectToVisible:frame animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat pageWidth = scrollView.frame.size.width;
     page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    couponPage.currentPage = page;
    
}
#pragma mark-TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [dataArry count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * ID = @"cellID";
    CouponTableCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil)
    {
        cell = [[[CouponTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID] autorelease];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
  
    DIIdyModel *diidy = [dataArry objectAtIndex:indexPath.row];
    NSString * nameNumber = [NSString stringWithFormat:@"%@ X%@",diidy.name,diidy.number];
    cell.nameLable.text =nameNumber ;
    cell.closeDataLable.text = diidy.close_date;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DIIdyModel * diidyModel = [dataArry objectAtIndex:indexPath.row];
    self.couponID =diidyModel.ID;
    self.detailCoupon= diidyModel.name;
    
    [self creatGiftToFriendView];
//    DetailPageViewController * detail = [[DetailPageViewController alloc] init];
//    detail.couponID =diidyModel.ID;
//    detail.detailCoupon = diidyModel.name;
//    [self.navigationController pushViewController:detail animated:YES];
//    [detail release];
}
#pragma mark-DownLoad Parsing
-(void)parseStringJson:(NSString *)str
{
    if (HUD){
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }

    NSArray* jsonParser =[str objectFromJSONString];
    if (dataArry) {
        
        [dataArry removeAllObjects];
        
    }else{
        
        dataArry = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    
    for (int i = 0; i<[jsonParser count]; i++) {
        
        DIIdyModel * diidy = [[DIIdyModel alloc] init];
        NSDictionary * diidyDict = [jsonParser objectAtIndex:i];
        diidy.ID = [diidyDict objectForKey:@"id"];
        diidy.name = [diidyDict objectForKey:@"name"];
        diidy.type = [diidyDict objectForKey:@"type"];
        diidy.number = [diidyDict objectForKey:@"number"];
        diidy.close_date = [diidyDict objectForKey:@"close_date"];
        diidy.amount = [diidyDict objectForKey:@"amount"];
        [dataArry addObject:diidy];
        [diidy release];
        
    }
    CGRect rect;
    if([jsonParser count]!=0){
        
        messgeLable.text = MESSAGE; 
    
        if (60*[jsonParser count]>276) {
            
            rect = CGRectMake(0.0, 150.0, 320.0, 276);
            
        }else {
            
             rect = CGRectMake(0.0, 150.0, 320.0, 60*[jsonParser count]+1);
            
        }
        
        UITableView * couponTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        couponTableView.contentInset = UIEdgeInsetsMake(1.0f, 0.0f, 0.0f, 0.0);
        couponTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
        if (60*[jsonParser count]>276) {
            
            couponTableView.scrollEnabled = YES;
            
        }else {
            
            couponTableView.scrollEnabled=NO;
            
        }
         couponTableView.separatorColor = [UIColor colorWithRed:182.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1];
       // couponTableView.separatorStyle = UITableViewCellEditingStyleNone;
      
        couponTableView.delegate = self;
        couponTableView.dataSource = self;
        [self.view addSubview:couponTableView];
        [couponTableView release];
        
    }else {
        messgeLable.text = NOMESSAGE;
    }
    

    
}
-(void)requesttimeout
{
    [self closeConnection];

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
        
        [self parseStringJson:requestString];
        
    }
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
    [HUD release];
    HUD = nil;
}

#pragma Self Call
-(void)setTheNavigationBar
{
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"优 惠 劵 列 表";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:18.0];
    [self.navigationController.navigationBar addSubview:centerLable];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0f, 7.0f, 50.0f, 30.0f);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];

}
-(void)downCouponStat
{
    NSURL *url=[NSURL URLWithString:@"http://www.diidy.com/android/client/coupon.txt"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:15.0f];
    [request setDelegate:self];
    [request setTag:110];
    [request startAsynchronous];
}



-(void)creatScrollView:(NSString*)responseString
{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"coupon.plist"];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSDictionary * dictStat = [dict objectForKey:@"statusDict"];
    NSString * couponVer = [dictStat objectForKey:@"couponImage"];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath=[NSString stringWithFormat:@"%@/Image",pathDocuments];
  
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath])
    {
        
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        
    }
    else
    {
        NSLog(@"Have");
    }

    NSString *savedImagePath0 ;
    NSString *savedImagePath1;
    NSString *savedImagePath2;
    NSString *savedImagePath3;
    NSString *savedImagePath4;
    
    savedImagePath0 = [createPath stringByAppendingPathComponent:@"coupon0.png"];
    savedImagePath1 = [createPath stringByAppendingPathComponent:@"coupon1.png"];
    savedImagePath2 = [createPath stringByAppendingPathComponent:@"coupon2.png"];
    savedImagePath3 = [createPath stringByAppendingPathComponent:@"coupon3.png"];
   // savedImagePath4 = [createPath stringByAppendingPathComponent:@"coupon4.png"];
    
    if ([responseString isEqualToString:couponVer]) {
       
        NSLog(@"相同");
        
    }else{
    
        UIImage *img0=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.diidy.com/android/client/coupon/coupon_0.jpg"]]];
        NSData *imageData0 = UIImagePNGRepresentation(img0);
        [imageData0 writeToFile:savedImagePath0 atomically:NO];
        
        
        UIImage *img1=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.diidy.com/android/client/coupon/coupon_1.jpg"]]];
        NSData *imageData1 = UIImagePNGRepresentation(img1);
        [imageData1 writeToFile:savedImagePath1 atomically:NO];
        
        UIImage *img2=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.diidy.com/android/client/coupon/coupon_2.jpg"]]];
        NSData *imageData2 = UIImagePNGRepresentation(img2);
        [imageData2 writeToFile:savedImagePath2 atomically:NO];
        
        
        UIImage *img3=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.diidy.com/android/client/coupon/coupon_3.jpg"]]];
        NSData *imageData3 = UIImagePNGRepresentation(img3);
        [imageData3 writeToFile:savedImagePath3 atomically:NO];
        
       
//        UIImage *img4=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.diidy.com/android/client/coupon/coupon_4.jpg"]]];
//        NSData *imageData4 = UIImagePNGRepresentation(img4);
//        [imageData4 writeToFile:savedImagePath4 atomically:NO];
        
          NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
          NSString *documentsDirectory = [paths objectAtIndex:0];
          NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"coupon.plist"];
          NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] init];
          NSMutableDictionary *plugin1 = [[NSMutableDictionary alloc]init];
          [plugin1 setObject:responseString forKey:@"couponImage"];
          [dictplist setObject:plugin1 forKey:@"statusDict"];
          [dictplist writeToFile:plistPath atomically:YES];
          [dictplist release];
          [plugin1 release];
    }
    
    
    UIImage* im0 = [UIImage imageWithContentsOfFile:savedImagePath0];

    UIImageView * zeroImageView = [[UIImageView alloc] initWithImage:im0];
    zeroImageView.frame = CGRectMake(0, 0, 320, 90);
    
    UIImage* im1 = [UIImage imageWithContentsOfFile:savedImagePath1];
    UIImageView * firstImageView = [[UIImageView alloc] initWithImage:im1 ];
    firstImageView.frame=CGRectMake(320, 0, 320, 90);
    
    UIImage* im2 = [UIImage imageWithContentsOfFile:savedImagePath2];
    UIImageView * secondImageView = [[UIImageView alloc] initWithImage:im2];
    secondImageView.frame = CGRectMake(640, 0, 320, 90);
    
    UIImage* im3 = [UIImage imageWithContentsOfFile:savedImagePath3];
    UIImageView * threeImageView = [[UIImageView alloc] initWithImage:im3];
    threeImageView.frame = CGRectMake(960, 0, 320, 90);
    
//    UIImage* im4 = [UIImage imageWithContentsOfFile:savedImagePath4];
//    UIImageView * fourImageView = [[UIImageView alloc] initWithImage:im4];
//    fourImageView.frame =CGRectMake(1280, 0, 320, 90);
    
    couponScrollView = [[UIScrollView alloc] init];
    couponScrollView.frame = CGRectMake(0.0, 0.0, 320.0, 90.0);
    couponScrollView.contentSize = CGSizeMake(320.0*4,80.0);
    couponScrollView.backgroundColor = [UIColor grayColor];
    couponScrollView.showsVerticalScrollIndicator = NO;
    couponScrollView.showsHorizontalScrollIndicator = NO;
    couponScrollView.delegate = self;
    couponScrollView.userInteractionEnabled = YES;
    couponScrollView.pagingEnabled = YES;
    couponScrollView.scrollEnabled = YES;
    [couponScrollView addSubview:zeroImageView];
    [couponScrollView addSubview:firstImageView];
    [couponScrollView addSubview:secondImageView];
    [couponScrollView addSubview:threeImageView];
  //  [couponScrollView addSubview:fourImageView];
    
    [zeroImageView release];
    [firstImageView release];
    [secondImageView release];
    [threeImageView release];
 //   [fourImageView release];
    
    for (int i=0; i<4; i++) {
        
        UIButton * couButton = [UIButton buttonWithType:UIButtonTypeCustom];
        couButton.frame = CGRectMake(i*320, 0, 320, 90);
        couButton.tag = i+1;
        [couButton addTarget:self action:@selector(viewActivity:) forControlEvents:UIControlEventTouchUpInside];
        [couponScrollView addSubview:couButton];
        
    }
    [self.view addSubview:couponScrollView];
    
    couponPage= [[UIPageControl alloc] init];
    couponPage.backgroundColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:0.6];
    couponPage.alpha = 0.7;
    couponPage.frame = CGRectMake(0.0, 90.0, 320.0, 20.0);
    couponPage.numberOfPages = 4;
    couponPage.currentPage = 0;
    [self.view addSubview:couponPage];
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



-(void)showWithDetails{
    
    HUD=[[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate=self;
    HUD.labelText=@"Loading";
    HUD.detailsLabelText=@"获取优惠劵信息...";
    HUD.square=YES;
    [HUD show:YES];
    //此处进入多线程处理
 
    NSString * baseUrl = [NSString stringWithFormat:COUPON,ShareApp.mobilNumber];
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HTTPRequest *request = [[HTTPRequest alloc] init];
    self.order_request = request;
    self.order_request.m_delegate = self;
    self.order_request.hasTimeOut = YES;
    [request release];
    
    [self.order_request requestByUrlByGet: baseUrl];
}

#pragma mark-giftFriend
-(void)creatGiftToFriendView
{
    UILabel * giftNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 120.0, 40.0)];
    giftNumberLable.text = @"赠送给(手机号) :";
    giftNumberLable.backgroundColor = [UIColor clearColor];
    giftNumberLable.textAlignment = NSTextAlignmentCenter;
    giftNumberLable.font = [UIFont fontWithName:@"Arial" size:13.0];
    
    UIImage * giftImage = [UIImage imageNamed:@"u84_line.png"];
    UIImageView * giftLineImage = [[UIImageView alloc] initWithImage:giftImage];
    giftLineImage.frame = CGRectMake(0.0, 45.0, 300.0, giftImage.size.height);

    giftNumberText = [[UITextView alloc] initWithFrame:CGRectMake(110.0, 7.0,160.0, 40.0)];
    giftNumberText.textColor = [UIColor blackColor];
    giftNumberText.text = @"";
    giftNumberText.returnKeyType = UIReturnKeyDefault;
    giftNumberText.font = [UIFont fontWithName:@"Arial" size:16.0];
    giftNumberText.keyboardType = UIKeyboardTypePhonePad;
    [giftNumberText becomeFirstResponder];
    
    UIImage * determineImage = [UIImage imageNamed:@"u102_normal.png"];
    UIButton* determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    determineButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    determineButton.frame=CGRectMake(15.0,135.0 , determineImage.size.width, determineImage.size.height);
    [determineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [determineButton setBackgroundImage:determineImage forState:UIControlStateNormal];
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(determineSender:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *cancelImage = [UIImage imageNamed:@"u104_normal.png"];
    UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    cancelButton.frame=CGRectMake(160.0,135.0 , determineImage.size.width, determineImage.size.height);
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:cancelImage forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelSender:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString * content = [NSString stringWithFormat:@"您的朋友%@送您1张%@，喝酒了疲劳了不想开车了，记着找嘀嘀！记住电话4006960666,客户端约代驾更方便，+wap嘀嘀代驾客户端下载地址。",ShareApp.mobilNumber,self.detailCoupon];
    
    UILabel * contentLable = [[UILabel alloc] initWithFrame:CGRectMake(5.0,55.0, 290.0, 70.0)];
    contentLable.text = content;
    contentLable.numberOfLines = 0;
    contentLable.backgroundColor = [UIColor grayColor];
    [contentLable.layer setCornerRadius:4.0f];
    [contentLable.layer setMasksToBounds:YES];
    contentLable.textAlignment = NSTextAlignmentLeft;
    contentLable.font = [UIFont fontWithName:@"Arial" size:13.0];

    
    giftFrientView = [[UIView alloc] initWithFrame:CGRectMake(10.0,5.0, 300.0, 190.0)];
    
    giftFrientView.backgroundColor=[UIColor whiteColor];
    [[giftFrientView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[giftFrientView layer] setShadowRadius:5];
    [[giftFrientView layer] setShadowOpacity:1];
    [[giftFrientView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[giftFrientView layer] setCornerRadius:7];
    [[giftFrientView layer] setBorderWidth:1];
    [[giftFrientView layer] setBorderColor:[UIColor grayColor].CGColor];
    
    [giftFrientView addSubview:contentLable];
    [giftFrientView addSubview:cancelButton];
    [giftFrientView addSubview:determineButton];
    [giftFrientView addSubview:giftNumberText];
    [giftFrientView addSubview:giftLineImage];
    [giftFrientView addSubview:giftNumberLable];
    [self.view addSubview:giftFrientView];
   
    [giftNumberLable release];
    [contentLable release];
    [giftLineImage release];
}


-(void)cancelSender:(id)sender
{
    if (giftFrientView) {
        
        [giftFrientView removeFromSuperview];
         giftFrientView= nil;
        
    }
}
-(void)determineSender:(id)sender
{
    if (giftNumberText.text==NULL||[giftNumberText.text length]==0||[giftNumberText.text isEqualToString:ShareApp.mobilNumber]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号为空或格式错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
        [alert release];

    }else{
    
        NSString * baseUrl = [NSString stringWithFormat:GIFTCOUPONS,ShareApp.mobilNumber,giftNumberText.text,couponID];
        baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * url = [NSURL URLWithString:baseUrl];
    
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setTimeOutSeconds:15.0f];
        [request setDelegate:self];
        [request setTag:100];
        [request startAsynchronous];}
    
}

-(void)parseGiftFrientStringJson:(NSString *)str
{
    
    NSDictionary * jsonParser =[str objectFromJSONString];
    NSString * returenNews =[jsonParser objectForKey:@"r"];
    
    if([returenNews isEqualToString:@"s"]){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"赠送成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];

        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"赠送失败，请重试" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if ([request responseString]==NULL||[[request responseString] length]==0) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"赠送失败"
                                                       message:@"请检查网络是否连接"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil ];
        [alert show];
        [alert release];

        
    }else{
        if (request.tag==110) {
            [self creatScrollView:[request responseString]];
            
        }else{
        
            [self parseGiftFrientStringJson:[request responseString]];
        }
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request
{

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"赠送失败，请重试" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
    [alert show];
    [alert release];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (giftFrientView) {
        
        [giftFrientView removeFromSuperview];
        giftFrientView= nil;
        
    }

    [self showWithDetails];


}
#pragma mark - System Approach

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    [self setTheNavigationBar];
     
    page = -1;
    dataArry = [[NSMutableArray alloc] initWithCapacity:0];

    messgeLable = [[UILabel alloc] init];
    messgeLable.frame = CGRectMake(0, 110, 320, 40);
    messgeLable.numberOfLines = 0;
    messgeLable.backgroundColor = [UIColor clearColor];
    messgeLable.font = [UIFont fontWithName:@"Arial" size:14];
    messgeLable.textColor = [UIColor orangeColor];
    [self.view addSubview:messgeLable];
    
    [self downCouponStat];
    [self showWithDetails];
    
    couponTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    centerLable.hidden = NO;
    topImageView.hidden = NO;
    returnButton.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    centerLable.hidden = YES;
    topImageView.hidden = YES;
    returnButton.hidden = YES;

}
-(void)dealloc
{
   
    [couponID release];
    [detailCoupon release];
    [giftFrientView release];
    
    [couponPage release];
    [couponScrollView release];
    [topImageView release];
    [centerLable release];
    [messgeLable release];
    [dataArry release];
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
