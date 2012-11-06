//
//  SelectCouponViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectCouponViewController.h"
#import "DIIdyModel.h"
#import "OrdersPreviewViewController.h"
#import "OrdersPreviewTwoViewController.h"
#import "FillOrdersViewController.h"
@interface SelectCouponViewController ()

@end

@implementation SelectCouponViewController
@synthesize selectCouponAray,rowNumber;
@synthesize delegate,mark,orderPreArray;
@synthesize indexAray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark-TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [selectCouponAray count]+1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==0) {
        
        return 1;
        
    }else{
        
        DIIdyModel * diidyModel = [selectCouponAray objectAtIndex:section-1];
        return [diidyModel.number intValue];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        cell.backgroundColor =[UIColor whiteColor];
        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 270,22 )];
        nameLable.numberOfLines = 0;
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.font = [UIFont fontWithName:@"Arial" size:14];
        nameLable.textColor = [UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1];
        nameLable.tag = 81;
        [cell.contentView addSubview:nameLable];
        [nameLable release];
        
        UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(10,22, 270,22)];
        timeLable.numberOfLines = 0;
        timeLable.backgroundColor = [UIColor clearColor];
        timeLable.font = [UIFont fontWithName:@"Arial" size:12];
        timeLable.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];        timeLable.tag = 82;
        [cell.contentView addSubview:timeLable];
        [timeLable release];
        cell.contentView.backgroundColor = [UIColor whiteColor];

    }
   
    if (indexPath.section==0) {
        
        UILabel *nameLable = (UILabel*)[cell.contentView viewWithTag:81];
        nameLable.frame =CGRectMake(10, 0, 270,44);
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.text = @"不使用优惠劵";
        UILabel*timeLable = (UILabel*)[cell.contentView viewWithTag:82];
        timeLable.frame=CGRectMake(0, 0, 0, 0);
        timeLable.text = @"";
        
    }else{
        
        DIIdyModel * diidyMbdel = [selectCouponAray objectAtIndex:indexPath.section-1];
        UILabel *nameLable = (UILabel*)[cell.contentView viewWithTag:81];
        nameLable.frame =CGRectMake(10, 0, 270,22);
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.text = diidyMbdel.name;
        
        UILabel*timeLable = (UILabel*)[cell.contentView viewWithTag:82];
        timeLable.frame = CGRectMake(10,22, 270,22);
        timeLable.text = diidyMbdel.close_date;
    }
        return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

   
    
        if (indexPath.section==0&&indexPath.row==0) {
        
            if (self.mark) {
            
                for (int i = 0; i<[useSelectCouponArray count]; i++) {
                    
                    NSIndexPath*indexPatha = [useSelectCouponArray objectAtIndex:i];
                    
                    
                    [tableView deselectRowAtIndexPath:indexPatha animated:NO];
                    
                }
                    [useSelectCouponArray removeAllObjects];
                    [dearSecationArray addObject:indexPath];
                
            }else{
                
                for (int i = 0; i<[useSelectCouponArray count]; i++) {
                    
                    NSIndexPath*indexPatha = [useSelectCouponArray objectAtIndex:i];
                    
                    
                    [tableView deselectRowAtIndexPath:indexPatha animated:NO];
                    
                }
                    [useSelectCouponArray removeAllObjects];
                    [dearSecationArray addObject:indexPath];
                
            }
        
        }else{

            for (int i = 0; i<[dearSecationArray count]; i++) {
                
                NSIndexPath*indexPatha = [dearSecationArray objectAtIndex:i];
                
                
                [tableView deselectRowAtIndexPath:indexPatha animated:NO];
                
            }
                [dearSecationArray removeAllObjects];
            
            
            if ([useSelectCouponArray count]>=number) {
        
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" 
                                                       message:@"您选择的优惠劵数量超出了司机数量"
                                                      delegate:nil
                                             cancelButtonTitle:@"取消" 
                                             otherButtonTitles:nil ];
                [alert show];
                [alert release];

            
             [tableView deselectRowAtIndexPath:indexPath animated:NO]; 

        
        }else {
            
                NSIndexPath *willDeleteIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                [useSelectCouponArray addObject:willDeleteIndexPath];

            }
        }
    
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UITableViewCell*cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryNone;

    
    for (NSIndexPath *ip in dearSecationArray) {
        
        if (ip.section == indexPath.section && ip.row == indexPath.row) {
            
            [dearSecationArray removeObject:ip];
            
            break;
        }
    }

    
    for (NSIndexPath *ip in useSelectCouponArray) {
        
        if (ip.section == indexPath.section && ip.row == indexPath.row) {
            
            [useSelectCouponArray removeObject:ip];
            
            break;
        }
    }
}
#pragma mark-Buton
-(void)returnFillOrderView:(id)sender
{
    
    if (self.mark) {
        
        [self dismissModalViewControllerAnimated:NO];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
     

}
-(void)skipCouponView:(id)sender
{
    OrdersPreviewTwoViewController * order = [[OrdersPreviewTwoViewController alloc] init];
    order.orderArray =  self.orderPreArray;
    
    [self.navigationController pushViewController:order animated:YES];
    [order release];
}
-(void)nextStep:(id)sender
{
    if(!self.mark){
        
        if ([useSelectCouponArray count]>number) {
            
            [delegate selectedCoupon:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
        NSLog(@"%d",[useSelectCouponArray count]);
        [delegate selectedCoupon:useSelectCouponArray];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else {
        
        if ([useSelectCouponArray count]==0) {
          
            OrdersPreviewTwoViewController * orderPre = [[OrdersPreviewTwoViewController alloc] init];
            orderPre.orderArray = self.orderPreArray;
            orderPre.markPre = YES;
            [self.navigationController pushViewController:orderPre animated:YES];
            [orderPre release];

        }else{
        
        OrdersPreviewViewController * order = [[OrdersPreviewViewController alloc] init];
        order.orderArray = self.orderPreArray;
        order.useCouponArray=useSelectCouponArray;
        order.selectArray = selectCouponAray;
        [self.navigationController pushViewController:order animated:YES];
        [order release];
        
        }
    }
    
}
#pragma mark - System Approach

- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.view.backgroundColor= [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    

    useSelectCouponArray = [[NSMutableArray alloc] initWithCapacity:0];
    dearSecationArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0, 7.0, 50.0, 30.0);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnFillOrderView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.font = [UIFont systemFontOfSize:17];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.text = @"选 择 优 惠 劵";
    [self.navigationController.navigationBar addSubview:centerLable];
     
    NSString * title;
    UIImage*nextd;
    if(self.mark){
        
        title = @"下一步 ";
        nextd = [UIImage imageNamed:@"button4.png"];
        
    }else {
        
        title = @"完成";
        nextd = [UIImage imageNamed:@"33.png"];
    }
    
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:nextd forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rigthbutton setTitle:title forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    rigthbutton.frame=CGRectMake(260.0f, 7.0f, 50.0f, 30.0f);
    [rigthbutton setTitle:title forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
        
    CGRect  rect ;
    if((self.rowNumber*44.0f+44.0f)>416.0f){
    
        rect =self.view.bounds;

    }else {
        
       // rect = CGRectMake(0.0f, 0.0f, 320.0f, 134.0f+(rowNumber-2)*44.0f);
        rect = CGRectMake(0.0f, 0.0f, 320.0f, (rowNumber+1)*44.0f+44+1.0f);
    }
    
    
    UITableView * orderTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [orderTableView setEditing:YES animated:YES];
    orderTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    orderTableView.contentInset =  UIEdgeInsetsMake(1.0f, 0.0f, 0.0f, 0.0);
    if((self.rowNumber*44.0f)>416.0f){
    
        orderTableView.scrollEnabled = YES;
              
    }else {
        
        orderTableView.scrollEnabled = NO;
    }

   // orderTableView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    orderTableView.backgroundColor = [UIColor whiteColor];
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    orderTableView.separatorColor = [UIColor colorWithRed:182.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1];
    
    for (int i = 0; i<[self.indexAray count]; i++) {
                
        NSIndexPath*indexPath = [self.indexAray objectAtIndex:i];
        [useSelectCouponArray addObject:indexPath];

        [orderTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];

    }
        [self.view addSubview:orderTableView];
        [orderTableView release];
    
    NSString * peopleNumber = [self.orderPreArray  objectAtIndex:2];
    NSArray *peopleArr = [peopleNumber componentsSeparatedByString:@"人"];
    NSString * peNumber = [peopleArr objectAtIndex:0];
    number = [peNumber intValue];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;
    centerLable.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    topImageView.hidden = NO;
    returnButton.hidden = NO;
    rigthbutton.hidden = NO;
    centerLable.hidden = NO;

}
-(void)dealloc
{
    [indexAray release];
    [centerLable release];
    [orderPreArray release];
    [selectCouponAray release];
    [dearSecationArray release];
    [topImageView release];
    [useSelectCouponArray release];
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
