//
//  UIGestureRecognizer+QHHook.m
//  QHHookEventDemo
//
//  Created by Anakin chen on 2017/9/19.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

#import "UIGestureRecognizer+QHHook.h"

#import <objc/message.h>

#import "QHHookUtil.h"

@implementation UIGestureRecognizer (QHHook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [QHHookUtil swizzleTarget:[self class] method:@selector(initWithTarget:action:) toMethod:@selector(swizzle_initWithTarget:action:)];
        [QHHookUtil swizzleTarget:[self class] method:@selector(addTarget:action:) toMethod:@selector(swizzle_addTarget:action:)];
    });
}

#pragma mark - Get

static NSString *hasParamKey = @"bHasParam";

- (void)markHasParam:(BOOL)bHasParamKey {
    objc_setAssociatedObject(self, &hasParamKey, @(bHasParamKey), OBJC_ASSOCIATION_COPY);
}

- (BOOL)bHasParam {
    return [objc_getAssociatedObject(self, &hasParamKey) boolValue];
}

#pragma mark - Method Swizzling

- (instancetype)swizzle_initWithTarget:(nullable id)target action:(nullable SEL)action {
    //添加类似原来sel的新sel，添加成功后，替换原来的sel（即action）
    SEL swizzledSEL = NSSelectorFromString([NSString stringWithFormat:@"qhReplace_%@", NSStringFromSelector(action)]);
    BOOL didAddMethod = class_addMethod([target class], swizzledSEL, (IMP)replace_gestureAction, "v@:@");
    
    UIGestureRecognizer *gestureRecognizer = nil;
    if (didAddMethod) {
        //标记是否原来的sel是否包含入参，这是准备后面重新调用它
        NSString *originalSelString = NSStringFromSelector(action);
        if ([originalSelString rangeOfString:@":"].location != NSNotFound) {
            [self markHasParam:YES];
        }
        else {
            [self markHasParam:NO];
        }
        //替换
        gestureRecognizer = [self swizzle_initWithTarget:target action:swizzledSEL];
    }
    else {
        //添加失败就按原来的sel
        gestureRecognizer = [self swizzle_initWithTarget:target action:action];
    }
    
    return gestureRecognizer;
}

- (void)swizzle_addTarget:(id)target action:(SEL)action {
    return [self swizzle_addTarget:target action:action];
}

void replace_gestureAction(id self, SEL _cmd,id sender) {
    NSString *selString = NSStringFromSelector(_cmd);
    NSRange range = [selString rangeOfString:@"qhReplace_"];
    if (range.location != NSNotFound && range.location == 0) {
        //按协议的，将新sel还原回原来的sel
        NSString *originalSelString = [selString substringFromIndex:range.length];
        if ([sender bHasParam] == YES) {
            originalSelString = [NSString stringWithFormat:@"%@:", originalSelString];
        }
        SEL originalSelector = NSSelectorFromString(originalSelString);
        [self performSelector:originalSelector withObject:sender afterDelay:0];
    }
}

@end
