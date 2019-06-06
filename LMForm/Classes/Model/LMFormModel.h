//
//  LMFormModel.h
//  LMForm
//
//  Created by Zhang on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LMFormValidator.h"

@class LMFormModel;

typedef void(^LMValueDidChangedBlock)(NSString * _Nullable vlaue);
typedef void(^LMAddressCellDidSelectedBlock)(NSString * _Nullable vlaue,NSString * _Nullable key);
typedef BOOL(^LMValidateBlock)(LMFormModel * _Nullable model);

NS_ASSUME_NONNULL_BEGIN

@interface LMFormModel : NSObject

@property (nonatomic, copy) NSString *title;//左边标题
@property (nonatomic, copy) NSString *key;//提交信息的入参
@property (nonatomic, copy) NSString *value;//输入或者选择的值
@property (nonatomic, copy) NSString *message;//输入错误提示信息
@property (nonatomic, copy) NSString *formType;
@property (nonatomic, strong) Class cellClass;// 对应的cell class
@property (nonatomic, copy) LMValueDidChangedBlock valueDidChangedBlock; //输入或者选择完成回调
@property (nonatomic, copy) LMValidateBlock validateBlock;

/** UI 样式，可根据需求更改 */
@property (nonatomic, assign) CGFloat height;//cell 高度
@property (nonatomic, assign) BOOL hiddenLine;// 是否隐藏分割线，默认NO
@property (nonatomic, assign) CGFloat margin;// 分割线与两边的边距,左右的边距相等。
@property (nonatomic, strong) UIColor *separatorLineColor;// 分割线颜色
@property (nonatomic, strong) UIColor *leftTextColor;// 左边文本颜色
@property (nonatomic, strong) UIColor *rightTextColor;// 右边边文本颜色
@property (nonatomic, strong) UIFont *leftLabelFont;// 左边标题字体
@property (nonatomic, strong) UIFont *rightLabelFont;// 右边标题字体

// LMFormInputCell
@property (nonatomic, copy) NSString *placeholder; //textField placeholder
@property (nonatomic, assign) NSInteger limitLength;//textfield 最大输入长度

// LMFormSelectorCell
@property (nonatomic, copy) NSArray<NSString *> *selectList;

// LMDateCell
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, copy) NSString *dateFormat;//日期格式，eg:yyyy-MM-dd,MM/dd

// LMAddressCell
@property (nonatomic, copy) LMAddressCellDidSelectedBlock addressCellDidSelectedBlock;
@property (nonatomic, assign) NSString *addressType;

// LMFormTextViewCell
@property (nonatomic, assign) NSInteger lm_maxNumberOfLines;

@end


NS_ASSUME_NONNULL_END
