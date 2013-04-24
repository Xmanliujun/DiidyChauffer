//
//  DIIdyModel.h
//  DiidyProject
//
//  Created by diidy on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIIdyModel : NSObject
{
    
    NSString* ID;//优惠劵ID
    NSString* type;//优惠劵类型
    NSString* name;//优惠劵名称
    NSString* amount;//金额
    NSString* number;//数量
    NSString* close_date;//有效期
    
    NSString* orderID;//订单ID
	NSString* startTime;//出发时间
	NSString*startAddr;//出发地
	NSString*endAddr;//目的地
	NSString*ordersNumber;//订单个数
	NSString*contactMobile;//联系人电话
	NSString*contactName;//联系人姓名
	NSString*coupon;//优惠券（名称+金额）
	NSString*status;//订单状态（1-4:已受理；5：已完成；6：已取消）
    NSString * createTime;//下单时间
}
@property(nonatomic,assign)int numberID;
@property(nonatomic,retain)NSString *ID;
@property(nonatomic,retain)NSString *type;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *amount;
@property(nonatomic,retain)NSString *number;
@property(nonatomic,retain)NSString *close_date;

@property(nonatomic,retain)NSString* orderID;
@property(nonatomic,retain)NSString* startTime;
@property(nonatomic,retain)NSString*startAddr;
@property(nonatomic,retain)NSString*endAddr;
@property(nonatomic,retain)NSString*ordersNumber;
@property(nonatomic,retain)NSString*contactMobile;
@property(nonatomic,retain)NSString*contactName;
@property(nonatomic,retain)NSString*coupon;
@property(nonatomic,retain)NSString*status;
@property(nonatomic,retain)NSString * createTime;
@end
