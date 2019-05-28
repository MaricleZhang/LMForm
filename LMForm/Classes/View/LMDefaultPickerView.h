//
//  LMDefaultPickerView.h
//  LMForm
//
//  Created by Zhang on 2019/5/21.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMFormModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMDefaultPickerView : UIPickerView

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger selectIndex;

- (instancetype)initWithDataArray:(NSArray<NSString *> *)dataArray;

@end

NS_ASSUME_NONNULL_END
