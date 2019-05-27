//
//  LMFormTableView.h
//  LoanMarket
//
//  Created by 张建 on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMFormModel.h"

typedef void(^LMFormSubmitActionBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface LMFormTableView : UITableView

@property (nonatomic, strong) NSArray<LMFormModel *> *dataArray;
@property (nonatomic, copy) LMFormSubmitActionBlock actionBlock;

@end

NS_ASSUME_NONNULL_END
