//
//  LMFormCell.m
//  LoanMarket
//
//  Created by Zhang on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormCell.h"

@interface LMFormCell ()

@property (nonatomic, strong) UIView *line;

@end

@implementation LMFormCell

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.line];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.x = LM_XX_6(24);
    self.titleLabel.centerY = self.contentView.height / 2;
    
    self.line.frame = CGRectMake(LM_XX_6(24), self.contentView.height - 1, self.contentView.width - LM_XX_6(24) - LM_XX_6(15), 1);
}

#pragma mark - Setter/Getter

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = LM_UIColorFromHEX(0x666666);
        _titleLabel.font = [UIFont systemFontOfSize:LM_XX_6(14)];
    }
    return _titleLabel;
}

- (UIView *)line
{
    if (!_line)
    {
        _line = [[UIView alloc] init];
        _line.backgroundColor = LM_UIColorFromHEX(0xF4F4F4);
    }
    return _line;
}

- (void)configModel:(LMFormModel *)model
{
    self.model = model;
    
    self.titleLabel.text = model.title;
    self.line.hidden = model.hiddenLine;
}


@end
