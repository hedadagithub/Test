//
//  pushTableViewCell.m
//  masonry布局
//
//  Created by 何达达 on 2017/5/17.
//  Copyright © 2017年 何达达. All rights reserved.
//

#import "pushTableViewCell.h"

@interface pushTableViewCell()



@end

@implementation pushTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
        [self.selectBtn setImage:[UIImage imageNamed:@"OTIS_0@2x"] forState: UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"OTIS_1@2x"] forState:UIControlStateSelected];
        
    
    
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *Id = @"pushTableViewCell";
    pushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"pushTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(void)setSelectedStutas:(BOOL)selectedStutas
{
     self.selectBtn.selected = selectedStutas;

}
- (IBAction)selectBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.ChoseBtnBlock) {
        self.ChoseBtnBlock(self, sender.selected);
    }
 
}


@end
