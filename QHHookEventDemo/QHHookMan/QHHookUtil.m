//
//  QHHookUtil.m
//  QHHookEventDemo
//
//  Created by Anakin chen on 2017/9/6.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

#import "QHHookUtil.h"

#import <objc/runtime.h>

/**
 参考：
 http://nshipster.cn/method-swizzling/
 
 */
@implementation QHHookUtil

- (void)dealloc {
#if DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

#pragma mark - Private

#pragma mark - Public

+ (void)swizzleTarget:(Class)class method:(SEL)originalSelector toMethod:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // When swizzling a class method, use the following:
    // Class class = object_getClass((id)self);
    // ...
    // Method originalMethod = class_getClassMethod(class, originalSelector);
    // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - <#SystemDelegate#>


#pragma mark - <#CustomDelegate#>


#pragma mark - Util

#pragma mark - Action

#pragma mark - Get


@end
