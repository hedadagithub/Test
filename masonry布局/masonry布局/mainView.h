//
//  mainView.h
//  masonry布局
//
//  Created by 何达达 on 2017/5/16.
//  Copyright © 2017年 何达达. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^contactBlock)(NSLayoutConstraint *contact,UIButton *btn);
@interface mainView : UIView
+(instancetype)createBottomView;
@property(nonatomic,copy)contactBlock contactBlock;
//@property(nonatomic,copy)void(^block)(NSLayoutConstraint *) ;
//-(void)initWithBlock:(int(^)(NSLayoutConstraint *)) block;
@end
