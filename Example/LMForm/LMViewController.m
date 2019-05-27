//
//  LMViewController.m
//  LMForm
//
//  Created by MaricleZhang on 05/23/2019.
//  Copyright (c) 2019 MaricleZhang. All rights reserved.
//

#import "LMViewController.h"
#import "LMFormTableView.h"
#import "LMMarco.h"
#import "LMForm.h"
#import "LMCustomCell.h"
#import "LMFormTypeManager.h"
#import "LMWindowHud.h"

#define kCustomCell  @"custom"

@interface LMViewController ()

@property (nonatomic, strong) LMFormTableView *tableView;
@property (nonatomic, copy) NSMutableArray<LMFormModel *> *dataArray;
@end

@implementation LMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
    
    [self loadData];
}

- (void)createUI
{
    self.navigationItem.title = @"Demo";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(tapSaveAction)];
    
    [self.view addSubview:self.tableView];
}

- (void)loadData
{
    // 不可编辑文本
    LMFormModel *model0 = [LMFormModel new];
    model0.formType = kFormTypeText;
    model0.title = @"姓名";
    model0.key = @"name";
    model0.value = @"Tom";
    model0.isRequire = YES;
    model0.height = QL_XX_6(50);
    [self.dataArray addObject:model0];
    
    // 输入框
    LMFormModel *model1 = [LMFormModel new];
    model1.formType = kFormTypeInput;
    model1.title = @"手机号";
    model1.key = @"mobile";
    model1.value = @"";
    model1.placeholder = @"请输入手机号";
    model1.isRequire = YES;
    model1.height = QL_XX_6(50);
    model1.message = @"请输入正确的手机号";
    model1.limitLength = 11;
    model1.regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    [self.dataArray addObject:model1];
    
    // 选择框
    LMFormModel *model2 = [LMFormModel new];
    model2.formType = kFormTypeSelector;
    model2.title = @"性别";
    model2.key = @"gender";
    model2.value = @"";
    model2.placeholder = @"请选择性别";
    model2.isRequire = YES;
    model2.height = QL_XX_6(50);
    model2.message = @"请选择性别";
    model2.selectList = @[@"男",@"女"];
    
    [self.dataArray addObject:model2];
    
    // 出生日期
    LMFormModel *model3 = [LMFormModel new];
    model3.formType = kFormTypeDate;
    model3.title = @"出生日期";
    model3.key = @"birth";
    model3.value = @"";
    model3.placeholder = @"请选择出生日期";
    model3.isRequire = YES;
    model3.height = QL_XX_6(50);
    model3.message = @"请选择出生日期";
    [self.dataArray addObject:model3];
    
    // 自定义cell
    [[LMFormTypeManager manager] registerCellClass:[LMCustomCell class] forKey:kCustomCell];
    LMFormModel *customModel = [LMFormModel new];
    customModel.formType = kCustomCell;
    customModel.title = @"custom cell";
    [self.dataArray addObject:customModel];

    self.tableView.dataArray = self.dataArray;
}

#pragma mark - Responce

- (void)tapSaveAction
{
    [self.dataArray enumerateObjectsUsingBlock:^(LMFormModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isRequire && obj.regex && ![obj isValidate])
        {
            [LMWindowHud showHud:obj.message];
            *stop = YES;
            return;
        }
    }];
}

#pragma mark - Setter/Getter

- (LMFormTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[LMFormTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = self.view.frame;
    }
    return _tableView;
}

- (NSMutableArray<LMFormModel *> *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
