//
//  LMPopupView.m
//  LMForm
//
//  Created by Zhang on 2019/5/21.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMPopupView.h"

#define kLMPopupViewHeight 240
#define kLMTopViewHeight   44
#define kLMButtonWidth     65

@interface LMPopupView ()

@property (nonatomic, strong) UIView *popupView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *pickView;

@property (nonatomic, copy) LMPopupViewConfirmBlock confirmBlock;
@property (nonatomic, copy) LMPopupViewConfirmBlock cancelBlock;

@end

@implementation LMPopupView

+ (void)showPopupViewWithPickView:(UIView *)pickView title:(NSString *)title confirmBlock:(LMPopupViewConfirmBlock)confirmBlock cancelBlock:(LMPopupViewCancelBlock)cancelBlock
{
    LMPopupView *popview = [[LMPopupView alloc] initPopupViewWithPickView:pickView title:title confirmBlock:confirmBlock cancelBlock:confirmBlock];
    [popview show];
}

- (instancetype)initPopupViewWithPickView:(UIView *)pickView title:(NSString *)title confirmBlock:(LMPopupViewConfirmBlock)confirmBlock cancelBlock:(LMPopupViewCancelBlock)cancelBlock
{
    self = [super init];
    if (self)
    {
        self.confirmBlock = confirmBlock;
        self.cancelBlock = cancelBlock;
        
        [self createUI];
        [self.popupView addSubview:pickView];
        self.titleLabel.text = title;
        pickView.frame = CGRectMake(0, kLMTopViewHeight, self.frame.size.width, kLMPopupViewHeight - kLMTopViewHeight);
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    }
    return self;
}

- (void)createUI
{
    self.frame = CGRectMake(0, 0, LM_Screen_Width, LM_Screen_Height);
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelfView)];
    [self addGestureRecognizer:tapGesture];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addSubview:self.popupView];
    [self.popupView addSubview:self.topView];
    [self.topView addSubview:self.cancelButton];
    [self.topView addSubview:self.confirmButton];
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.line];
}

- (void)show
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.popupView.frame;
        rect.origin.y -= kLMPopupViewHeight;
        self.popupView.frame = rect;
    }];
}

- (void)removeSelfView
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.popupView.frame;
        rect.origin.y += kLMPopupViewHeight;
        self.popupView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Responce

- (void)cancelButtonAction
{
    [self removeSelfView];
    if (!self.cancelBlock) return;
    self.cancelBlock();
}

- (void)confirmButtonAction
{
    [self removeSelfView];
    if (!self.confirmBlock) return;
    self.confirmBlock();
}

#pragma mark - Setter/Getter

- (UIView *)popupView
{
    if (!_popupView)
    {
        _popupView = [[UIView alloc] initWithFrame:CGRectMake(0, LM_Screen_Height, LM_Screen_Width, kLMPopupViewHeight)];
        _popupView.backgroundColor = LM_UIColorFromHEX(0xf9f9fa);
    }
    return _popupView;
}

- (UIView *)topView
{
    if (!_topView)
    {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kLMTopViewHeight)];
        _topView.backgroundColor = LM_UIColorFromHEX(0xFDFDFD);
    }
    return _topView;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kLMButtonWidth, kLMTopViewHeight)];
        _cancelButton.backgroundColor = [UIColor clearColor];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:LM_UIColorFromHEX(0x464646) forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton)
    {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - kLMButtonWidth), 0, kLMButtonWidth, kLMTopViewHeight)];
        _confirmButton.backgroundColor = [UIColor clearColor];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:LM_UIColorFromHEX(0x464646) forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLMButtonWidth + 5, 0, self.frame.size.width - 2 * (kLMButtonWidth + 5) , kLMTopViewHeight)];
        _titleLabel.textColor = LM_UIColorFromHEX(0x464646);
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)line
{
    if (!_line)
    {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, kLMTopViewHeight - 0.5, self.frame.size.width, 0.5)];
        _line.backgroundColor = LM_UIColorFromHEX(0xf1f1f1);
    }
    return _line;
}

@end
