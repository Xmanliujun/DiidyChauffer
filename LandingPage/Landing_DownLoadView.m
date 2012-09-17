//
//  Landing_DownLoadView.m
//  DiidyProject
//
//  Created by diidy on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Landing_DownLoadView.h"
#import "SBJson.h"
#import "ASIHTTPRequest.h"
@implementation Landing_DownLoadView
@synthesize delegate;

-(id)init
{
    self = [super init];
    if(self){
        
    }
    return self;
}


-(void)parseStringJson:(NSString *)str
{
    NSDictionary * jsonParser =[str JSONValue];
    NSString * returenNews =[jsonParser objectForKey:@"r"];
    [delegate completeDownLoad:returenNews];

}
-(void)downloadLanding:(NSURL*)url
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSLog(@"%@",url);
    [request setDelegate:self];
    [request setTag:100];
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self parseStringJson:[request responseString]];
    
}
@end


