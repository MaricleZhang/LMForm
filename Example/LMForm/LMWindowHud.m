//
//  LMWindowHud.m
//  LMForm
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMWindowHud.h"
#import "UIView+Extension.h"

UILabel *hudLabel;

@implementation LMWindowHud

+ (void)showHud:(NSString *)text
{
    if (hudLabel) return;
    hudLabel = [[UILabel alloc] init];
    hudLabel.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    hudLabel.textAlignment = NSTextAlignmentCenter;
    hudLabel.textColor = [UIColor whiteColor];
    hudLabel.text = text;
    hudLabel.font = [UIFont systemFontOfSize:14];
    hudLabel.layer.cornerRadius = 3;
    hudLabel.layer.masksToBounds = YES;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:hudLabel];
    
    [hudLabel sizeToFit];
    hudLabel.width += 20;
    hudLabel.height += 10;
    
    hudLabel.center = window.center;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hudLabel removeFromSuperview];
        hudLabel = nil;
    });
}

@end
