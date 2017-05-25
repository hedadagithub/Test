//
//  TextViewController.m
//  masonry布局
//
//  Created by 何达达 on 2017/5/17.
//  Copyright © 2017年 何达达. All rights reserved.
//

#import "TextViewController.h"
#import "Masonry.h"
#import "TextTableViewCell.h"
#import <CoreMotion/CoreMotion.h>
@interface TextViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)CMAltimeter *altimeter;
@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupTable];
    if (![CMAltimeter isRelativeAltitudeAvailable]) {
        NSLog(@"设备不支持");
        return;
    }
    self.altimeter = [[CMAltimeter alloc]init];
    [self.altimeter startRelativeAltitudeUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAltitudeData * _Nullable altitudeData, NSError * _Nullable error) {
        NSLog(@"%@ ---- %@",altitudeData.relativeAltitude,altitudeData.pressure);
    }];
    
}

-(void)setupTable{
    __weak typeof(self) WeakSelf = self;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.rowHeight = 65;
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(WeakSelf.view).with.insets(UIEdgeInsetsMake(60, 0, 0, 0));
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.studentArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextTableViewCell *cell = [TextTableViewCell cellWithTableView:tableView];
    StudentModel *model = self.studentArry[indexPath.row];
    cell.model = model;
        return cell;
}
-(void)setStudentArry:(NSMutableArray<StudentModel *> *)studentArry
{
    _studentArry = studentArry;
    [self.tableView reloadData];
}
- (IBAction)backClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
