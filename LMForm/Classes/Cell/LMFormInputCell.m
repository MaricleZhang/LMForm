//
//  LMFormInputCell.m
//  LMForm
//
//  Created by Zhang on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormInputCell.h"

@implementation LMFormInputCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textField.frame = CGRectMake(self.titleLabel.maxX + LM_DefaultSpace , 0, LM_Screen_Width - self.titleLabel.maxX - LM_ObjDefault(self.model.margin, LM_DefautMargin) - LM_DefaultSpace , self.contentView.height);
}

#pragma mark - LMFormCellProtocol

- (void)configModel:(LMFormModel *)model
{
    [super configModel:model];
    
    self.textField.userInteractionEnabled = YES;
}


@end
