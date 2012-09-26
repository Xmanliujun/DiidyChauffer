//
//  EditDepartureViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditDepartureViewController.h"

@interface EditDepartureViewController ()

@end

@implementation EditDepartureViewController
@synthesize departureName,locationDe,DepartureDelegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark-getAddResut
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
    if ([addressinformationArray count]!=0) {
        [addressinformationArray removeAllObjects];
    }
    
   	if (error == 0) {
        
        NSArray* name = result.poiList;
        for (int i = 0; i<[name count]; i++) {
            BMKPoiInfo* moreNes =[name objectAtIndex:i];
            NSLog(@"%@",moreNes.name);
            NSLog(@"%@",moreNes.address);
            [addressinformationArray addObject:moreNes];
        }
        
        CGRect rect;
        if ([addressinformationArray count]*44<346) {
            rect = CGRectMake(0, 170, 320, [addressinformationArray count]*44);
        }else {
            rect = CGRectMake(0, 170, 320, 460-44-170);
        }
        orderTableView.frame = rect;
        [orderTableView reloadData];
	}
}

-(void)getPeripheralInformation
{
   
   // CLLocationCoordinate2D pt = (CLLocationCoordinate2D){39.915101, 116.403981};
   // locationDe
    NSLog(@"%f %f ",self.locationDe.latitude,self.locationDe.longitude);
    BOOL flag = [_search reverseGeocode:self.locationDe];
    NSLog(@"%c",flag);
	if (!flag) {
		NSLog(@"search failed!");
	}
}

#pragma mark-TableDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKPoiInfo * bmn = [addressinformationArray objectAtIndex:indexPath.row];
    NSString * cityName =bmn.name;
    NSString* addressd = bmn.address;
    
    CGSize size = [addressd sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(270, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    CGSize size2 = [cityName sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(270, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [addressinformationArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        
        UIImageView * startImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start.png"]];
        startImageView.tag = 80;
        startImageView.frame = CGRectMake(10, 0, 30, 44);
        [cell.contentView addSubview:startImageView];
        [startImageView release];
        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 270,22 )];
        nameLable.numberOfLines = 0;
       // nameLable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
        
        nameLable.font = [UIFont fontWithName:@"Arial" size:14];
        nameLable.textColor = [UIColor blackColor];
        nameLable.tag = 81;
        [cell.contentView addSubview:nameLable];
        [nameLable release];
        
        UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(50,22, 270,22)];
        addressLable.numberOfLines = 0;
        //addressLable.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
        addressLable.font = [UIFont fontWithName:@"Arial" size:12];
        addressLable.textColor = [UIColor grayColor];
        addressLable.tag = 82;
        [cell.contentView addSubview:addressLable];
        [addressLable release];
    }
   
    
    BMKPoiInfo* moreNes =[addressinformationArray objectAtIndex:indexPath.row];
    
    NSString * cityName =moreNes.name;
    NSString* addressd = moreNes.address;
    
    CGSize size = [addressd sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(270, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    CGSize size1 = [cityName sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(270, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    UILabel * nameLable = (UILabel *)[cell.contentView viewWithTag:81];
    
    if (size1.height>22) {
        nameLable.frame = CGRectMake(50,0, 270,size1.height);
    }else {
        nameLable.frame = CGRectMake(50,0, 270,22);
    }
    nameLable.text = cityName;
    
    
    UILabel * addressLable = (UILabel*)[cell.contentView viewWithTag:82];
    
    if (size.height <22) {
        addressLable.frame = CGRectMake(50,nameLable.frame.size.height, 270,22);
    }else {
        addressLable.frame = CGRectMake(50,nameLable.frame.size.height, 270,size.height);
    }
    
    addressLable.text = addressd;
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKPoiInfo* moreNes =[addressinformationArray objectAtIndex:indexPath.row];
    departureView.text = moreNes.name;
    departure = [moreNes.name retain];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"])
    {
        [departureView resignFirstResponder];
        
        BOOL flag = [_search geocode:departureView.text withCity:@"北京"];
        if (!flag) {
            NSLog(@"search failed!");
        }

        
    }
    return YES;
   
}

#pragma mark-Button
-(void)returnFillOrderView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)nextStep:(id)sender
{
    [DepartureDelegate selectThePlaceOfDeparture:departure];
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - System Approach
-(void)setTheNavigationBar
{
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton.frame=CGRectMake(5.0, 5.0, 55.0, 35.0);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnFillOrderView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.font = [UIFont systemFontOfSize:17];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.text =@"编 辑 出 发 地";
    [self.navigationController.navigationBar addSubview:centerLable];
   
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rigthbutton setTitle:@"确定" forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    rigthbutton.frame=CGRectMake(260.0f, 5.0f, 55.0f, 35.0f);
    [rigthbutton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    self.navigationItem.hidesBackButton = YES;
    
    [self setTheNavigationBar];

    addressinformationArray = [[NSMutableArray alloc] initWithCapacity:0];
    _search = [[BMKSearch alloc]init];
	_search.delegate = self;
    
    UILabel *departureLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 30)];
    departureLable.font = [UIFont systemFontOfSize:14];
    departureLable.textColor = [UIColor orangeColor];
    departureLable.backgroundColor = [UIColor clearColor];
    departureLable.textAlignment = UITextAlignmentLeft;
    departureLable.text = @"出发地:";
    [self.view addSubview:departureLable];
    [departureLable release];
    
    departureView = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, 300, 60)];
    departureView.text = self.departureName;
    departureView.delegate = self;
    departureView.returnKeyType = UIReturnKeyDone;
    departureView.font = [UIFont fontWithName:@"Arial" size:14.0];
    departureView.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:departureView];
    
    UILabel *peripheryLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 120, 30)];
    peripheryLable.font = [UIFont systemFontOfSize:14];
    peripheryLable.textColor = [UIColor orangeColor];
    peripheryLable.backgroundColor = [UIColor clearColor];
    peripheryLable.textAlignment = UITextAlignmentLeft;
    peripheryLable.text = @"周边:";
    [self.view addSubview:peripheryLable];
    [peripheryLable release];
    
    UIImageView * lineImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
    lineImageView.frame = CGRectMake(0,168, 320, 3);
    [self.view addSubview:lineImageView];
    [lineImageView release];
    
    orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 170, 320, 0) style:UITableViewStylePlain];
    orderTableView.separatorColor = [UIColor grayColor];
    // orderTableView.separatorStyle =UITableViewCellEditingStyleNone;
    //orderTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2.png"]];
    orderTableView.backgroundColor = [UIColor whiteColor];
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    [orderTableView setSeparatorColor:[UIColor blackColor]];
    [self.view addSubview:orderTableView];
    
    [self getPeripheralInformation];
}


-(void)viewWillDisappear:(BOOL)animated
{
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;
    centerLable.hidden = YES;
    
}
-(void)dealloc
{
    [addressinformationArray release]; 
    [centerLable release];
    [departure release];
    [departureName release];
    [departureView release];
    [topImageView release];
    [_search release];
    [orderTableView release];
   
    
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
