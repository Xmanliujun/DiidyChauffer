
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
-(void)insertToDatabase:(NSArray *)array;
-(BOOL)insertItemWithFMDB:(DIIdyModel *)item;
-(void)createTablePool;

@end
