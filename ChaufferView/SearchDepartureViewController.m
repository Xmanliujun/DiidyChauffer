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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _search = [[BMKSearch alloc]init];
    _search.delegate = self;
    
    
    cityArray = [[NSMutableArray alloc] initWithCapacity:0];
    UIButton *returnButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton  setBackgroundImage:[UIImage imageNamed:@"u108_normalp.png"] forState:UIControlStateNormal];
    [returnButton  setTitle:@"返回" forState:UIControlStateNormal];
    returnButton .titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    returnButton .frame=CGRectMake(0.0, 100.0, 43.0, 25.0);
    [returnButton  addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* returnItem = [[UIBarButtonItem alloc] initWithCustomView:returnButton];
    self.navigationItem.leftBarButtonItem = returnItem;    
    [returnItem release];

   
    startAddrSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 41)];  
    startAddrSearchBar.delegate = self;  
    startAddrSearchBar.barStyle = UIBarStyleDefault;  
    startAddrSearchBar.showsSearchResultsButton = YES;
    startAddrSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;  
    startAddrSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;  
    startAddrSearchBar.placeholder = @"您也可以在此搜索出发地....";  
    startAddrSearchBar.keyboardType =  UIKeyboardTypeDefault; 
    startAddrSearchBar.showsCancelButton = YES;

    
    for(id cc in [startAddrSearchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            btn.enabled = YES;
        }
    } 
    
    UIView *segment = [startAddrSearchBar.subviews objectAtIndex:0];  
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u0_normal.png"]];  
    [segment addSubview: bgImage];  
    [bgImage release];
    [self.view addSubview:startAddrSearchBar];  
    
    orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 320, self.view.bounds.size.height -45) style:UITableViewStylePlain];
    orderTableView.separatorColor = [UIColor grayColor];
    orderTableView.separatorStyle =UITableViewCellEditingStyleNone;
    orderTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    orderTableView.delegate = self;
    orderTableView.dataSource = self;
    [orderTableView setSeparatorColor:[UIColor blackColor]];
    [self.view addSubview:orderTableView];
    



}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [cityArray count];

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell ==nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
       
        
        UIImageView * lineImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u93_line.png"]];
        lineImage.frame = CGRectMake(0,44, 320, 3);
        [cell.contentView addSubview:lineImage];
                                  
    }
    BMKPoiInfo * bmn = [cityArray objectAtIndex:indexPath.row];
    NSString * cityName =bmn.name;
    cell.textLabel.text = cityName;
    return cell;
}


- (void)onGetPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
    NSLog(@"%d",[poiResultList count]);
    BMKPoiResult * na = [poiResultList objectAtIndex:0];
    int c = na.totalPoiNum;
    NSLog(@"%d",c);
    NSArray * name = na.poiInfoList;
    for (int i = 0; i<[name count]; i++) {
        BMKPoiInfo * bmk = [name objectAtIndex:i];
        [cityArray addObject:bmk];
    }
    [orderTableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    CLLocationCoordinate2D  venter;
    venter.latitude = 39.915101;
    venter.longitude = 116.403981;

     [_search poiSearchNearBy:@"华龙大厦" center:venter radius:30000 pageIndex:0];

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
-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];

}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{

    [self dismissModalViewControllerAnimated:NO];

}
-(void)dealloc
{
    [_search release];
    [orderTableView release];
    [ startAddrSearchBar release];
    [cityArray release];
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
