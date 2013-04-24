//
//  CouponViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CouponViewController.h"
#import "DetailPageViewController.h"
#import "CONST.h"
#import "DIIdyModel.h"
#import "AppDelegate.h"
#import "CouponTableCell.h"
#import "ActivityViewController.h"
#import "JSONKit.h"
#import <QuartzCore/QuartzCore.h>
#import "MobClick.h"
@interface CouponViewController ()

@end

@implementation CouponViewController
@synthesize order_request,detailCoupon,couponID,couponStat;
@synthesize couponTimer,order_stat,order_send,order_number,verCoupon;
@synthesize couponPage,timeString;

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
    [MobClick event:@"m05_c001_0001_0002"];
    
    ActivityViewController * active = [[ActivityViewController alloc] init];
    active.coponurl = [NSString stringWithFormat:@"http://coupon.diidy.com/coupon_%d.php",sender.tag-1];
    
    [self.navigationController pushViewController:active animated:YES];
    [active release];
    
}

-(void)returnMainView:(id)sender
{
    
    if (couponTimer) {
        
        [self.couponTimer invalidate];
        self.couponTimer=nil;
    }

    [self dismissModalViewControllerAnimated:NO];
    
}

-(void)timerFired:(NSTimer *)timer{
    
    NSString *pathDocuments=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath=[NSString stringWithFormat:@"%@/Image",pathDocuments];
    
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:createPath error:nil];
      page++;
    if (page>=[tmplist count]) {
        
        page=0;
    }

    self.couponPage.currentPage = page;
    CGRect frame=couponScrollView.frame;
    frame.origin.x=frame.size.width*page;
    frame.origin.y=0;
    [couponScrollView  scrollRectToVisible:frame animated:YES];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//    CGFloat pageWidth = scrollView.frame.size.width;
//    page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    couponPage.currentPage = page;
//    
//}
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
    
    [MobClick event:@"m05_c001_0001"];
    
    if ([diidyModel.close_date isEqualToString:@"永久有效"]) {
        
        [self creatGiftToFriendView];
        
    }else{
    
        NSArray*origntime = [diidyModel.close_date componentsSeparatedByString:@"-"];
        
        NSArray*nowtime = [self.timeString componentsSeparatedByString:@"-"];
       
        if ([[nowtime objectAtIndex:0] intValue]>[[origntime objectAtIndex:0] intValue]) {
            
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                           message:@"优惠劵已过期"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确认"
                                                 otherButtonTitles:nil ];
            [alert show];
            [alert release];
            
        }else if([[nowtime objectAtIndex:0] intValue]==[[origntime objectAtIndex:0] intValue]){
            
            if ([[nowtime objectAtIndex:1] intValue]>[[origntime objectAtIndex:1] intValue]) {
                
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                               message:@"优惠劵已过期"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确认"
                                                     otherButtonTitles:nil ];
                [alert show];
                [alert release];

                
            }else if ([[nowtime objectAtIndex:1] intValue]==[[origntime objectAtIndex:1] intValue]){
            
                if ([[nowtime objectAtIndex:1] intValue]>[[origntime objectAtIndex:1] intValue]) {
                    
                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                                   message:@"优惠劵已过期"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确认"
                                                         otherButtonTitles:nil ];
                    [alert show];
                    [alert release];
                    
                }else{
                
                    [self creatGiftToFriendView];
                }
                
            
            }else{
            
                [self creatGiftToFriendView];

            }
            
        }else{
        
            [self creatGiftToFriendView];
        
        }
    }
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
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
   //CGRect rect;
    if([jsonParser count]!=0){
        
        messgeLable.text = MESSAGE; 
        //rect = CGRectMake(0.0, 150.0, 320.0, 276);
        //couponTableView.frame = rect;
        [couponTableView reloadData];
        
    }else {
        
        messgeLable.text = NOMESSAGE;
        
    }
}

