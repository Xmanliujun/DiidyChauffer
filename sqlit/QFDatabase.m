
#import "QFDatabase.h"
#import "FMDatabase.h"
#import "FMDatabasePool.h"
#import "DIIdyModel.h"
#import "Helper.h"
#import "CONST.h"
#import "AppDelegate.h"
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
//    NSString *sql = @"CREATE TABLE IF NOT EXISTS  news (order_id TEXT(1024),starttime TEXT(1024) DEFAULT NULL,startaddr TEXT(1024) DEFAULT NULL,endaddr TEXT(1024) DEFAULT NULL, number TEXT(1024),contactname TEXT(1024) DEFAULT NULL,contactmobile TEXT(1024) DEFAULT NULL,createtime TEXT(1024) ,coupon TEXT(1024) DEFAULT NULL,status TEXT(1024),Primary Key(serial,link))";
     NSString *sql = @"CREATE TABLE IF NOT EXISTS  news (orderid TEXT(1024),starttime TEXT(1024),startaddr TEXT(1024),endaddr TEXT(1024), number TEXT(1024),contactname TEXT(1024),contactmobile TEXT(1024),createtime TEXT(1024) ,coupon TEXT(1024),status TEXT(1024),age TEXT)";
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
        item.coupon = item.coupon?item.coupon:@"";
        item.status= item.status?item.status:@"";
    }
}
//fmdb方式插入一条 数据
-(BOOL)insertItemWithFMDB:(DIIdyModel *)item
{
    [self checkItem:item];
    BOOL isSuccessed=NO;
    isSuccessed=[fmdb executeUpdate:@"INSERT INTO news(orderid,starttime,startaddr,endaddr,number,contactname,contactmobile,createtime,coupon,status,age) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)",
                 item.orderID,
                 item.startTime,
                 item.startAddr,
                 item.endAddr,
                 item.ordersNumber,
                 item.contactName,
                 item.contactMobile,
                 item.createTime,
                 item.coupon,
                 item.status,
                 ShareApp.mobilNumber
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
    
//    FMResultSet *rs = [fmdb executeQuery:@"SELECT orderid,starttime,startaddr,endaddr,number,contactname,contactmobile,createtime,coupon,status FROM news"];
    
    
    FMResultSet *rs=[fmdb executeQuery:@"SELECT * FROM news"];
    rs=[fmdb executeQuery:@"SELECT * FROM news WHERE age = ?",ShareApp.mobilNumber];
    
    NSLog(@"%@",[fmdb lastErrorMessage]);
    
    while ([rs next]) {
            
        DIIdyModel *item=[[DIIdyModel alloc] init];
        item.orderID = [rs stringForColumn:@"orderid"];
        item.startTime =[rs stringForColumn:@"starttime"];
        item.startAddr=[rs stringForColumn:@"startaddr"];
        item.endAddr=[rs stringForColumn:@"endaddr"];
        item.ordersNumber=[rs stringForColumn:@"number"];
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
