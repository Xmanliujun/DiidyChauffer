//
//  MapAnnotion.h
//  BaiduMapApiDemo
//
//  Created by diidy on 12-9-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMKShape.h"
#import <CoreLocation/CLLocation.h>


@interface MapAnnotion : BMKShape
@property (nonatomic, assign)   CLLocationCoordinate2D coordinate; 
@property (nonatomic, retain)   NSString *address; 
@property (nonatomic, copy)     NSString *title; 
@property (nonatomic, copy)     NSString *subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D) theCoordinate
             andAddress:(NSString *)theAddress ;

@end
