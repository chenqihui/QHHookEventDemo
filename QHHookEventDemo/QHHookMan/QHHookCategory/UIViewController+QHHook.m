//
//  UIViewController+QHHook.m
//  QHHookEventDemo
//
//  Created by Anakin chen on 2017/9/8.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

#import "UIViewController+QHHook.h"

#import "QHHookUtil.h"

@implementation UIViewController (QHHook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [QHHookUtil swizzleTarget:[self class] method:@selector(viewWillAppear:) toMethod:@selector(swizzle_viewWillAppear:)];
        [QHHookUtil swizzleTarget:[self class] method:@selector(viewDidDisappear:) toMethod:@selector(swizzle_viewDidDisappear:)];
    });
}

#pragma mark - Method Swizzling

- (void)swizzle_viewWillAppear:(BOOL)animated {
    [self swizzle_viewWillAppear:animated];
    NSLog(@"%s_%s", object_getClassName(self), __FUNCTION__);
}

- (void)swizzle_viewDidDisappear:(BOOL)animated {
    [self swizzle_viewDidDisappear:animated];
    NSLog(@"%s_%s", object_getClassName(self), __FUNCTION__);
}

@end
