//
//  LMFormTableView.m
//  LMForm
//
//  Created by Zhang on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormTableView.h"
#import "LMFormCell.h"
#import "LMFormTypeManager.h"

@interface LMFormTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation LMFormTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initData];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initData];
    }
    return self;
}

- (void)initData
{
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor whiteColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsVerticalScrollIndicator = NO;
    
    [self registerClass:[LMFormCell class] forCellReuseIdentifier:NSStringFromClass([LMFormCell class])];
}

#pragma mark - UITableViewSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMFormModel *model = [self.dataArray objectAtIndex:indexPath.row];
    Class cls = [[LMFormTypeManager manager] getClassWithKey:model.formType];
    LMFormCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass(cls)];
    if (!cell)
    {
       cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([LMFormCell class])];
    }
    
    if ([cell conformsToProtocol:@protocol(LMFormCellProtocol)])
    {
        [cell configModel:model];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMFormModel *model = [self.dataArray objectAtIndex:indexPath.row];

    return (model.height > 0) ? model.height : LM_XX_6(50);
}

- (void)registerClassWithDataArray:(NSArray<LMFormModel *> *)dataArray
{
    NSMutableSet *set = [NSMutableSet set];
    for (LMFormModel *model in self.dataArray)
    {
        Class cls = [[LMFormTypeManager manager] getClassWithKey:model.formType];
        [set addObject:cls];
    }
    
    for (Class cls in set)
    {
        [self registerClass:cls forCellReuseIdentifier:NSStringFromClass(cls)];
    }
}

#pragma mark - Setter/Getter

- (void)setDataArray:(NSArray<LMFormModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self registerClassWithDataArray:dataArray];
    
    [self reloadData];
}

@end
