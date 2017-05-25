//
//  PushViewController.m
//  masonry布局
//
//  Created by 何达达 on 2017/5/16.
//  Copyright © 2017年 何达达. All rights reserved.
//
//http://www.jianshu.com/p/391f6102b4fb

#import "PushViewController.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "pushTableViewCell.h"
#import "pushModel.h"
#import <MJExtension/MJExtension.h>
#import "TextViewController.h"
#import "FMDB.h"
#import "StudentModel.h"
#import "FMDBManager.h"
static NSString *ID = @"selectedCell";
@interface PushViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UIButton *iconBtn;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,weak)UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *allChooseBtn;
@property(nonatomic,strong)FMDatabaseQueue *queue;
//@property(nonatomic,strong)FMDatabase *db;
@property(nonatomic,strong)NSMutableArray <StudentModel *>*studentArry;
@end

@implementation PushViewController

-(NSMutableArray<StudentModel *> *)studentArry
{
    if (!_studentArry) {
        _studentArry = [NSMutableArray array];
        
    }
    return _studentArry;
    
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self setupSubviews];
    [self setupTable];
    [self getData];
    [[FMDBManager shareManager]initwithtable:@"app.sqlite"];
    [self.allChooseBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.allChooseBtn setTitle:@"取消全选" forState:UIControlStateSelected];
}

-(void)createDataBase{
    
    StudentModel *model = [[StudentModel alloc]init];
    model.imageString = @"/Users/hedada/Desktop/masonry布局/timg.jpeg";
    model.name = [NSString stringWithFormat:@"哈哈-%d", arc4random_uniform(100)];
    model.age = arc4random_uniform(30);
    model.sex = arc4random_uniform(2);
    [[FMDBManager shareManager] insterDataWithModel:model];
}


-(void)getData{

    for (NSInteger i = 0; i < 21; i++) {
        pushModel *model = [[pushModel alloc]init];
        model.isSelected = NO;
        [self.dataSource addObject:model];
        
    }
    [self.tableView reloadData];
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
        make.edges.mas_equalTo(WeakSelf.view).with.insets(UIEdgeInsetsMake(40, 0, 60, 0));
    }];
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    pushTableViewCell *cell = [pushTableViewCell cellWithTableView:tableView];
    
    pushTableViewCell *model = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.selectedStutas = model.isSelected;
    
    __weak typeof(self) WeakSelf = self;
    cell.ChoseBtnBlock = ^(__weak UITableViewCell *tapCell,BOOL selected){
        [self createDataBase];
        NSIndexPath *indexPath = [tableView indexPathForCell:tapCell];
        pushModel *model = [WeakSelf.dataSource objectAtIndex:indexPath.row];
        model.isSelected = selected;
        for (NSInteger i = 0; i < self.dataSource.count; i++) {
            if (i != indexPath.row) {
                if (selected) {
                    pushModel *model = [WeakSelf.dataSource objectAtIndex:i];
                    model.isSelected = !selected;
                }
               
            }
        }
        
        
            
        
        [self.tableView reloadData];
        
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    pushModel *model = [self.dataSource objectAtIndex:indexPath.row];
    model.isSelected = !model.isSelected;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]]  withRowAnimation:UITableViewRowAnimationRight];
}



-(void)iconClick:(UIButton *)sender{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"请稍等";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_sync(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            
        });
    });
    
    
}

    


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveBtn:(id)sender {
    NSMutableArray *selectArray = [NSMutableArray array];
    for (NSInteger i = 0;i < self.dataSource.count ; i++) {
        pushModel *model = [self.dataSource objectAtIndex:i];
        if (model.isSelected) {
            [selectArray addObject:[NSString stringWithFormat:@"%ld",i]];
        }
    }
    if (selectArray.count < 15) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"有必选项没选" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            TextViewController *text = [[TextViewController alloc]init];
            text.studentArry = self.studentArry;
            [self presentViewController:text animated:YES completion:nil];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];

      
        
    }
    [self.studentArry removeAllObjects];
    FMResultSet *set = [[FMDBManager shareManager]backResults:@"t_app"];
    while ([set next]) {
        StudentModel *model = [StudentModel new];
        model.imageString = [set stringForColumn:@"imageString"];
        model.name = [set stringForColumn:@"name"];
        model.age = [set intForColumn:@"age"];
        model.sex = [set intForColumn:@"sex"];
        [self.studentArry addObject:model];
    }
    
    
}

- (IBAction)allChoose:(UIButton *)sender {

    sender.selected = !sender.selected;
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        pushModel *model = [self.dataSource objectAtIndex:i];
        model.isSelected = self.allChooseBtn.selected;
        
    }
    [self.tableView reloadData];
}

@end
