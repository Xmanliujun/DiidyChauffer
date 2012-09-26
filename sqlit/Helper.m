//
//  Helper.m
//  XmlParserDemo
//
//  Created by 杜 海峰 on 12-5-23.
//  Copyright (c) 2012年 北京千锋互联科技有限公司. All rights reserved.
//

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
