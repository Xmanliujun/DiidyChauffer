//
//  SearchDepartureViewController.h
//  DiidyProject
//
//  Created by diidy on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface SearchDepartureViewController : UIViewController
<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,BMKSearchDelegate,UISearchBarDelegate>
{
    BMKSearch* _search;
    UISearchBar* startAddrSearchBar;
    NSMutableArray*cityArray;
    UITableView * orderTableView;
    UIButton *returnButton;
    UIImageView*topImageView;
}
@end
