//
//  LMFormTextViewCell.m
//  LMForm
//
//  Created by 张建 on 2019/6/5.
//

#import "LMFormTextViewCell.h"
#import "UITextView+AutoHeight.h"

@interface LMFormTextViewCell ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LMFormTextViewCell

- (void)createUI
{
    [super createUI];
    
    [self.titleLabel removeFromSuperview];
    
    [self.textField removeFromSuperview];
    [self.contentView addSubview:self.textView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textView.frame = CGRectMake(LM_ObjDefault(self.model.margin, LM_DefautMargin) , 0, LM_Screen_Width - 2 * LM_ObjDefault(self.model.margin, LM_DefautMargin) , self.contentView.height - 1);
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *) textView
{
    self.model.value = textView.text;
    self.model.height = self.textView.height + 1;

    @weakify(self)
    [UIView performWithoutAnimation:^{
        @strongify(self)
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }];
}

#pragma mark - Setter/Getter

- (UITextView *)textView
{
    if (!_textView)
    {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:18];
        _textView.delegate = self;
        _textView.scrollEnabled = NO;
        _textView.cm_placeholderColor = LM_UIColorFromHEX(0xC0C0C0);
        _textView.cm_maxNumberOfLines = 3;
        }
    return _textView;
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView)
    {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

#pragma mark - LMFormCellProtocol

- (void)configModel:(LMFormModel *)model
{
    [super configModel:model];
    
    self.textView.cm_placeholder = model.placeholder;
    self.textView.text = model.value;

    self.textView.textColor = LM_ObjDefault(model.rightTextColor, LM_UIColorFromHEX(0x333333));
    self.textView.font = LM_ObjDefault(model.rightLabelFont, [UIFont systemFontOfSize:LM_XX_6(14)]);
}

@end
