//
//  LMFormCellProtocol.h
//  ConfigurableForm
//
//  Created by 张建 on 2019/5/20.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LMFormModel;

@protocol LMFormCellProtocol <NSObject>

- (void)configModel:(LMFormModel *)model;


@end
