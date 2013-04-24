//
//  DownLoadDelegate.h
//  DiidyProject
//
//  Created by diidy on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownLoadDelegate <NSObject>
@optional
-(void)completeDownLoad:(NSString*)returenNews;
-(void)completeDownLoadVerson:(int)returenNews withVerson:(NSString*)newVerson;
@end
