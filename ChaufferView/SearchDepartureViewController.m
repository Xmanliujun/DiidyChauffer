//
//  SearchDepartureViewController.m
//  DiidyProject
//
//  Created by diidy on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchDepartureViewController.h"
#import "FromPossibleViewController.h"
@interface SearchDepartureViewController ()

@end

@implementation SearchDepartureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
#pragma mark-TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [cityArray count];
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
       
    }
    BMKPoiInfo * bmn = [cityArray objectAtIndex:indexPath.row];
    NSString * cityName =bmn.name;
    cell.textLabel.text = cityName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BMKPoiInfo * bmn = [cityArray objectAtIndex:indexPath.row];
    NSString * cityName =bmn.name;
    
    FromPossibleViewController * fromPossible = [[FromPossibleViewController alloc] init];
    fromPossible.possibleCity = cityName;
    [self.navigationController pushViewController:fromPossible animated:YES];
    [fromPossible release];
}
#pragma mark-GetPoi
- (void)onGetPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
    
    [cityArray removeAllObjects];
    BMKPoiResult * na = [poiResultList objectAtIndex:0];
    int c = na.totalPoiNum;
    NSLog(@"%d",c);
    NSArray * name = na.poiInfoList;
  //  NSArray *  city = na.cityList;
    for (int i = 0; i<[name count]; i++) {
        
        BMKPoiInfo * bmk = [name objectAtIndex:i];
        [cityArray addObject:bmk];
    }
    
    FromPossibleViewController * fromPossible = [[FromPossibleViewController alloc] init];
    fromPossible.possibleCityArray = cityArray;
    [self.navigationController pushViewController:fromPossible animated:YES];
    [fromPossible release];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    CLLocationCoordinate2D  venter;
    venter.latitude = 39.915101;
    venter.longitude = 116.403981;
    [cityArray addObject:searchBar.text];
    [_search poiSearchNearBy:searchBar.text center:venter radius:30000 pageIndex:0];

}
-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];

}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{

    [self dismissModalViewControllerAnimated:NO];

}
#pragma mark - System Approach
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _search = [[BMKSearch alloc]init];
    _search.delegate = self;
    cityArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
       
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0, 7.0, 50.0, 30.0);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 0.0, 160.0, 44.0)];
    centerLable.text = @"搜 索 出 发 地";
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.font = [UIFont fontWithName:@"Arial" size:15.0];
    [self.navigationController.navigationBar addSubview:centerLable];
    
    startAddrSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0, 320, 41)];  
    startAddrSearchBar.delegate = self;
    startAddrSearchBar.showsBookmarkButton = NO;
    startAddrSearchBar.barStyle = UIBarStyleDefault;  
   // startAddrSearchBar.showsSearchResultsButton = YES;
    startAddrSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;  
    startAddrSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;  
    startAddrSearchBar.placeholder = @"您也可以在此搜索出发地....";
    startAddrSearchBar.keyboardType =  UIKeyboardTypeDefault; 
  //  startAddrSearchBar.showsCancelButton = YES;
    
    // [[startAddrSearchBar.subviews objectAtIndex:0]removeFromSuperview];只剩下 边框
//        for(id cc in [startAddrSearchBar subviews])
//        {
//            if([cc isKindOfClass:[UIButton class]])
//            {
//                UIButton *btn = (UIButton *)cc;
//                [btn setTitle:@"取消"  forState:UIControlStateNormal];
//                btn.enabled = YES;
//            }
//    } 
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]];
    [startAddrSearchBar insertSubview:imageView atIndex:1];
    [imageView release];
    
    UIView *segment = [startAddrSearchBar.subviews objectAtIndex:0];  
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u0_normal.png"]];  
    [segment addSubview: bgImage];  
    [bgImage release];
    [self.view addSubview:startAddrSearchBar];  
   
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    centerLable.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    centerLable.hidden = NO;
    topImageView.hidden = NO;
    returnButton.hidden = NO;

}
-(void)dealloc
{
    [cityArray release];
    [centerLable release];
    [orderTableView release];
    [startAddrSearchBar release];
    [_search release];
    [topImageView release];
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
