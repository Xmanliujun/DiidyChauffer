//
//  QFDatabase.h
//  XmlParserDemo
//
//  Created by 杜 海峰 on 12-5-22.
//  Copyright (c) 2012年 北京千锋互联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class DIIdyModel;
@class FMDatabase;
@class FMDatabasePool;
@interface QFDatabase : NSObject
{

    //第三方数据库操作类相关
    FMDatabase *fmdb;
    FMDatabasePool *fmdbPool;
    
    //数据库文件全路径
    NSString* dbFilePath;//数据库文件路径
    //存放读取结果数组 
    NSMutableArray *mNewsArray;
}
@property (nonatomic,retain) NSMutableArray *mNewsArray;
@property (nonatomic, retain) FMDatabase *fmdb;
@property (nonatomic, copy) NSString *dbFilePath;
@property (nonatomic, retain)FMDatabasePool *fmdbPool;

//关闭数据库
-(void)closeDB;
//打开数据库
-(void)openDatabase:(NSInteger)useType;
//fmdb版方法
-(NSArray*)readDataWithFMDB;
-(BOOL)insertItemWithFMDB:(DIIdyModel *)item;
-(void)createTablePool;

@end
