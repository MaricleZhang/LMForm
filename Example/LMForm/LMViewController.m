//
//  LMViewController.m
//  LMForm
//
//  Created by MaricleZhang on 05/23/2019.
//  Copyright (c) 2019 MaricleZhang. All rights reserved.
//

#import "LMViewController.h"
#import "LMForm.h"
#import "LMCustomCell.h"
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

    [self.dataArray addObject:[self loadText]];
    [self.dataArray addObject:[self loadInput]];
    [self.dataArray addObject:[self loadSelector]];
    [self.dataArray addObject:[self loadDateSelector]];
    [self.dataArray addObject:[self loadAdressInput]];
//    [self.dataArray addObject:[self loadCustom]];

    self.tableView.dataArray = self.dataArray;
}

- (void)createUI
{
    self.navigationItem.title = @"Demo";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(tapSaveAction)];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.frame;
}

// 不可编辑文本
- (LMFormModel *)loadText
{
    LMFormModel *model = [LMFormModel new];
    model.formType = kFormTypeText;
    model.title = @"姓名";
    model.key = @"name";
    model.value = @"Tom";
    model.height = LM_XX_6(50);
    
    return model;
}

// 输入框
- (LMFormModel *)loadInput
{
    LMFormModel *model = [LMFormModel new];
    model.formType = kFormTypeInput;
    model.title = @"手机号";
    model.key = @"mobile";
    model.value = @"";
    model.placeholder = @"请输入手机号";
    model.height = LM_XX_6(50);
    model.message = @"请输入正确的手机号";
    model.limitLength = 11;
    model.validateBlock = ^BOOL(LMFormModel * _Nullable model) {
        if (![LMFormValidator isMobile:model.value])
        {
            [LMWindowHud showHud:model.message];
            return NO;
        }
        return YES;
    };
    return model;
}

// 选择器
- (LMFormModel *)loadSelector
{
    LMFormModel *model = [LMFormModel new];
    model.formType = kFormTypeSelector;
    model.title = @"性别";
    model.key = @"gender";
    model.value = @"";
    model.placeholder = @"请选择性别";
    model.height = LM_XX_6(50);
    model.message = @"请选择性别";
    model.selectList = @[@"男",@"女"];
    model.validateBlock = ^BOOL(LMFormModel * _Nullable model) {
        if ([LMFormValidator isEmptyValue:model.value])
        {
            [LMWindowHud showHud:model.message];
            return NO;
        }
        return YES;
    };
    
    return model;
}

 // 日期选择器
- (LMFormModel *)loadDateSelector
{
    LMFormModel *model = [LMFormModel new];
    model.formType = kFormTypeDate;
    model.title = @"出生日期";
    model.key = @"birth";
    model.value = @"";
    model.placeholder = @"请选择出生日期";
    model.height = LM_XX_6(50);
    model.message = @"请选择出生日期";
    model.datePickerMode = UIDatePickerModeDate;
    model.dateFormat = @"yyyy-MM-dd";
    
    return model;
}

// 地址输入框
- (LMFormModel *)loadAdressInput
{
    LMFormModel *model = [LMFormModel new];
    model.formType = kFormTypeAddressInput;
    model.title = @"详细地址";
    model.key = @"detailAdress";
    model.value = @"";
    model.placeholder = @"请输入详细地址";
    model.height = LM_XX_6(68);
    model.message = @"详细地址不得少于5位";
    model.validateBlock = ^BOOL(LMFormModel * _Nullable model) {
        if (model.value.length < 5)
        {
            [LMWindowHud showHud:model.message];
            return NO;
        }
        return YES;
    };
    
    return model;
}

// 自定义cell
- (LMFormModel *)loadCustom
{
    [[LMFormTypeManager manager] registerCellClass:[LMCustomCell class] forKey:kCustomCell];
    LMFormModel *model = [LMFormModel new];
    model.formType = kCustomCell;
    model.title = @"custom cell";
    
    return model;
}

#pragma mark - Responce

- (void)tapSaveAction
{
    @weakify(self)
    [LMFormValidator validateDataArray:self.dataArray];
    [self.dataArray enumerateObjectsUsingBlock:^(LMFormModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
//        if (obj.validateBlock)
//        {
//           BOOL isValidate = obj.validateBlock(obj);
//        }
//        @strongify(self)
//        NSLog(@"obj.value:%@",obj.value);
//
//        if (obj.isRequire && obj.validator && ![obj.validator isValidate:obj.value])
//        {
//            [LMWindowHud showHud:obj.message];
//            *stop = YES;
//            return;
//        }
//
//        if (obj.isRequire && !obj.validator && (obj.value.length == 0 || obj.value == nil))
//        {
//            [LMWindowHud showHud:obj.message];
//            *stop = YES;
//            return;
//        }

    }];
}

#pragma mark - Setter/Getter

- (LMFormTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[LMFormTableView alloc] init];
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
