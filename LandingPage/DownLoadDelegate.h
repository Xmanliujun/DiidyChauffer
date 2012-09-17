//
//  DownLoadDelegate.h
//  DiidyProject
//
//  Created by diidy on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownLoadDelegate <NSObject>
-(void)completeDownLoad:(NSString*)returenNews;
@end
