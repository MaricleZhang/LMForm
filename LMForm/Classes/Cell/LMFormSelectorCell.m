//
//  LMFormSelectorCell.m
//  LoanMarket
//
//  Created by 张建 on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormSelectorCell.h"
#import "LMPopupView.h"
#import "LMDefaultPickerView.h"
#import "UIImage+Bundle.h"

@interface LMFormSelectorCell ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *arrowImgView;

@end

@implementation LMFormSelectorCell

- (void)createUI
{
    [super createUI];
    
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.arrowImgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectedAction)];
    [self.contentView addGestureRecognizer:tap];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textField.frame = CGRectMake(Screen_Width - QL_XX_6(52) - Screen_Width / 2 , 0, Screen_Width / 2, self.contentView.height);
    
    self.arrowImgView.frame = CGRectMake(Screen_Width - QL_XX_6(24) - QL_XX_6(24), 0, QL_XX_6(24), QL_XX_6(24));
    self.arrowImgView.centerY = self.contentView.height / 2;
}

#pragma mark - Responce

- (void)tapSelectedAction
{
    LMDefaultPickerView *pickView = [[LMDefaultPickerView alloc] initWithDataArray:self.model.selectList];
    @weakify(self)
    [LMPopupView showPopupViewWithPickView:pickView title:self.model.placeholder confirmBlock:^{
        @strongify(self)
        NSString *text = self.model.selectList[pickView.selectIndex];
        self.model.value = text;
        self.textField.text = text;
        if (self.model.valueDidChangedBlock)
        {
            self.model.valueDidChangedBlock(text);
        }
    } cancelBlock:^{
        
    }];
}

#pragma mark - Setter/Getter

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] init];
        _textField.userInteractionEnabled = NO;
        _textField.textColor = QL_UIColorFromHEX(0x333333);
        _textField.font = [UIFont systemFontOfSize:QL_XX_6(14)];
        _textField.textAlignment = NSTextAlignmentRight;
        [_textField setValue:QL_UIColorFromHEX(0xC0C0C0) forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _textField;
}

- (UIImageView *)arrowImgView
{
    if (!_arrowImgView)
    {
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage bundleImageWithNamed:@"lm_common_arrow"]];
    }
    return _arrowImgView;
}

- (void)configModel:(LMFormModel *)model
{
    [super configModel:model];
    
    self.textField.text = model.value;
    self.textField.placeholder = model.placeholder;
}

@end
