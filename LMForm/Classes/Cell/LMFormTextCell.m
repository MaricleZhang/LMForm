//
//  LMFormTextCell.m
//  LoanMarket
//
//  Created by Zhang on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormTextCell.h"

@interface LMFormTextCell ()

@property (nonatomic, strong) UILabel *subLabel;

@end

@implementation LMFormTextCell

- (void)createUI
{
    [super createUI];
    
    [self.contentView addSubview:self.subLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.subLabel.frame = CGRectMake(LM_Screen_Width - LM_XX_6(24) - LM_Screen_Width / 2, 0, LM_Screen_Width / 2, self.contentView.height);
}

#pragma mark - Setter/Getter

- (UILabel *)subLabel
{
    if (!_subLabel)
    {
        _subLabel = [[UILabel alloc] init];
        _subLabel.textAlignment = NSTextAlignmentRight;
        _subLabel.textColor = LM_UIColorFromHEX(0x333333);
        _subLabel.font = [UIFont systemFontOfSize:LM_XX_6(14)];
    }
    return _subLabel;
}

- (void)configModel:(LMFormModel *)model
{
    [super configModel:model];
    
    self.subLabel.text = model.value;
}
@end
