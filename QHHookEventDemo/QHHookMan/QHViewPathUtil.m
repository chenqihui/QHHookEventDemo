//
//  QHViewPathUtil.m
//  QHHookEventDemo
//
//  Created by Anakin chen on 2017/9/6.
//  Copyright © 2017年 AnakinChen Network Technology. All rights reserved.
//

#import "QHViewPathUtil.h"

#import <UIKit/UIKit.h>

@implementation QHViewPathUtil

- (void)dealloc {
#if DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

#pragma mark - Private


#pragma mark - Public

+ (void)viewPath:(id)sender {
    id responder = sender;
    UIView *currentView = responder;
    NSMutableString *viewPath = [NSMutableString stringWithUTF8String:object_getClassName(responder)];
    NSMutableString *indexPath = [NSMutableString new];
    while (![responder isKindOfClass:[UIViewController class]] && ![responder isKindOfClass:[UIWindow class]]) {
        responder = [responder nextResponder];
        [viewPath insertString:[NSString stringWithFormat:@"%@/", [NSString stringWithUTF8String:object_getClassName(responder)]] atIndex:0];
        
        UIView *childView = currentView;
        UIView *superView = currentView.superview;
        NSInteger index = [superView.subviews indexOfObject:childView];
        [indexPath insertString:[NSString stringWithFormat:@"/%ld", (long)index] atIndex:0];
        currentView = superView;
    }
    [indexPath insertString:@"0" atIndex:0];
    NSLog(@"%@ & %@", viewPath, indexPath);
}

#pragma mark - <#SystemDelegate#>


#pragma mark - <#CustomDelegate#>


#pragma mark - Util


#pragma mark - Action


#pragma mark - Get


@end
