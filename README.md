# 更新日志

## 2020-10-22

1.兼容iOS 14.0

2.设置UItextField设置_placeholderLabel.textColor 崩溃处理

3._datePicker.preferredDatePickerStyle 支持13.4


# LMForm

## 背景

通常，将一个页面需要编辑/录入多项信息的页面称为**表单**。iOS 实现表单大多数基于TableView,麻烦的是需要在```UITableViewDataSource```或者```UITableViewDelegate```的代理方法中写很多```if-else```，与cell耦合严重,不易获取用户已编辑的数据。如果表单页面的配置数据从服务端返回，不易实现。

## 1. 介绍

LMForm 是基于MVVM轻量级表单配置框架，把数据和事件整合为一个model，实现cell与model的绑定，只需操作model便可配置表单。项目地址：https://github.com/MaricleZhang/LMForm.git

## 2. 结构

![](https://user-gold-cdn.xitu.io/2019/5/31/16b0caa6a28e0d06?w=1290&h=540&f=png&s=57217)

 * LMFormTypeManager : 负责管理类型与cellClass
 * LMFormModel：cell 的配置信息，事件回调，数据校验回调
 * Cell：遵循LMFormCellProtocol协议，实现不同的cell
 * LMFormTableView ：注册cell类型，通过model，渲染表单
 * LMFormValidator：负责对数据的校验

## 3. 功能

1. 支持动态配置model来实现表单。
2. 支持配置文本、输入框、选择器、日期选择、地址选择等。
3. 支持快速提取数据。
4. 支持数据校验，可自定义校验格式。
5. 支持完全自定义cell类型。

## 4. 预览
![form.gif](https://user-gold-cdn.xitu.io/2019/5/29/16b039f90940dd5b?w=442&h=1000&f=gif&s=1500095)


## 5. 安装
 ### CocoaPods
在 Podfile 中进行如下导入：
```
pod 'LMForm'
```
安装
```
pod install
```
## 6. 使用
在项目中导入```#import "LMForm.h" ```

### 1. 配置数据源

目前项目中集成以下类型：

|类型 |宏定义|Cell Class |
| ------ | ------ | ------ |
| 文本 | kFormTypeText | LMFormCell |
|输入框 | kFormTypeInput | LMFormInputCell |
|选择器 | kFormTypeSelector | LMFormSelectorCell |
|日期选择器 | kFormTypeDate | LMDateCell |
|地址输入框 | kFormTypeAddressInput | LMFormAddressInputCell |
|可变输入框 | kFormTypeTextView | LMFormTextViewCell |

可根据需求来选择对应的类型，例如输入框的model配置代码如下：
```
  // 输入框
- (LMFormModel *)loadInput
{
    LMFormModel *model = [LMFormModel new];
    model.formType = kFormTypeInput;
    model.title = @"手机号";
    model.key = @"mobile";
    model.value = @"";
    model.placeholder = @"请输入手机号";
    model.height = LM_XX_6(50);
    model.message = @"请输入正确的手机号";
    model.limitLength = 11;
    model.validateBlock = ^BOOL(LMFormModel * _Nullable model) {
        if (![LMFormValidator isMobile:model.value])
        {
            [LMWindowHud showHud:model.message];
            return NO;
        }
        return YES;
    };
    return model;
}
```
可根据需要设置UI，输入限制长度，自定义校验等。

### 2. 创建tableview

创建基于LMFormTableView 的tableview，并且赋值渲染数据，表单的创建完成。
```
    self.tableView.dataArray = self.dataArray;
```
### 3. 校验数据

提交时，对数据源进行自定义校验，校验的逻辑是对```model.validateBlock```遍历回调。
```
/**
 对数据源校验

 @param dataArray 数据源
 @return 全部校验通过返回YES，否则返回NO。
 */
+ (BOOL)validateDataArray:(NSArray<LMFormModel *> *)dataArray
{
    for (LMFormModel * _Nonnull obj in dataArray)
    {
        if (obj.validateBlock)
        {
            if (!obj.validateBlock(obj)) return NO;
        }
    }
    return YES;
}
```
### 4. 获取数据源

因为LMFormTableView中的cell与model绑定，只需遍历获取```value```即可。

## 7. Cell 类型的介绍

### 1. LMFormCell
基类cell:其他类型cell继承该cell，主要功能显示文本，不可编辑。可根据需求配置相应UI和数据。
```
- (void)configModel:(LMFormModel *)model
{
    self.model = model;
    
    // data
    self.titleLabel.text = model.title;
    self.textField.placeholder = model.placeholder;
    self.textField.text = model.value;
    if (model.limitLength)
    {
        self.textField.limitLength = @(model.limitLength);
    }
    
    // UI
    self.line.hidden = model.hiddenLine;
    self.line.backgroundColor = LM_ObjDefault(model.separatorLineColor, LM_UIColorFromHEX(0xF4F4F4));
    self.titleLabel.textColor = LM_ObjDefault(model.leftTextColor, LM_UIColorFromHEX(0x666666));
    self.textField.textColor = LM_ObjDefault(model.rightTextColor, LM_UIColorFromHEX(0x333333));
    self.titleLabel.font = LM_ObjDefault(model.leftLabelFont, [UIFont systemFontOfSize:LM_XX_6(14)]);
    self.titleLabel.font = LM_ObjDefault(model.rightLabelFont, [UIFont systemFontOfSize:LM_XX_6(14)]);
}
```
### 2. LMFormInputCell
输入Cell:可以编辑，可以对输入长度限制，输入的text更新为model的value。
```
- (void)textDidChanged:(UITextField *)textField
{
    self.model.value = textField.text;
    if (self.model.valueDidChangedBlock)
    {
        self.model.valueDidChangedBlock(textField.text);
    }
}
```
### 3. LMFormSelectorCell
选择器Cell:可以选择对应的item,需要配置数据```NSArray<NSString *> *selectList```,点击cell底部弹窗pickerView
```
- (void)tapSelectedAction
{
    LMDefaultPickerView *pickView = [[LMDefaultPickerView alloc] initWithDataArray:self.model.selectList];
    @weakify(self)
    [LMPopupView showPopupViewWithPickView:pickView title:self.model.placeholder confirmBlock:^{
        @strongify(self)
        NSString *text = self.model.selectList[pickView.selectIndex];
        self.model.value = text;
        self.textField.text = text;
        if (self.model.valueDidChangedBlock)
        {
            self.model.valueDidChangedBlock(text);
        }
    } cancelBlock:^{
        
    }];
}
```
### 4. LMDateCell
选择日期Cell：与选择cell类似，底部弹窗datePickerView。目前只支持年月日。

```
- (void)tapSelectedAction
{
    @weakify(self)
    [LMPopupView showPopupViewWithPickView:self.datePicker title:self.model.placeholder confirmBlock:^{
        @strongify(self)
        NSDate *date = self.datePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:self.model.dateFormat ?: @"yyyy-MM-dd"];
        NSString *text = [formatter stringFromDate:date];
        self.model.value = text;
        self.textField.text = text;
    } cancelBlock:^{
        
    }];
}
```

### 5. LMFormAddressInputCell 

地址输入cell：主要用来输入较多数字的信息，分两行显示。

### 6. LMFormTextViewCell 

可变输入框cell：cell高度可随textview 高度变化而变化

### 7.自定义cell

#### 创建
LMForm 支持cell的完全自定义，创建的自定义cell需要遵循协议```LMFormCellProtocol```，
协议的方法必须实现，在自定义的cell中实现配置数据。如果LMFormModel中的属性不能满足需求，可以创建LMFormModel分类添加或者继承。个人比较推荐分类的做法。
```
/** 根据model 配置对应的cell  */
- (void)configModel:(LMFormModel *)model;
```
#### 注册

LMForm 维护一张注册表建立key与cellClass的一一对应关系，单例```LMFormTypeManager```中的```keyCellTypes```就是这个注册表。注册方法为
```
/**
 自定义cell时注册方法，同一种cell只需要注册一次。cls 需继承UITableViewCell

 @param cls cell class
 @param key key
 */
- (void)registerCellClass:(Class)cls forKey:(NSString *)key;
```

需要注意的是注册表是个字典，**key的定义不能重复**。

 ## 8. 项目地址：[Demo](https://github.com/MaricleZhang/LMForm.git) 
 
 ## 9.联系
 
 如有问题请邮件：maricle.zhang@gmail.com
