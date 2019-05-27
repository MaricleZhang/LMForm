//
//  LMFormTypeManager.h
//  ConfigurableForm
//
//  Created by 张建 on 2019/5/22.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFormTypeText            @"text"
#define kFormTypeInput           @"input"
#define kFormTypeSelector        @"selector"
#define kFormTypeDate            @"date"
#define kFormTypeAddress         @"address"

NS_ASSUME_NONNULL_BEGIN

@interface LMFormTypeManager : NSObject

+ (LMFormTypeManager *)manager;

- (void)registerCellClass:(Class)cls forKey:(NSString *)key;

- (Class)getClassWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
