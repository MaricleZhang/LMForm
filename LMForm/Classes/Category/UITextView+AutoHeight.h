//
//  UITextView+AutoHeight.h
//  LMForm
//
//  Created by 张建 on 2019/6/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (AutoHeight)

@property (nonatomic,copy) NSString *lm_placeholder;

@property (nonatomic,copy) UIColor *lm_placeholderColor;

@property (nonatomic,strong) UIFont *lm_placeholderFont;

@property (nonatomic,assign) NSUInteger lm_maxNumberOfLines;

@property (nonatomic,assign) CGFloat originalHeight;

@end

NS_ASSUME_NONNULL_END
