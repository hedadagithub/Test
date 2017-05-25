//
//  TextTableViewCell.m
//  masonry布局
//
//  Created by 何达达 on 2017/5/17.
//  Copyright © 2017年 何达达. All rights reserved.
//

#import "TextTableViewCell.h"
#import "StudentModel.h"
#import <UIImageView+WebCache.h>
@interface TextTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameText;
@property (weak, nonatomic) IBOutlet UILabel *ageText;

@property (weak, nonatomic) IBOutlet UILabel *sexText;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation TextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *Id = @"TextTableViewCell";
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TextTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;

}
-(void)setModel:(StudentModel *)model
{
    _model = model;
    self.nameText.text = model.name;
    self.ageText.text = [NSString stringWithFormat:@"%d",model.age];
    self.sexText.text = model.sex == 0  ? @"男" : @"女";
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageString] placeholderImage:[UIImage imageNamed:model.imageString]];
}
@end
