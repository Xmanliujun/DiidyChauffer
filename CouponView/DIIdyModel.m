//
//  DIIdyModel.m
//  DiidyProject
//
//  Created by diidy on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DIIdyModel.h"

@implementation DIIdyModel
@synthesize ID,type,name,amount,close_date,number,orderID,startTime,startAddr,endAddr,ordersNumber,contactMobile,contactName,coupon,status,createTime,numberID;

-(void)dealloc
{
    [createTime release];
    [orderID release];
    [startTime release];
    [startAddr release];
    [endAddr release];
    [ordersNumber release];
    [contactMobile release];
    [contactName release];
    [coupon release];
    [status release];
    [ID release];
    [type release];
    [name release];
    [amount release];
    [close_date release];
    [number release];
    [super dealloc];

}
@end
