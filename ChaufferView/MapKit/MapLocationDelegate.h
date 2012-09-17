//
//  MapLocationDelegate.h
//  EnterpriseIM
//
//  Created by Tjatse on 12-6-4.
//  Copyright (c) 2012年 MceSky. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyMapAnnotation;
@protocol MapLocationDelegate <NSObject>
@optional
-(void)postLocation:(MyMapAnnotation *)annotation;
-(void)selectTheCurrentLocationOnLine:(NSString*)text;
@end