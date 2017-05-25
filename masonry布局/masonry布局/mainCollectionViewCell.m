//
//  mainCollectionViewCell.m
//  masonry布局
//
//  Created by 何达达 on 2017/5/16.
//  Copyright © 2017年 何达达. All rights reserved.
//

#import "mainCollectionViewCell.h"
#import "Masonry.h"

@interface mainCollectionViewCell()<UITextFieldDelegate>

@end

@implementation mainCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubviews];
    }
    return self;
}


-(void)setSubviews{
   
    UIButton* checkImageView=[[UIButton alloc] init];
    checkImageView.backgroundColor = [UIColor blueColor];
    checkImageView.userInteractionEnabled=NO;
    [self.contentView addSubview:checkImageView];
    self.checkImageView=checkImageView;
    
    UILabel* label=[[UILabel alloc] init];
    label.font=[UIFont systemFontOfSize:15.0];
    label.backgroundColor=[UIColor blackColor];
    [self.contentView addSubview:label];
    self.label=label;
    
    UITextField* textField=[[UITextField alloc] init];
  
    textField.delegate=self;
    textField.borderStyle=UITextBorderStyleRoundedRect;
    [self.contentView addSubview:textField];
    self.textField=textField;
    
    [checkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.left.mas_equalTo(self.contentView).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(20,20));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.left.equalTo(checkImageView.mas_right).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-5);
        make.height.mas_equalTo(20);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.left.equalTo(checkImageView.mas_right).with.offset(50);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
    }];
    
}
@end
