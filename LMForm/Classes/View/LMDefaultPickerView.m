//
//  LMDefaultPickerView.m
//  LMForm
//
//  Created by Zhang on 2019/5/21.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMDefaultPickerView.h"

@interface LMDefaultPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation LMDefaultPickerView

- (instancetype)initWithDataArray:(NSArray<NSString *> *)dataArray
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
        self.dataArray = dataArray;
        self.showsSelectionIndicator = YES;
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row < self.dataArray.count)
    {
        NSString *text = [self.dataArray objectAtIndex:row];
        return text;
    }
    return @"";
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.frame.size.width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35.0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectIndex = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{    
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:20]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];

    return pickerLabel;
}

@end
