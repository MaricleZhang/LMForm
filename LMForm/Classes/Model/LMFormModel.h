//
//  LMFormModel.h
//  LoanMarket
//
//  Created by Zhang on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^LMValueDidChangedBlock)(NSString *vlaue);
typedef void(^LMAddressCellDidSelectedBlock)(NSString *vlaue,NSString *key);

NS_ASSUME_NONNULL_BEGIN

@interface LMFormModel : NSObject

@property (nonatomic, copy) NSString *title;//左边标题
@property (nonatomic, copy) NSString *key;//提交信息的入参
@property (nonatomic, copy) NSString *value;//输入或者选择的值
@property (nonatomic, assign) CGFloat height;//cell 高度
@property (nonatomic, copy) NSString *message;//输入错误提示信息
@property (nonatomic, assign) BOOL isRequire;//是否必须，默认NO
@property (nonatomic, assign) BOOL hiddenLine;// 是否隐藏分割线，默认NO
@property (nonatomic, copy) NSString *formType;
@property (nonatomic, strong) Class cellClass;// 对应的cell class
@property (nonatomic, copy) LMValueDidChangedBlock valueDidChangedBlock; //输入完成或者选择完成回调

// LMFormInputCell
@property (nonatomic, copy) NSString *placeholder; //textField placeholder
@property (nonatomic, assign) NSInteger limitLength;//textfield 最大输入长度
@property (nonatomic, copy) NSString *regex;

// LMFormSelectorCell
@property (nonatomic, copy) NSArray<NSString *> *selectList;

// LMAddressCell
@property (nonatomic, copy) LMAddressCellDidSelectedBlock addressCellDidSelectedBlock;
@property (nonatomic, assign) NSString *addressType;

- (BOOL)isValidate;

@end

NS_ASSUME_NONNULL_END
