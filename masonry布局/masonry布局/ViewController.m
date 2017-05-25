//
//  ViewController.m
//  masonry布局
//
//  Created by 何达达 on 2017/5/16.
//  Copyright © 2017年 何达达. All rights reserved.
//
#define MWidth  [UIScreen mainScreen].bounds.size.width
#define MHeight [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "Masonry.h"
#import "mainTableViewCell.h"
#import "mainView.h"
#import "PushViewController.h"
#import <CoreMotion/CoreMotion.h>
static NSString *ID = @"mainCell";
@interface ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CMAltimeter *altimeter;
@end

@implementation ViewController
-(CMAltimeter *)altimeter
{
    if (!_altimeter) {
        _altimeter = [[CMAltimeter alloc]init];
    }
    return _altimeter;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  //  [self setupSubviews];
    [self setupsubViewsAndTable];
    if (![CMAltimeter isRelativeAltitudeAvailable]) {
        NSLog(@"不支持");
    }
   

}

-(void)setupsubViewsAndTable{
    __weak typeof(self) WeakSelf = self;
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(WeakSelf.view);
        make.left.right.mas_equalTo(WeakSelf.view);
        make.height.equalTo(@150);
    }];
    
    UITableView *mainTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    [self.view addSubview:mainTable];
 
    [mainTable registerClass:mainTableViewCell.class forCellReuseIdentifier:ID];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(WeakSelf.view).with.insets(UIEdgeInsetsMake(150, 0, 60, 0));
    }];
    
    mainView *main = [mainView createBottomView];
    
    [self.view addSubview:main];
    [main mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(WeakSelf.view);
        make.height.equalTo(@60);
    }];
    [UIView animateWithDuration:3.0 animations:^{
        main.contactBlock = ^(NSLayoutConstraint *contact, UIButton *btn) {
            if (btn.selected) {
                contact.constant = 100;
                PushViewController *push = [[PushViewController alloc]init];
                [self presentViewController:push animated:YES completion:nil];
                
            }else{
                contact.constant = 50;
                btn.backgroundColor = [UIColor blackColor];
            }
        };
    }];
    
    
}


#pragma table的代理和数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 130;
    if (indexPath.section == 1) return 170;
    return 250;
}
@end
