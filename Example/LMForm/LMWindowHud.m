//
//  LMWindowHud.m
//  ConfigurableForm
//
//  Created by 张建 on 2019/5/20.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMWindowHud.h"
#import "UIView+Extension.h"

@implementation LMWindowHud

+ (void)showHud:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = text;
    label.font = [UIFont systemFontOfSize:14];
    label.layer.cornerRadius = 3;
    label.layer.masksToBounds = YES;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:label];
    
    [label sizeToFit];
    label.width += 20;
    label.height += 10;
    
    label.center = window.center;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
}

@end
