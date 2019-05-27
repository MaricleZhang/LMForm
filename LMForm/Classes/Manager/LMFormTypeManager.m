//
//  LMFormTypeManager.m
//  ConfigurableForm
//
//  Created by 张建 on 2019/5/22.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormTypeManager.h"
#import "LMFormInputCell.h"
#import "LMFormTextCell.h"
#import "LMFormSelectorCell.h"
#import "LMFormAddressInputCell.h"
#import "LMDateCell.h"
#import "LMAddressCell.h"
#import "IQKeyboardManager.h"

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
        [self initAllRegister];
        /*** 键盘 ***/
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    }
    return self;
}

- (void)initAllRegister
{
    [self.keyCellTypes setObject:[LMFormTextCell class] forKey:kFormTypeText];
    [self.keyCellTypes setObject:[LMFormInputCell class] forKey:kFormTypeInput];
    [self.keyCellTypes setObject:[LMFormSelectorCell class] forKey:kFormTypeSelector];
    [self.keyCellTypes setObject:[LMDateCell class] forKey:kFormTypeDate];
    [self.keyCellTypes setObject:[LMAddressCell class] forKey:kFormTypeAddress];
}

- (void)registerCellClass:(Class)cls forKey:(NSString *)key
{
    NSAssert(cls,@"");
//    if (cls) {
//        <#statements#>
//    }
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
