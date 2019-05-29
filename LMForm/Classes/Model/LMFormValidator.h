//
//  LMFormValidator.h
//  LMForm
//
//  Created by Zhang on 2019/5/5.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LMFormModel;

NS_ASSUME_NONNULL_BEGIN

@interface LMFormValidator : NSObject

/**
 正则校验

 @param value 校验的字符串
 @param regex 校验的正则表达式
 @return BOOL
 */
+ (BOOL)validate:(NSString *)value WithRegex:(NSString *)regex;

/**
 校验手机号

 @param value 校验的字符串
 @return BOOL
 */
+ (BOOL)isMobile:(NSString *)value;

/**
 对数据源校验

 @param dataArray 数据源
 @return 全部校验通过返回YES，否则返回NO。
 */
+ (BOOL)validateDataArray:(NSArray<LMFormModel *> *)dataArray;

/**
 对输入或者选择的数据非空校验

 @param value 校验的字符串
 @return BOOL 为空返回YES
 */
+ (BOOL)isEmptyValue:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
