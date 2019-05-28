//
//  LMFormAddressInputCell.m
//  LMForm
//
//  Created by Zhang on 2019/5/5.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormAddressInputCell.h"

@implementation LMFormAddressInputCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.y = LM_XX_6(15);
    
    self.textField.frame = CGRectMake(LM_ObjDefault(self.model.margin, LM_DefautMargin) , LM_XX_6(30), LM_Screen_Width - 2 * LM_ObjDefault(self.model.margin, LM_DefautMargin), LM_XX_6(40));
}

#pragma mark - LMFormCellProtocol

- (void)configModel:(LMFormModel *)model
{
    [super configModel:model];

    self.textField.userInteractionEnabled = YES;
    self.textField.textAlignment = NSTextAlignmentLeft;
}

@end
