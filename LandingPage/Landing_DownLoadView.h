//
//  Landing_DownLoadView.h
//  DiidyProject
//
//  Created by diidy on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownLoadDelegate.h"
@interface Landing_DownLoadView : NSObject
{
    id <DownLoadDelegate>delegate;

}
-(void)downloadLanding:(NSURL*)url;
@property (nonatomic,assign) id<DownLoadDelegate> delegate;
@end
