//
//  LMFormInputCell.m
//  LoanMarket
//
//  Created by Zhang on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormInputCell.h"
#import "UITextField+LimitLength.h"

@interface LMFormInputCell ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation LMFormInputCell

- (void)createUI
{
    [super createUI];
    
    [self.contentView addSubview:self.textField];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textField.frame = CGRectMake(LM_Screen_Width - LM_XX_6(24) - LM_Screen_Width / 2 , 0, LM_Screen_Width / 2, self.contentView.height);
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

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.textColor = LM_UIColorFromHEX(0x333333);
        _textField.font = [UIFont systemFontOfSize:LM_XX_6(14)];
         [_textField setValue:LM_UIColorFromHEX(0xC0C0C0) forKeyPath:@"_placeholderLabel.textColor"];
        [_textField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (void)configModel:(LMFormModel *)model
{
    [super configModel:model];
    
    self.textField.placeholder = model.placeholder;
    self.textField.text = model.value;
    
    if (model.limitLength)
    {
        self.textField.limitLength = @(model.limitLength);
    }
}

@end
