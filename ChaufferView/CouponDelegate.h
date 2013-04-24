//
//  CouponDelegate.h
//  DiidyProject
//
//  Created by diidy on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"
@protocol CouponDelegate <NSObject>
@optional
-(void)selectedCoupon:(NSArray*)couponArray;
-(void)selectTheCurrentLocationOnLine:(NSString *)text CLLocation:(CLLocationCoordinate2D)centers;
-(void)selectThePlaceOfDeparture:(NSString*)placeDeparture;
-(void)selectThePlaceOfDestion:(NSString*)placeDestion;
-(void)selectedCoupon:(NSArray *)couponArray androwNumber:(int)rowNumber;

@end
