//
//  LMCustomCell.m
//  LMForm_Example
//
//  Created by 张建 on 2019/5/27.
//  Copyright © 2019 MaricleZhang. All rights reserved.
//

#import "LMCustomCell.h"
#import "LMFormModel.h"

@interface LMCustomCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation LMCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self.contentView addSubview:self.imgView];
}

- (void)configModel:(LMFormModel *)model
{
    self.textLabel.text = model.title;
}

- (UIImageView *)imgView
{
    if (!_imgView)
    {
        _imgView = [[UIImageView alloc] init];
        _imgView.frame = CGRectMake(150, 0, 200, 50);
        _imgView.backgroundColor = [UIColor redColor];
    }
    return _imgView;
}

@end
