//
//  LMAddressCell.m
//  LMForm
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMAddressCell.h"
#import "UIImage+Bundle.h"

@interface LMAddressCell ()

@property (nonatomic, strong) UIImageView *arrowImgView;

@end

@implementation LMAddressCell

- (void)createUI
{
    [super createUI];
    
    [self.contentView addSubview:self.arrowImgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectedAction)];
    [self.contentView addGestureRecognizer:tap];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textField.frame = CGRectMake(LM_Screen_Width - LM_XX_6(52) - LM_Screen_Width / 2 , 0, LM_Screen_Width / 2, self.contentView.height);
    self.arrowImgView.frame = CGRectMake(LM_Screen_Width - LM_DefautMargin - LM_DefautMargin, 0, LM_DefautMargin, LM_DefautMargin);
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

- (UIImageView *)arrowImgView
{
    if (!_arrowImgView)
    {
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage bundleImageWithNamed:@"lm_common_arrow"]];
    }
    return _arrowImgView;
}

#pragma mark - LMFormCellProtocol

- (void)configModel:(LMFormModel *)model
{
    [super configModel:model];
    
    self.textField.text = [self fetchTextWithSelectID:model.value];
    self.textField.placeholder = model.placeholder;
}

@end
