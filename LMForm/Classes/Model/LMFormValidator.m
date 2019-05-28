//
//  LMFormValidator.m
//  LMForm
//
//  Created by Zhang on 2019/5/5.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormValidator.h"
#import "LMFormModel.h"

@implementation LMFormValidator

- (BOOL)isValidate:(NSString *)value
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex] evaluateWithObject:[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
}

+ (BOOL)validateDataArray:(NSArray<LMFormModel *> *)dataArray
{
    for (LMFormModel * _Nonnull obj in dataArray)
    {
        if (obj.validateBlock)
        {
            if (!obj.validateBlock(obj)) return NO;
        }
    }
    return YES;
}

@end
