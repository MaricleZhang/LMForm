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

@property (nonatomic, copy) NSString *regex;

- (BOOL)isValidate:(NSString *)value;


/**
 对数据源校验

 @param dataArray 数据源
 @return 全部校验通过返回YES，否则返回NO。
 */
+ (BOOL)validateDataArray:(NSArray<LMFormModel *> *)dataArray;

@end

NS_ASSUME_NONNULL_END
