//
//  UIApplication+QHHook.m
//  QHHookEventDemo
//
//  Created by Anakin chen on 2017/9/8.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

#import "UIApplication+QHHook.h"

#import "QHHookUtil.h"
#import "QHViewPathUtil.h"

@implementation UIApplication (QHHook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [QHHookUtil swizzleTarget:[self class] method:@selector(sendAction:to:from:forEvent:) toMethod:@selector(swizzle_sendAction:to:from:forEvent:)];
    });
}

#pragma mark - Method Swizzling

- (BOOL)swizzle_sendAction:(SEL)action to:(nullable id)target from:(nullable id)sender forEvent:(nullable UIEvent *)event {
    id responder = ((UITouch *)[event allTouches].allObjects.lastObject).view;
    if ([responder isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)responder;
        NSLog(@"%@", btn.titleLabel.text);
    }
    [QHViewPathUtil viewPath:responder];
    return [self swizzle_sendAction:action to:target from:sender forEvent:event];
}

@end
