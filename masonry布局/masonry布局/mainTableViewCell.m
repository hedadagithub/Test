//
//  mainTableViewCell.m
//  masonry布局
//
//  Created by 何达达 on 2017/5/16.
//  Copyright © 2017年 何达达. All rights reserved.
//

#import "mainTableViewCell.h"
#import "mainCollectionViewCell.h"
#define MWidth  [UIScreen mainScreen].bounds.size.width
#define MHeight [UIScreen mainScreen].bounds.size.height
static NSString *ID = @"cell";
#import "Masonry.h"
@interface mainTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UICollectionView* collectionView;
@end

@implementation mainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupCollectionView];
    }
    return self;
}
-(void)setupCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSize = CGSizeMake((MWidth-30)/2.0, 30);
    
    UICollectionView *mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    mainCollectionView.alwaysBounceVertical = YES;
    mainCollectionView.scrollEnabled = NO;
    [self.contentView addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView = mainCollectionView;
    
       [mainCollectionView registerClass:[mainCollectionViewCell class] forCellWithReuseIdentifier:ID];
    [mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


#pragma mark -- UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    mainCollectionViewCell *cell = (mainCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"log");
}
-(void)setFrame:(CGRect)frame
{
    
    [super setFrame:frame];
   
}

@end
