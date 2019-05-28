//
//  LMMarco.h
//  LMForm
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 Maricle. All rights reserved.
//

#ifndef LMMarco_h
#define LMMarco_h

#define LM_Screen_Width    ([UIScreen mainScreen].bounds.size.width)
#define LM_Screen_Height   ([UIScreen mainScreen].bounds.size.height)

// 物理点 为单位
#define LM_XX_6(value)     (1.0 * (value) * LM_Screen_Width / 375.0)

#define LM_UIColorFromHEX_Alpha(rgbValue, a) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:(a)]

#define LM_UIColorFromHEX(rgbValue)     LM_UIColorFromHEX_Alpha(rgbValue, 1.0)

#define LM_DefautMargin                 LM_XX_6(20)
#define LM_ObjDefault(obj,default)      (obj ?: default)
#define LM_RightArrowWidth              LM_XX_6(24)
#define LM_DefaultSpace                 LM_XX_6(10)

/**
 合成弱引用/强引用
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#endif /* LMMarco_h */
