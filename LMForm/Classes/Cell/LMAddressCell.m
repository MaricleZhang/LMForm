//
//  LMAddressCell.m
//  LoanMarket
//
//  Created by 张建 on 2019/5/8.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMAddressCell.h"
#import "UIImage+Bundle.h"

@interface LMAddressCell ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *arrowImgView;

@end

@implementation LMAddressCell

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

- (NSString *)fetchTextWithSelectID:(NSString *)selectedID
{
    __block NSString *text = @"";
//    [self.model.selectList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isEqualToString:[NSString class]])
//        {
//            text = obj;
//        }
//    }];

    return text;
}

#pragma mark - Responce

- (void)tapSelectedAction
{
//    @weakify(self)
//    LMPickerView *pick = [[LMPickerView alloc] initWithDataSource:self.model.selectList block:^(LMSelectModel *selectModel) {
//        @strongify(self)
//        self.model.value = selectModel.selectedID;
//        self.textField.text = selectModel.selectedText;
//        if (self.model.addressCellDidSelectedBlock)
//        {
//            self.model.addressCellDidSelectedBlock(selectModel.selectedID,self.model.key);
//        }
//    }];
//    pick.type = LMPickerViewTypeDefault;
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
    
    self.textField.text = [self fetchTextWithSelectID:model.value];
    self.textField.placeholder = model.placeholder;
}

@end
