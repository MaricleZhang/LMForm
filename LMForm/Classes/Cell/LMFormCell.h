//
//  LMFormCell.h
//  LMForm
//
//  Created by Zhang on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMFormModel.h"
#import "LMMarco.h"
#import "UIView+Extension.h"
#import "LMFormCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LMFormCell : UITableViewCell<LMFormCellProtocol>

@property (nonatomic, strong) LMFormModel *model;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;

- (void)createUI;

@end

NS_ASSUME_NONNULL_END
