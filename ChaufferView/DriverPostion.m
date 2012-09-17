//
//  DriverPostion.m
//  DiidyProject
//
//  Created by diidy on 12-9-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DriverPostion.h"
#import <MapKit/MapKit.h>


@implementation DriverPostion
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize longtitude = _long;
@synthesize latitude = _lat;


- (id) initWithTitle:(NSString *)t withSubtitle:(NSString *)s withLatitude:(double)lat withLongtitude:(double)lng {
    self = [super init];
    if(self) {
        
        NSLog(@"1");
        _lat = lat;
        _long = lng;
       
        _title = [t retain];
        _subtitle = [s retain];
        
    }
    return self;
}
- (void) dealloc {
    
    [_subtitle release], _subtitle = nil;
    [_title release], _title = nil;;
  
    [super dealloc];
}
- (CLLocationCoordinate2D) coordinate {
    CLLocationCoordinate2D c;
   
    NSLog(@"2");
    
    c.longitude = _long;
    c.latitude = _lat;
    return c;
}
- (NSString *) title {
    
    NSLog(@"3");
    return _title;
}
- (NSString *) subtitle {
    
    NSLog(@"4");
    return _subtitle;
}

@end


