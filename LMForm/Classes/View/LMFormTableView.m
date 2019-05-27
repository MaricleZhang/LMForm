//
//  LMFormTableView.m
//  LoanMarket
//
//  Created by 张建 on 2019/4/30.
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
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        
        [self registerClass:[LMFormCell class] forCellReuseIdentifier:NSStringFromClass([LMFormCell class])];
    }
    return self;
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
    
    return (model.height > 0) ? model.height : QL_XX_6(50);
}

#pragma mark - Setter/Getter

- (void)setDataArray:(NSArray<LMFormModel *> *)dataArray
{
    _dataArray = dataArray;
    
    for (LMFormModel *model in self.dataArray)
    {
        Class cls = [[LMFormTypeManager manager] getClassWithKey:model.formType];
        if (cls)
        {
            [self registerClass:cls forCellReuseIdentifier:NSStringFromClass(cls)];
        }
    }
    
    [self reloadData];
}

@end
