//
//  LMFormValidator.h
//  LoanMarket
//
//  Created by Zhang on 2019/5/5.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LMFormValidator : NSObject

@property (nonatomic, copy) NSString *regex;

- (BOOL)isValidate:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
