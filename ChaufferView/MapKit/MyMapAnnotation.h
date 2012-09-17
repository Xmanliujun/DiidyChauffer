//
//  MyMapAnnotation.h
//  EnterpriseIM
//
//  Created by Tjatse on 12-6-4.
//  Copyright (c) 2012年 MceSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface MyMapAnnotation : NSObject<MKAnnotation>{
    
	CLLocationCoordinate2D  coordinate; 
	NSString                *address; 
	NSString                *title; 
	NSString                *subtitle;
}
@property (nonatomic, assign)   CLLocationCoordinate2D coordinate; 
@property (nonatomic, retain)   NSString *address; 
@property (nonatomic, copy)     NSString *title; 
@property (nonatomic, copy)     NSString *subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D) theCoordinate
             andAddress:(NSString *)theAddress ;

@end


@interface DisplayMapAnnotation : NSObject<MKAnnotation>{
    
	CLLocationCoordinate2D coordinate; 
	NSString *title; 
	NSString *subtitle;
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 
@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *subtitle;

@end

