//
//  CouponDelegate.h
//  DiidyProject
//
//  Created by diidy on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CouponDelegate <NSObject>
-(void)selectedCoupon:(NSArray*)couponArray;
@end
