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
//@property (nonatomic, strong) UITextView *placeHolderTextView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat defaultHegiht;

@end

@implementation LMFormTextViewCell

- (void)createUI
{
    [super createUI];

    [self.textField removeFromSuperview];
    [self.contentView addSubview:self.textView];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.y = LM_XX_6(15);
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    self.model.value = textView.text;
    self.model.height = MAX(self.textView.height + LM_XX_6(30) + 1, self.textView.originalHeight);

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
        _textView.frame = CGRectMake(LM_DefautMargin,LM_XX_6(30), LM_Screen_Width - 2 * LM_DefautMargin , self.model.height - LM_XX_6(30) - 1);
        
        _textView.delegate = self;
        _textView.scrollEnabled = NO;
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
    
    self.textView.textColor = LM_ObjDefault(model.rightTextColor, LM_UIColorFromHEX(0x333333));
    self.textView.font = LM_ObjDefault(model.rightLabelFont, [UIFont systemFontOfSize:LM_XX_6(14)]);
    self.textView.lm_placeholder = model.placeholder;
    self.textView.lm_maxNumberOfLines = model.lm_maxNumberOfLines;
    self.textView.text = model.value;
    
    self.textView.frame = CGRectMake(LM_ObjDefault(self.model.margin, LM_DefautMargin) ,LM_XX_6(30), LM_Screen_Width - 2 * LM_ObjDefault(self.model.margin, LM_DefautMargin) , self.model.height - LM_XX_6(30) - 1);

}

@end
