//
//  LMFormCell.m
//  LMForm
//
//  Created by Zhang on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormCell.h"
#import "UITextField+LimitLength.h"

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
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.line];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.x = LM_ObjDefault(self.model.margin, LM_DefautMargin);
    self.titleLabel.centerY = self.contentView.height / 2;
    
    self.textField.frame = CGRectMake(self.titleLabel.maxX + LM_DefaultSpace , 0, LM_Screen_Width - self.titleLabel.maxX - LM_ObjDefault(self.model.margin, LM_DefautMargin) - LM_DefaultSpace , self.contentView.height);

    self.line.frame = CGRectMake(LM_ObjDefault(self.model.margin, LM_DefautMargin), self.contentView.height - 0.5, self.contentView.width - LM_ObjDefault(self.model.margin, LM_DefautMargin) * 2, 0.5);
}

#pragma mark - Responce

- (void)textDidChanged:(UITextField *)textField
{
    self.model.value = textField.text;
    if (self.model.valueDidChangedBlock)
    {
        self.model.valueDidChangedBlock(textField.text);
    }
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

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] init];
        _textField.userInteractionEnabled = NO;
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.textColor = LM_UIColorFromHEX(0x333333);
        _textField.font = [UIFont systemFontOfSize:LM_XX_6(14)];
        [_textField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
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

#pragma mark - LMFormCellProtocol

- (void)configModel:(LMFormModel *)model
{
    self.model = model;
    
    // data
    self.titleLabel.text = model.title;
    self.textField.placeholder = model.placeholder;
    self.textField.text = model.value;
    if (model.limitLength)
    {
        self.textField.limitLength = @(model.limitLength);
    }
    
    // UI
    self.line.hidden = model.hiddenLine;
    self.line.backgroundColor = LM_ObjDefault(model.separatorLineColor, LM_UIColorFromHEX(0xF4F4F4));
    self.titleLabel.textColor = LM_ObjDefault(model.leftTextColor, LM_UIColorFromHEX(0x666666));
    self.textField.textColor = LM_ObjDefault(model.rightTextColor, LM_UIColorFromHEX(0x333333));
    self.titleLabel.font = LM_ObjDefault(model.leftLabelFont, [UIFont systemFontOfSize:LM_XX_6(14)]);
    self.textField.font = LM_ObjDefault(model.rightLabelFont, [UIFont systemFontOfSize:LM_XX_6(14)]);
}

@end
