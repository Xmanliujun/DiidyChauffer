//
//  DriverPostion.h
//  DiidyProject
//
//  Created by diidy on 12-9-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DriverPostion : NSObject
<MKAnnotation>
{
    NSString *_title;
    NSString *_subtitle;
    double _long;
    double _lat;
}
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, assign) double longtitude;
@property (nonatomic, assign) double latitude;
- (id) initWithTitle:(NSString *)t withSubtitle:(NSString *)s withLatitude:(double)lat withLongtitude:(double)lng;

@end



#if 0
@protocol MKAnnotation <NSObject>
- (CLLocationCoordinate2D) coordinate;
- (NSString *) title;
- (NSString *) subtitle;
@end
#endif

