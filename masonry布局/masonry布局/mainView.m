//
//  mainView.m
//  masonry布局
//
//  Created by 何达达 on 2017/5/16.
//  Copyright © 2017年 何达达. All rights reserved.
//

#import "mainView.h"

@interface mainView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contact;
@property (weak, nonatomic) IBOutlet UIButton *saoBtn;

@end


@implementation mainView

+(instancetype)createBottomView{

    return [[[NSBundle mainBundle] loadNibNamed:@"mainView" owner:self options:nil] lastObject];
}
- (IBAction)saoClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.contactBlock) {
        self.contactBlock(self.contact,self.saoBtn);
    }
}

-(void)awakeFromNib
{
    
    [super awakeFromNib];
}

@end
