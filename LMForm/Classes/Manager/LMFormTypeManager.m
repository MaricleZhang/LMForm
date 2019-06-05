//
//  LMFormTypeManager.m
//  LMForm
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormTypeManager.h"
#import "LMFormInputCell.h"
#import "LMFormSelectorCell.h"
#import "LMFormAddressInputCell.h"
#import "LMDateCell.h"
#import "LMAddressCell.h"
#import "IQKeyboardManager.h"
#import "LMFormAddressInputCell.h"
#import "LMFormTextViewCell.h"

@interface LMFormTypeManager ()

@property (nonatomic, strong) NSMutableDictionary *keyCellTypes;

@end
@implementation LMFormTypeManager

+ (instancetype)manager
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self registerAllCell];
        /*** 键盘 ***/
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    }
    return self;
}

- (void)registerAllCell
{
    [self.keyCellTypes setObject:[LMFormCell class] forKey:kFormTypeText];
    [self.keyCellTypes setObject:[LMFormInputCell class] forKey:kFormTypeInput];
    [self.keyCellTypes setObject:[LMFormSelectorCell class] forKey:kFormTypeSelector];
    [self.keyCellTypes setObject:[LMDateCell class] forKey:kFormTypeDate];
    [self.keyCellTypes setObject:[LMAddressCell class] forKey:kFormTypeAddress];
    [self.keyCellTypes setObject:[LMFormAddressInputCell class] forKey:kFormTypeAddressInput];
    [self.keyCellTypes setObject:[LMFormTextViewCell class] forKey:kFormTypeTextView];
}

- (void)registerCellClass:(Class)cls forKey:(NSString *)key
{
    if (cls && key)
    {
        [self.keyCellTypes setObject:cls forKey:key];
    }
}

- (Class)getClassWithKey:(NSString *)key
{
    return [self.keyCellTypes objectForKey:key];
}

- (NSMutableDictionary *)keyCellTypes
{
    if (!_keyCellTypes)
    {
        _keyCellTypes = [NSMutableDictionary dictionary];
    }
    return _keyCellTypes;
}
@end
