//
//  UITextField+LimitLength.h
//  CategoryDemo
//
//  Created by MaricleZhang on 2019/3/20.
//  Copyright © 2019 MaricleZhang. All rights reserved.
//

/** TextField 输入长度限制  */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TextLengthMoreThanBlock)(void);
@interface UITextField (LimitLength)

/** 输入限制长度  */
@property (nonatomic, strong) NSNumber *limitLength;

/** 输入长度超过限制回调 */
@property (nonatomic, copy) TextLengthMoreThanBlock lenghtBlock;

@end

NS_ASSUME_NONNULL_END
