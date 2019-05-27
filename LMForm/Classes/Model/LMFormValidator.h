//
//  LMFormValidator.h
//  LoanMarket
//
//  Created by 张建 on 2019/5/5.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LMFormValidator : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *regex;

@end

NS_ASSUME_NONNULL_END
