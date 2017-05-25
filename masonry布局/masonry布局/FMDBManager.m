//
//  FMDBManager.m
//  masonry布局
//
//  Created by 何达达 on 2017/5/18.
//  Copyright © 2017年 何达达. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDB.h"
#import "StudentModel.h"
@implementation FMDBManager
{
   
    FMDatabase *fmdb;
    FMDatabaseQueue *queue;
}

-(void) initwithtable:(NSString *)fileName
{
    
    if (self) {
        // 1、获取沙盒中数据库的路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fullPath =  [path stringByAppendingPathComponent:fileName];
        NSLog(@"%@",fullPath);
        // 2、判断 caches 文件夹是否存在.不存在则创建
        NSFileManager *manager = [NSFileManager defaultManager];
        BOOL tag = [manager fileExistsAtPath:path isDirectory:NULL];
        
        if (!tag) {
            [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
        }
        
        // 2、创建队列
        queue = [FMDatabaseQueue databaseQueueWithPath:fullPath];
        // 3、创建表
        [queue inDatabase:^(FMDatabase *db) {
            
            if ([db open]) {
                BOOL result =  [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_app (id integer PRIMARY KEY AUTOINCREMENT,imageString text NOT NULL, name text NOT NULL, age integer NOT NULL,sex integer NOT NULL);"];
                if (result) {
                    NSLog(@"创表成功");
                }else{
                    NSLog(@"创表失败");
                }
            }
           
            
            fmdb = db;
            
            
            
        }];
     
        
    }
    
}
+(FMDBManager *)shareManager
{
    static FMDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[FMDBManager alloc]init];
        }
        
    });
    return manager;
    
}

-(BOOL)insterDataWithModel:(StudentModel *)model
{
  
   
       BOOL isSucess = [fmdb executeUpdate:@"insert into t_app(imageString, name , age , sex) values(?,?,?,?);",model.imageString,model.name,@(model.age),@(model.sex)];
       if (isSucess) {
           NSLog(@"===========插入数据成功");
       }else{
           NSLog(@"-----------失败");
       }
    return isSucess;
    
}


//返回查询结果
-(FMResultSet *) backResults : (NSString *) conditions
{
    NSString *querySql = [NSString stringWithFormat:@"select * from %@",conditions];
    return  [fmdb executeQuery:querySql];
   
}
@end
