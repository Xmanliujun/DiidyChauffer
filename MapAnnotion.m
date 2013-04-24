//
//  MapAnnotion.m
//  BaiduMapApiDemo
//
//  Created by diidy on 12-9-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotion.h"

@implementation MapAnnotion

@synthesize coordinate;
@synthesize address;
@synthesize title;
@synthesize subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D)theCoordinate 
             andAddress:(NSString *)theAddress
{
    self = [super init];
    if(self){
        self.coordinate = theCoordinate;
        self.address = [theAddress retain];
    }
    return self;
}

-(NSString *)title{
    
    return @"位置";
}

-(NSString *)subtitle{
    
    return self.address;
}

-(void)dealloc{
    
	[address release];
	[super dealloc];
}
@end

