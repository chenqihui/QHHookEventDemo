//
//  UITableView+QHHook.m
//  QHHookEventDemo
//
//  Created by Anakin chen on 2017/9/30.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

#import "UITableView+QHHook.h"

#import "QHHookUtil.h"

#import <objc/runtime.h>
#import <objc/message.h>

@implementation UITableView (QHHook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [QHHookUtil swizzleTarget:[self class] method:@selector(setDelegate:) toMethod:@selector(swizzle_setDelegate:)];
    });
}

#pragma mark - Method Swizzling

- (void)swizzle_setDelegate:(id <UITableViewDelegate>)delegate {
    [self swizzle_setDelegate:delegate];
    //    NSLog(@"%s_%s", object_getClassName(self), __FUNCTION__);
    
    Class class = [delegate class];
    
    SEL originalSelector = @selector(tableView:didSelectRowAtIndexPath:);
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(originalMethod),
                    method_getTypeEncoding(originalMethod));
    
    SEL swizzledSEL = NSSelectorFromString([NSString stringWithFormat:@"qhReplace_%@", NSStringFromSelector(originalSelector)]);
    class_addMethod(class, swizzledSEL, (IMP)qhReplace_tableViewDidSelectRowAtIndexPathAction, "v@:@@");
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    //如果class没有实现originalSelector，则采用replaceMethod
    if (didAddMethod) {
        //这里采用二次replaceMethod，对于新加的originalSelector与swizzled交换后，再swizzled交换originalMethod，等于，调用时候，先调了新增的，调度交换的swizzled（即不会调新增的），而swizzled调度后，再调度objc_msgSend，此时会调父类实现的Method。
        class_replaceMethod(class,
                            originalSelector,
                            method_getImplementation(swizzledMethod),
                            method_getTypeEncoding(swizzledMethod));
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void qhReplace_tableViewDidSelectRowAtIndexPathAction(id self, SEL _cmd, id tableView, id indexPath) {
    SEL originalSelector = @selector(tableView:didSelectRowAtIndexPath:);
    SEL swizzledSEL = NSSelectorFromString([NSString stringWithFormat:@"qhReplace_%@", NSStringFromSelector(originalSelector)]);
    ((void(*)(id, SEL,UITableView *, NSIndexPath *))objc_msgSend)(self, swizzledSEL, tableView, indexPath);
}

@end
