//
//  QFDatabase.m
//  XmlParserDemo
//
//  Created by 杜 海峰 on 12-5-22.
//  Copyright (c) 2012年 北京千锋互联科技有限公司. All rights reserved.
//

#import "QFDatabase.h"
#import "FMDatabase.h"
#import "FMDatabasePool.h"
#import "DIIdyModel.h"
#import "Helper.h"
#import "CONST.h"

//数据库文件名
#define DBNAME @"mydb.sqlite3"

@implementation QFDatabase
@synthesize mNewsArray;
@synthesize fmdb,fmdbPool,dbFilePath;

-(id)init
{
    if (self=[super init]) {
        
    }
    return self;
}
-(void)closeDB
{
    [fmdb close];
}
-(void)openDatabase:(NSInteger)useType{
    
    
    self.dbFilePath=[Helper databasePath:DBNAME];
    //数据库文件存在就打开，不存在就创建再打开
    self.fmdb=[FMDatabase databaseWithPath:dbFilePath];
    if (![fmdb open]) {
      NSLog(@"数据库打开失败");
    }
    else{
        
        [self createTablePool];
    }
    //[fmdb executeUpdate:@"VACUUM"];//压缩数据库内容
            
     self.fmdbPool=[FMDatabasePool databasePoolWithPath:dbFilePath];
          
    
    return;
}



-(void)createTablePool
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS  news (order_id TEXT(1024),starttime TEXT(1024) DEFAULT NULL,startaddr TEXT(1024) DEFAULT NULL,endaddr TEXT(1024) DEFAULT NULL, number TEXT(1024),contactname TEXT(1024) DEFAULT NULL,contactmobile TEXT(1024) DEFAULT NULL,createtime TEXT(1024) ,coupon TEXT(1024) DEFAULT NULL,status TEXT(1024),Primary Key(serial,link))";
    
    if (![fmdb executeUpdate:sql]) {
        NSLog(@"创建表失败");
    }
    
}

-(void)insertToDatabase:(NSArray *)array
{
    [fmdb beginTransaction];
      for (DIIdyModel *item in array) {
        [self insertItemWithFMDB:item];
    }
        [fmdb commit];
        
}
//fmdb

//检查数据合法性
-(void)checkItem:(DIIdyModel*)item
{
    if (item) {
        item.orderID=item.orderID?item.orderID:@"";
        item.startTime=item.startTime?item.startTime:@"";
        item.startAddr=item.startAddr?item.startAddr:@"";
        item.endAddr=item.endAddr?item.endAddr:@"";
        item.ordersNumber=item.ordersNumber?item.ordersNumber:@"";
        item.contactName=item.contactName?item.contactName:@"";
        item.contactMobile=item.contactMobile?item.contactMobile:@"";
        item.createTime=item.createTime?item.createTime:@"";
    }
}
//fmdb方式插入一条 数据
-(BOOL)insertItemWithFMDB:(DIIdyModel *)item
{
    [self checkItem:item];
    
    BOOL isSuccessed=NO;
    isSuccessed=[fmdb executeUpdate:@"INSERT INTO news (order_id,starttime,startaddr,endaddr,number,contactname,contactmobile,createtime,coupon,status) values (?, ?, ?, ?, ?, ?, ?, ?,?,?)",
                 item.orderID,
                 item.startTime,
                 item.startAddr,
                 item.endAddr,
                 item.number,
                 item.contactName,
                 item.contactMobile,
                 item.createTime,
                 item.coupon,
                 item.status
                 ];
    return isSuccessed;
}

//fmdb方式读取数据
-(NSArray*)readDataWithFMDB
{
    
    if (!mNewsArray) {
        mNewsArray=[[NSMutableArray alloc] init];
    }
    else{
        [mNewsArray removeAllObjects];
    }
    
    FMResultSet *rs = [fmdb executeQuery:@"SELECT order_id,starttime,startaddr,endaddr,number,contactname,contactmobile,createtime,coupon,status FROM news"];
    NSLog(@"%@",[fmdb lastErrorMessage]);
    
    while ([rs next]) {
            
        DIIdyModel *item=[[DIIdyModel alloc] init];
        item.orderID = [rs stringForColumn:@"orderid"];
        item.startTime =[rs stringForColumn:@"starttime"];
        item.startAddr=[rs stringForColumn:@"startaddr"];
        item.endAddr=[rs stringForColumn:@"endaddr"];
        item.number=[rs stringForColumn:@"number"];
        item.contactName=[rs stringForColumn:@"contactname"];
        item.contactMobile=[rs stringForColumn:@"contactmobile"];
        item.createTime=[rs stringForColumn:@"createtime"];
        item.coupon=[rs stringForColumn:@"coupon"];
        item.status=[rs stringForColumn:@"status"];

        [mNewsArray addObject:item];
        
        [item release];
    }
    return mNewsArray;
}

@end
