//
//  TextTableViewCell.h
//  masonry布局
//
//  Created by 何达达 on 2017/5/17.
//  Copyright © 2017年 何达达. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StudentModel;
@interface TextTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)StudentModel *model;
@end
