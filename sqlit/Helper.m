
#import "Helper.h"

@implementation Helper

+ (NSString *) databasePath:(NSString*)fileName
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]; 
    /* 取得Documents目录 */
    /* PathComponent 就是/  */
    NSLog(@"path is %@", path);
    
    if (!fileName) {
        return path;
    }
    return [path stringByAppendingPathComponent:fileName];
    
}


@end
