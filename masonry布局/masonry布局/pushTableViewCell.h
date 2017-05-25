//
//  pushTableViewCell.h
//  masonry布局
//
//  Created by 何达达 on 2017/5/17.
//  Copyright © 2017年 何达达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pushTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
- (IBAction)selectBtnClick:(id)sender;
@property(nonatomic,assign)NSInteger cellCount;
@property (nonatomic,copy) void(^ChoseBtnBlock)(id,BOOL);
@property (nonatomic,assign) BOOL selectedStutas;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
