//
//  DrivePosition.m
//  BaiduMapApiDemo
//
//  Created by diidy on 12-9-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrivePosition.h"

@implementation DrivePosition

@synthesize coordinate;

@synthesize title;
@synthesize subtitle,newtitle,newsubtitle;

-(id)initWithTitle:(NSString *)t withSubtitle:(NSString *)s withLatitude:(double)lat withLongtitude:(double)lng
{
    self = [super init];
    if(self){
        
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = lat;
        theCoordinate.longitude = lng;
        self.coordinate = theCoordinate;
        self.newtitle =t;
        self.newsubtitle = s;
    }
    return self;
}

-(NSString *)title{
    return self.newtitle;
}

-(NSString *)subtitle{
    return self.newsubtitle;
}

-(void)dealloc{
    [newsubtitle release];
	[newtitle release];
	[super dealloc];
}
@end

