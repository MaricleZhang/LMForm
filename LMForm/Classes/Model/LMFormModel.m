//
//  LMFormModel.m
//  LoanMarket
//
//  Created by Zhang on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormModel.h"

@implementation LMFormModel

- (BOOL)isValidate
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex] evaluateWithObject:[self.value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
}
@end