- (void)downloadNewData:(NSString*)ur{


    NSArray*numberArray = [ur componentsSeparatedByString:@"#"];
        
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
    
    
    for(int i=0; i<[numberArray count];i++) {
        
        UIImage *img1=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://www.diidy.com/android/client/coupon/coupon_%d.jpg",i]]]];
        
        NSData *imageData1 = UIImagePNGRepresentation(img1);
        [imageData1 writeToFile:[createPath stringByAppendingPathComponent:[NSString stringWithFormat:@"coupon%d.png",i]] atomically:NO];
        
        NSLog(@"image   %@",imageData1);
        
    }
   
    
    [self performSelectorOnMainThread:@selector(updateInformation) withObject:nil waitUntilDone:YES];
    
}
-(void)updateInformation
{

    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"coupon.plist"];
    NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *plugin1 = [[NSMutableDictionary alloc]init];
    [plugin1 setObject:self.verCoupon forKey:@"couponImage"];
    [dictplist setObject:plugin1 forKey:@"statusDict"];
    [dictplist writeToFile:plistPath atomically:YES];
    [dictplist release];
    [plugin1 release];

    NSString *pathDocuments=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath=[NSString stringWithFormat:@"%@/Image",pathDocuments];
    
    
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:createPath error:nil];
    
    if (couponScrollView) {
        
        [couponScrollView removeFromSuperview];
        couponScrollView=nil;
    }
    couponScrollView = [[UIScrollView alloc] init];
    couponScrollView.frame = CGRectMake(0.0, 0.0, 320.0, 90.0);
    couponScrollView.contentSize = CGSizeMake(320.0*[tmplist count],80.0);
    couponScrollView.backgroundColor = [UIColor grayColor];
    couponScrollView.showsVerticalScrollIndicator = NO;
    couponScrollView.showsHorizontalScrollIndicator = NO;
    //couponScrollView.delegate = self;
    couponScrollView.userInteractionEnabled = YES;
    couponScrollView.pagingEnabled = YES;
    couponScrollView.scrollEnabled = YES;
    
    for (int i=0; i<[tmplist count]; i++) {
        
        UIImage* im0 = [UIImage imageWithContentsOfFile:[createPath stringByAppendingPathComponent:[NSString stringWithFormat:@"coupon%d.png",i]]];
        
        UIImageView * zeroImageView = [[UIImageView alloc] initWithImage:im0];
        zeroImageView.frame = CGRectMake(i*320, 0, 320, 90);
        [couponScrollView addSubview:zeroImageView];
        [zeroImageView release];
        
    }
    for (int i=0; i<[tmplist count]; i++) {
        
        UIButton * couButton = [UIButton buttonWithType:UIButtonTypeCustom];
        couButton.frame = CGRectMake(i*320, 0, 320, 90);
        couButton.tag = i+1;
        [couButton addTarget:self action:@selector(viewActivity:) forControlEvents:UIControlEventTouchUpInside];
        [couponScrollView addSubview:couButton];
        
    }
    [self.view addSubview:couponScrollView];
    
    UIPageControl*coupan = [[UIPageControl alloc] init];

    self.couponPage=coupan;
    self.couponPage.backgroundColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:0.6];
    self.couponPage.alpha = 0.7;
    self.couponPage.frame = CGRectMake(0.0, 90.0, 320.0, 20.0);
    self.couponPage.numberOfPages = [tmplist count];
    self.couponPage.currentPage = 0;
    [self.view addSubview:self.couponPage];
    
    self.couponTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];

}
-(void)parseImageStringJson:(NSString*)strrr
{

    [NSThread detachNewThreadSelector:@selector(downloadNewData:) toTarget:self withObject:strrr];

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
      
        if (nOrder==70) {
            
             [self parseStringJson:requestString];
            
        }else if(nOrder==71){
        
            [self creatScrollView:requestString];
            
        }else if(nOrder==72){
            
              [self parseGiftFrientStringJson:requestString];
        
        }else if (nOrder==73){
        
            [self parseImageStringJson:requestString];

        
        }
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
    centerLable.textAlignment = NSTextAlignmentCenter;
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
 
    NSString*saturl= @"http://www.diidy.com/android/client/coupon.txt";
    saturl = [saturl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HTTPRequest *request = [[HTTPRequest alloc] init];
    request.forwordFlag = 71;
    self.order_stat = request;
    self.order_stat.m_delegate = self;
    self.order_stat.hasTimeOut = YES;
    [request release];
    
    [self.order_stat requestByUrlByGet:saturl];
}

-(void)creatScrollView:(NSString*)responseString
{
    self.verCoupon=responseString;
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
    
    
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:createPath error:nil];
    
   
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath])
    {
        
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }else
    {
        NSLog(@"Have");
    }
    
    if ([responseString isEqualToString:couponVer]) {
       
        if ([tmplist count]==0) {
            
           
        }else{
            
            if (couponScrollView) {
                
                [couponScrollView removeFromSuperview];
                 couponScrollView=nil;
            }
        couponScrollView = [[UIScrollView alloc] init];
        couponScrollView.frame = CGRectMake(0.0, 0.0, 320.0, 90.0);
        couponScrollView.contentSize = CGSizeMake(320.0*[tmplist count],80.0);
        couponScrollView.backgroundColor = [UIColor grayColor];
        couponScrollView.showsVerticalScrollIndicator = NO;
        couponScrollView.showsHorizontalScrollIndicator = NO;
        //couponScrollView.delegate = self;
        couponScrollView.userInteractionEnabled = YES;
        couponScrollView.pagingEnabled = YES;
        couponScrollView.scrollEnabled = YES;
        
        for (int i=0; i<[tmplist count]; i++) {
            
            UIImage* im0 = [UIImage imageWithContentsOfFile:[createPath stringByAppendingPathComponent:[NSString stringWithFormat:@"coupon%d.png",i]]];
            
            UIImageView * zeroImageView = [[UIImageView alloc] initWithImage:im0];
            zeroImageView.frame = CGRectMake(i*320, 0, 320, 90);
            [couponScrollView addSubview:zeroImageView];
            [zeroImageView release];
            
        }
        for (int i=0; i<[tmplist count]; i++) {
            
            UIButton * couButton = [UIButton buttonWithType:UIButtonTypeCustom];
            couButton.frame = CGRectMake(i*320, 0, 320, 90);
            couButton.tag = i+1;
            [couButton addTarget:self action:@selector(viewActivity:) forControlEvents:UIControlEventTouchUpInside];
            [couponScrollView addSubview:couButton];
            
        }
            [self.view addSubview:couponScrollView];
        
        }
        
        self.couponPage.numberOfPages = [tmplist count];

        
        self.couponTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
    }else{
        
        NSString*numString = @"http://www.diidy.com/android/client/coupon/couponinfo.txt";
        numString = [numString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        HTTPRequest *request = [[HTTPRequest alloc] init];
        request.forwordFlag = 73;
        self.order_number = request;
        self.order_number.m_delegate = self;
        self.order_number.hasTimeOut = YES;
        [request release];
        
        [self.order_number requestByUrlByGet:numString];

        for (int i=0; i<[tmplist count]; i++) {
            
            NSString*pathhh = [NSString stringWithFormat:@"%@/coupon%d.png",createPath,i];
              BOOL s=[[NSFileManager defaultManager] removeItemAtPath:pathhh error:nil];
             NSLog(@"scs         %c",s);
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
    request.forwordFlag = 70;
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
    giftNumberLable.font = [UIFont fontWithName:@"Arial" size:15.0];
    giftNumberLable.textColor = [UIColor whiteColor];
    
    UIImage * giftImage = [UIImage imageNamed:@"u84_line.png"];
    UIImageView * giftLineImage = [[UIImageView alloc] initWithImage:giftImage];
    giftLineImage.frame = CGRectMake(0.0, 45.0, 300.0, giftImage.size.height);
    
    giftNumberText = [[UITextField alloc] initWithFrame:CGRectMake(124.0, 6.0,160.0, 40.0)];
    giftNumberText.backgroundColor = [UIColor clearColor];
    giftNumberText.textColor = [UIColor whiteColor];
    giftNumberText.placeholder = @"请输入亲友号码";
    giftNumberText.clearButtonMode = UITextFieldViewModeWhileEditing;
    giftNumberText.contentVerticalAlignment =  UIControlContentVerticalAlignmentCenter;
    giftNumberText.returnKeyType = UIReturnKeyDefault;
    giftNumberText.autocorrectionType = UITextAutocorrectionTypeYes;
    giftNumberText.font = [UIFont fontWithName:@"Arial" size:15.0];
    giftNumberText.keyboardType = UIKeyboardTypePhonePad;
    [giftNumberText becomeFirstResponder];
    
    UIImage * determineImage = [UIImage imageNamed:@"u102_normal.png"];
    UIButton* determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    determineButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    determineButton.frame=CGRectMake(15.0,135.0 , determineImage.size.width, determineImage.size.height);
    [determineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [determineButton setBackgroundImage:determineImage forState:UIControlStateNormal];
    [determineButton setTitle:@"确 定" forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(determineSender:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *cancelImage = [UIImage imageNamed:@"u104_normal.png"];
    UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    cancelButton.frame=CGRectMake(160.0,135.0 , determineImage.size.width, determineImage.size.height);
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:cancelImage forState:UIControlStateNormal];
    [cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelSender:) forControlEvents:UIControlEventTouchUpInside];
    
   NSString * content = [NSString stringWithFormat:@"您的朋友(%@)送您1张%@，喝酒了疲劳了不想开车了，记着找嘀嘀！记住电话4006960666,客户端约代驾更方便，下载地址http://wap.diidy.com",ShareApp.mobilNumber,self.detailCoupon];
    
    UILabel* contentLable = [[UILabel alloc] initWithFrame:CGRectMake(5.0,55.0, 290.0, 70.0)];
    contentLable.text = content;
    contentLable.numberOfLines = 0;
    contentLable.textColor = [UIColor whiteColor];
    contentLable.backgroundColor = [UIColor lightGrayColor];
    [contentLable.layer setCornerRadius:4.0f];
    [contentLable.layer setMasksToBounds:YES];
    contentLable.textAlignment = NSTextAlignmentLeft;
    contentLable.font = [UIFont fontWithName:@"Arial" size:13.0];

    giftFrientView = [[UIView alloc] initWithFrame:CGRectMake(10.0,5.0, 300.0, 190.0)];
    giftFrientView.backgroundColor=[UIColor grayColor];
    [[giftFrientView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[giftFrientView layer] setShadowRadius:5];
    [[giftFrientView layer] setShadowOpacity:1];
    [[giftFrientView layer] setShadowColor:[UIColor whiteColor].CGColor];
    [[giftFrientView layer] setCornerRadius:7];
    [[giftFrientView layer] setBorderWidth:2];
    [[giftFrientView layer] setBorderColor:[UIColor whiteColor].CGColor];
    
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
    [MobClick event:@"m05_c001_0001_0003"];
    if (giftFrientView) {
        
        [giftFrientView removeFromSuperview];
         giftFrientView= nil;
        
    }
}
-(void)determineSender:(id)sender
{
    [MobClick event:@"m05_c001_0001_0001"];
    int markInt = 0;
    if (giftNumberText.text==NULL||[giftNumberText.text length]==0||[giftNumberText.text length]!=11) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号为空或格式错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
        [alert release];

    }else{
    
        for (int i=0; i<[giftNumberText.text length];i++) {
            
            NSString *string2 = [giftNumberText.text substringWithRange:NSMakeRange(i, 1)];
        
           
            if ([string2 isEqualToString:@"1"]||[string2 isEqualToString:@"2"]||[string2 isEqualToString:@"3"]||[string2 isEqualToString:@"4"]||[string2 isEqualToString:@"5"]||[string2 isEqualToString:@"6"]||[string2 isEqualToString:@"7"]||[string2 isEqualToString:@"8"]||[string2 isEqualToString:@"9"]||[string2 isEqualToString:@"0"]) {
              
                markInt++;
            }
        }
       
        if (markInt!=11) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号为空或格式错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }else{
        
            if ([giftNumberText.text isEqualToString:ShareApp.mobilNumber]) {
            
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"优惠券不能赠送给自己，请重新输入手机号码" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
                [alert show];
                [alert release];
                      
            }else{
        
                NSString * baseUrl = [NSString stringWithFormat:GIFTCOUPONS,ShareApp.mobilNumber,giftNumberText.text,couponID];
                baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   
                HTTPRequest *request = [[HTTPRequest alloc] init];
                request.forwordFlag = 72;
                self.order_send = request;
                self.order_send.m_delegate = self;
                self.order_send.hasTimeOut = YES;
                [request release];
                
                [self.order_send requestByUrlByGet: baseUrl];

            }
        
        }
    }
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (giftFrientView) {
        
        [giftFrientView removeFromSuperview];
         giftFrientView= nil;
        
    }

    [self showWithDetails];


}
#pragma mark - System Approach
-(void)getStat:(NSNotification *)notify {
    
    self.couponStat = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
  
    [MobClick event:@"m05_c001"];
    [self setTheNavigationBar];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getStat:) name:@"COUPONSTAT" object:nil];
   
    page = -1;
    dataArry = [[NSMutableArray alloc] initWithCapacity:0];

    messgeLable = [[UILabel alloc] init];
    messgeLable.frame = CGRectMake(0, 110, 320, 40);
    messgeLable.numberOfLines = 0;
    messgeLable.text = NOMESSAGE;
    messgeLable.backgroundColor = [UIColor clearColor];
    messgeLable.font = [UIFont fontWithName:@"Arial" size:14];
    messgeLable.textColor = [UIColor orangeColor];
    [self.view addSubview:messgeLable];
    
    couponScrollView = [[UIScrollView alloc] init];
    couponScrollView.frame = CGRectMake(0.0, 0.0, 320.0, 90.0);
    couponScrollView.contentSize = CGSizeMake(320.0,80.0);
    couponScrollView.backgroundColor = [UIColor grayColor];
    couponScrollView.showsVerticalScrollIndicator = NO;
    couponScrollView.showsHorizontalScrollIndicator = NO;
   // couponScrollView.delegate = self;
    couponScrollView.userInteractionEnabled = YES;
    couponScrollView.pagingEnabled = YES;
    couponScrollView.scrollEnabled = YES;
    
    UIImage* im0 = [UIImage imageNamed:@"corp-info-4.png"];
       UIImageView * zeroImageView = [[UIImageView alloc] initWithImage:im0];
    zeroImageView.frame = CGRectMake(0, 0, 320, 90);
    [couponScrollView addSubview:zeroImageView];
    [zeroImageView release];
    [self.view addSubview:couponScrollView];
    
    self.couponPage= [[UIPageControl alloc] init];
    self.couponPage.backgroundColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:0.6];
    self.couponPage.alpha = 0.7;
    self.couponPage.frame = CGRectMake(0.0, 90.0, 320.0, 20.0);
    self.couponPage.numberOfPages = 1;
       self.couponPage.currentPage = 0;
    [self.view addSubview:self.couponPage];
    
    NSDate *today = [[NSDate alloc] init];
    NSDateFormatter* dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-d"];
    self.timeString=[dateformatter stringFromDate:today];
    
    CGRect rect =CGRectMake(0.0, 150.0, 320.0, 276);
    couponTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    couponTableView.contentInset = UIEdgeInsetsMake(1.0f, 0.0f, 0.0f, 0.0);
    couponTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    couponTableView.separatorColor = [UIColor colorWithRed:182.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1];
    couponTableView.delegate = self;
    couponTableView.dataSource = self;
    [self.view addSubview:couponTableView];
    [self setExtraCellLineHidden:couponTableView];
   
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
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.couponStat) {
        
        [self downCouponStat];
        [self showWithDetails];
        
    }
}
-(void)dealloc
{
    
    if (order_send) {
        
        [self.order_send closeConnection];
        self.order_send.m_delegate = nil;
        self.order_send=nil;
    }
    if (order_stat) {
        
        [self.order_stat closeConnection];
        self.order_stat.m_delegate = nil;
        self.order_stat=nil;
    }

    if (order_request) {
        
        [self.order_request closeConnection];
        self.order_request.m_delegate=nil;
        self.order_request=nil;
    }
    
    if (order_number) {
        
        [self.order_number closeConnection];
        self.order_number.m_delegate=nil;
        self.order_number=nil;
    }
       
    self.verCoupon=nil;
    self.timeString=nil;
    self.couponPage=nil;
    [couponID release];
    [detailCoupon release];
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
