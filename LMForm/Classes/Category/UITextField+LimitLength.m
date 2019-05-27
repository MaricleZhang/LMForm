//
//  UITextField+LimitLength.m
//  CategoryDemo
//
//  Created by MaricleZhang on 2019/3/20.
//  Copyright © 2019 MaricleZhang. All rights reserved.
//

#import "UITextField+LimitLength.h"
#import <objc/runtime.h>
#import <objc/message.h>

static const void *limitLengthKey = &limitLengthKey;
static const void *textLengthMoreThanBlockKey = &textLengthMoreThanBlockKey;

@implementation UITextField (LimitLength)

#pragma mark - Setter/Getter
- (NSNumber *)limitLength
{
    return objc_getAssociatedObject(self, limitLengthKey);
}

- (void)setLimitLength:(NSNumber *)limitLength
{
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
     [self addTarget:self action:@selector(textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (TextLengthMoreThanBlock)lenghtBlock
{
    return objc_getAssociatedObject(self, textLengthMoreThanBlockKey);
}

- (void)setLenghtBlock:(TextLengthMoreThanBlock)lenghtBlock
{
    objc_setAssociatedObject(self, textLengthMoreThanBlockKey, lenghtBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)textFieldTextDidChange
{
    if (self.text.length >= self.limitLength.intValue)
    {
        self.text = [self.text substringToIndex:self.limitLength.intValue];
        
        if (self.lenghtBlock)
        {
            self.lenghtBlock();
        }
    }
}

+ (void)load
{
    Method origMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method newMethod = class_getInstanceMethod([self class], @selector(my_dealloc));
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)my_dealloc
{
    // do your logic here
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
    
    //this calls original dealloc method
    [self my_dealloc];
}

@end
