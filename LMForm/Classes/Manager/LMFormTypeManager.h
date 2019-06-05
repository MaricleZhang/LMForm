//
//  LMFormTypeManager.h
//  LMForm
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 这里是pod 中已经集成的cell 类型  */
#define kFormTypeText            @"text"
#define kFormTypeInput           @"input"
#define kFormTypeSelector        @"selector"
#define kFormTypeDate            @"date"
#define kFormTypeAddress         @"address"
#define kFormTypeAddressInput    @"addressInput"
#define kFormTypeTextView        @"textView"

NS_ASSUME_NONNULL_BEGIN

@interface LMFormTypeManager : NSObject

+ (LMFormTypeManager *)manager;

/**
 自定义cell时注册方法，同一种cell只需要注册一次。cls 需继承UITableViewCell

 @param cls cell class
 @param key key
 */
- (void)registerCellClass:(Class)cls forKey:(NSString *)key;

/**
 根据key获取对应的cell class

 @param key key
 @return cell class
 */
- (Class)getClassWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
