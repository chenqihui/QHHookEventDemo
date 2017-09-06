//
//  QHHookUtil.m
//  QHHookEventDemo
//
//  Created by Anakin chen on 2017/9/6.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

#import "QHHookUtil.h"

#import <objc/message.h>

#import "QHViewPathUtil.h"

@implementation QHHookUtil

- (void)dealloc {
#if DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

#pragma mark - Private

#pragma mark - Public

+ (void)swizzleMethod {
    [self swizzleTarget:[UIButton class] method:@selector(sendAction:to:forEvent:) withMethod:@selector(swizzle_sendAction:to:forEvent:)];
}

#pragma mark - <#SystemDelegate#>


#pragma mark - <#CustomDelegate#>


#pragma mark - Util

+ (void)swizzleTarget:(Class)clazz method:(SEL)origSelector withMethod:(SEL)newSelector {
    Class class = [QHHookUtil class];
    
    Method originalMethod = class_getInstanceMethod(clazz, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(clazz,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(clazz,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - Action

- (void)swizzle_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    id responder = ((UITouch *)[event allTouches].allObjects.lastObject).view;
    [QHViewPathUtil viewPath:responder];
    
    [self swizzle_sendAction:action to:target forEvent:event];
}

#pragma mark - Get


@end
