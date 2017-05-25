//
//  FMDBManager.h
//  masonry布局
//
//  Created by 何达达 on 2017/5/18.
//  Copyright © 2017年 何达达. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"
@class StudentModel;
@interface FMDBManager : NSObject
-(void)initwithtable:(NSString *)fileName;

+(FMDBManager *)shareManager;

-(BOOL) insterDataWithModel :(StudentModel *) model;

-(FMResultSet *) backResults : (NSString *) conditions;

@end
