//
//  MyMapAnnotation.m
//  EnterpriseIM
//
//  Created by Tjatse on 12-6-4.
//  Copyright (c) 2012年 MceSky. All rights reserved.
//

#import "MyMapAnnotation.h"

@implementation MyMapAnnotation 

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

@implementation DisplayMapAnnotation

@synthesize coordinate,title,subtitle;


-(void)dealloc{
	[title release];
	[super dealloc];
}

@end
