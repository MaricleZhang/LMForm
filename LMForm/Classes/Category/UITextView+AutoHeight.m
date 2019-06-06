//
//  UITextView+AutoHeight.m
//  LMForm
//
//  Created by 张建 on 2019/6/5.
//

#import "UITextView+AutoHeight.h"
#import <objc/runtime.h>
#import "LMMarco.h"

@interface UITextView ()

@property (nonatomic,strong) UITextView *placeHolderTextView;

@end

@implementation UITextView (AutoHeight)

+ (void)load
{
    [super load];
    
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),class_getInstanceMethod(self.class,@selector(exchanged_dealloc)));
}

- (void)exchanged_dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UITextView *textView = objc_getAssociatedObject(self, @selector(placeHolderTextView));
    if (textView)
    {
        for (NSString *key in self.class.observedKeys)
        {
            @try
            {
                [self removeObserver:self forKeyPath:key];
            }
            @catch (NSException *exception)
            {
                
            }
        }
    }
    [self exchanged_dealloc];
}

+ (NSArray *)observedKeys
{
    return @[@"attributedText",@"bounds",@"font",@"frame",@"text",@"textAlignment",@"textContainerInset",@"textContainer.exclusionPaths"];
}

- (CGFloat)originalHeight
{
    static CGFloat originalHeight;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self.superview layoutIfNeeded];
        originalHeight = self.bounds.size.height;
    });
    
    return originalHeight;
}

- (NSString *)lm_placeholder
{
    return objc_getAssociatedObject(self, @selector(lm_placeholder));
}

- (void)setLm_placeholder:(NSString *)lm_placeholder
{
    objc_setAssociatedObject(self, @selector(lm_placeholder), lm_placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self placeHolderTextView];
}

- (UIColor *)lm_placeholderColor
{
    return objc_getAssociatedObject(self, @selector(lm_placeholderColor));
}

- (void)setLm_placeholderColor:(UIColor *)lm_placeholderColor
{
    objc_setAssociatedObject(self, @selector(lm_placeholderColor), lm_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self textViewValueChanged];
}

- (UIFont *)lm_placeholderFont
{
    return objc_getAssociatedObject(self, @selector(lm_placeholderFont));
}

- (void)setLm_placeholderFont:(UIFont *)lm_placeholderFont
{
    objc_setAssociatedObject(self, @selector(lm_placeholderFont), lm_placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self textViewValueChanged];
}

- (NSUInteger)lm_maxNumberOfLines
{
    return [objc_getAssociatedObject(self, @selector(lm_maxNumberOfLines)) integerValue];
}

- (void)setLm_maxNumberOfLines:(NSUInteger)lm_maxNumberOfLines
{
    objc_setAssociatedObject(self, @selector(lm_maxNumberOfLines), @(lm_maxNumberOfLines), OBJC_ASSOCIATION_ASSIGN);
    [self textViewValueChanged];
}

- (BOOL)lm_autoLineBreak
{
    return [objc_getAssociatedObject(self, @selector(lm_autoLineBreak)) boolValue];
}

- (void)setLm_autoLineBreak:(BOOL)lm_autoLineBreak
{
    objc_setAssociatedObject(self, @selector(lm_autoLineBreak), @(lm_autoLineBreak), OBJC_ASSOCIATION_ASSIGN);
    [self textViewValueChanged];
}

- (UITextView *)placeHolderTextView
{
    UITextView *placeHolderTextView = objc_getAssociatedObject(self, @selector(placeHolderTextView));
    
    if (!placeHolderTextView)
    {
        self.text = @"";
        placeHolderTextView = [UITextView new];
        placeHolderTextView.userInteractionEnabled = NO;
        placeHolderTextView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        objc_setAssociatedObject(self, @selector(placeHolderTextView), placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self insertSubview:placeHolderTextView atIndex:0];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewValueChanged) name:UITextViewTextDidChangeNotification object:self];
        
        for (NSString *key in self.class.observedKeys)
        {
            [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
        }
        [self textViewValueChanged];
    }
    return placeHolderTextView;
}

- (void)updateHight
{
    self.placeHolderTextView.hidden = (self.text.length > 0);
    CGFloat maxHeight =  ceil(self.font.lineHeight * self.lm_maxNumberOfLines +  self.textContainerInset.top + self.textContainerInset.bottom);
    NSInteger height = self.text.length ? ceil([self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)].height) : self.originalHeight;
    
    if (!self.lm_maxNumberOfLines && height > self.originalHeight)
    {
        CGRect newFrame = self.frame;
        newFrame.size.height = height;
        self.frame = newFrame;
    }
    
    self.scrollEnabled = height > maxHeight && self.lm_maxNumberOfLines;
    if (maxHeight >= height && height >= self.originalHeight)
    {
        CGRect newFrame = self.frame;
        newFrame.size.height = height;
        self.frame = newFrame;
    }
}

- (void)textViewValueChanged
{
    self.placeHolderTextView.hidden = self.text.length;
    if(!self.text.length)
    {
        self.placeHolderTextView.text = self.lm_placeholder;
        self.placeHolderTextView.textColor = self.lm_placeholderColor ?: LM_UIColorFromHEX(0xC0C0C0);
        self.placeHolderTextView.font = self.lm_placeholderFont?:self.font;
        self.placeHolderTextView.textContainer.exclusionPaths = self.textContainer.exclusionPaths;
        self.placeHolderTextView.textAlignment = self.textAlignment;
        self.placeHolderTextView.frame = self.bounds;
    }

    [self updateHight];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object != self.placeHolderTextView && [keyPath isEqualToString:@"text"])
    {
        [self updateHight];
    }
}

@end
