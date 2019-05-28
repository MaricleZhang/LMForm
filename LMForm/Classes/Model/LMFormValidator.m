//
//  LMFormValidator.m
//  LoanMarket
//
//  Created by Zhang on 2019/5/5.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormValidator.h"

@implementation LMFormValidator

- (BOOL)isValidate:(NSString *)value
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex] evaluateWithObject:[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
}

@end
