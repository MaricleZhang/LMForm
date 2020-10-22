//
//  LMDateCell.m
//  LMForm
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMDateCell.h"
#import "LMPopupView.h"
#import "UIImage+Bundle.h"

@interface LMDateCell ()

@property (nonatomic, strong) UIImageView *arrowImgView;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation LMDateCell

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
    
    self.textField.frame = CGRectMake(self.titleLabel.maxX + LM_DefaultSpace , 0, LM_Screen_Width - self.titleLabel.maxX - LM_ObjDefault(self.model.margin, LM_DefautMargin) - LM_RightArrowWidth - LM_DefaultSpace , self.contentView.height);
    
    self.arrowImgView.frame = CGRectMake(LM_Screen_Width - LM_ObjDefault(self.model.margin, LM_DefautMargin) - LM_RightArrowWidth, 0, LM_RightArrowWidth, LM_RightArrowWidth);
    self.arrowImgView.centerY = self.contentView.height / 2;
}

#pragma mark - Responce

- (void)tapSelectedAction
{
    @weakify(self)
    [LMPopupView showPopupViewWithPickView:self.datePicker title:self.model.placeholder confirmBlock:^{
        @strongify(self)
        NSDate *date = self.datePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:self.model.dateFormat ?: @"yyyy-MM-dd"];
        NSString *text = [formatter stringFromDate:date];
        self.model.value = text;
        self.textField.text = text;
    } cancelBlock:^{
        
    }];
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

- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        if (@available(iOS 13.4, *)) {
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        }
        _datePicker.backgroundColor = [UIColor clearColor];
        _datePicker.date = [NSDate date];
        _datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:0];
    }
    return _datePicker;
}

#pragma mark - LMFormCellProtocol

- (void)configModel:(LMFormModel *)model
{
    [super configModel:model];
    
    self.datePicker.datePickerMode = model.datePickerMode;
}

@end
