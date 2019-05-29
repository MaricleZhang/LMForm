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

+ (BOOL)validate:(NSString *)value WithRegex:(NSString *)regex
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
}

+ (BOOL)isMobile:(NSString *)value
{
    return [self validate:value WithRegex:@"^(1[3-9])\\d{9}$"];
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

+ (BOOL)isEmptyValue:(NSString *)value
{
    if (!value) return YES;
    if ([value isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([value isKindOfClass:[NSString class]])
    {
        if (value.length == 0)
        {
            return YES;
        }
    }
    return NO;
}
@end
