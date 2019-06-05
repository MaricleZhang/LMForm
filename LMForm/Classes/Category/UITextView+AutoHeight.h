//
//  UITextView+AutoHeight.h
//  LMForm
//
//  Created by 张建 on 2019/6/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (AutoHeight)

@property (nonatomic,copy) NSString *cm_placeholder;

@property (nonatomic,copy) UIColor *cm_placeholderColor;

@property (nonatomic,strong) UIFont *cm_placeholderFont;

@property (nonatomic,assign) NSUInteger cm_maxNumberOfLines;

@end

NS_ASSUME_NONNULL_END
