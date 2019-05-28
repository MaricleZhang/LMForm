//
//  LMPopupView.h
//  LMForm
//
//  Created by Zhang on 2019/5/21.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMMarco.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LMPopupViewConfirmBlock)(void);
typedef void(^LMPopupViewCancelBlock)(void);

@interface LMPopupView : UIView

+ (void)showPopupViewWithPickView:(UIView *)pickView title:(NSString *)title confirmBlock:(LMPopupViewConfirmBlock)confirmBlock cancelBlock:(LMPopupViewCancelBlock)cancelBlock;

@end

NS_ASSUME_NONNULL_END
