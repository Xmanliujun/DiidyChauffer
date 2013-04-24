//
//  DrivePosition.h
//  BaiduMapApiDemo
//
//  Created by diidy on 12-9-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMKShape.h"
#import <CoreLocation/CLLocation.h>

@interface DrivePosition : BMKShape
{
    NSString *newtitle;
    NSString *newsubtitle;
    double _long;
    double _lat;

}
@property (nonatomic, assign)   CLLocationCoordinate2D coordinate; 
@property (nonatomic, retain)   NSString *newtitle;
@property (nonatomic, retain)   NSString *newsubtitle;
@property (nonatomic, copy)     NSString *title; 
@property (nonatomic, copy)     NSString *subtitle;

- (id) initWithTitle:(NSString *)t withSubtitle:(NSString *)s withLatitude:(double)lat withLongtitude:(double)lng;

@end
