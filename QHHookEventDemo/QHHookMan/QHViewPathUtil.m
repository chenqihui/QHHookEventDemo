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
        
        UIView *superView = currentView.superview;
        if ([currentView isKindOfClass:[UITableViewCell class]] == YES) {
            while ([superView isKindOfClass:[UITableView class]] == NO && superView != nil) {
                superView = superView.superview;
            }
            UITableView *tableView = (UITableView *)superView;
            NSIndexPath *cellIndexPath = [tableView indexPathForCell:(UITableViewCell *)currentView];
            [indexPath insertString:[NSString stringWithFormat:@"/%ld:%ld", (long)cellIndexPath.section, (long)cellIndexPath.row] atIndex:0];
        }
        else if ([currentView isKindOfClass:[UICollectionViewCell class]] == YES) {
            UICollectionView *collectionView = (UICollectionView *)superView;
            NSIndexPath *cellIndexPath = [collectionView indexPathForCell:(UICollectionViewCell *)currentView];
            [indexPath insertString:[NSString stringWithFormat:@"/%ld:%ld", (long)cellIndexPath.section, (long)cellIndexPath.row] atIndex:0];
        }
        else {
            NSInteger index = [superView.subviews indexOfObject:currentView];
            [indexPath insertString:[NSString stringWithFormat:@"/%ld", (long)index] atIndex:0];
        }
        
        currentView = currentView.superview;
    }
    [indexPath insertString:@"0" atIndex:0];
    NSLog(@"%@ & %@", viewPath, indexPath);
}

#pragma mark - <#SystemDelegate#>


#pragma mark - <#CustomDelegate#>


#pragma mark - Util


#pragma mark - Action


#pragma mark - Get

/*
 id responder = sender;
 UIView *currentView = responder;
 NSMutableString *viewPath = [NSMutableString stringWithUTF8String:object_getClassName(responder)];
 NSMutableString *indexPath = [NSMutableString new];
 while (![responder isKindOfClass:[UIViewController class]] && ![responder isKindOfClass:[UIWindow class]]) {
 responder = [responder nextResponder];
 [viewPath insertString:[NSString stringWithFormat:@"%@/", [NSString stringWithUTF8String:object_getClassName(responder)]] atIndex:0];
 
 UIView *childView = currentView;
 UIView *superView = currentView.superview;
 if ([childView isKindOfClass:[UITableViewCell class]] == YES) {
 UITableView *tableView = (UITableView *)superView;
 NSIndexPath *cellIndexPath = [tableView indexPathForCell:(UITableViewCell *)childView];
 [indexPath insertString:[NSString stringWithFormat:@"/%ld:%ld", (long)cellIndexPath.section, (long)cellIndexPath.row] atIndex:0];
 }
 else if ([childView isKindOfClass:[UICollectionViewCell class]] == YES) {
 UICollectionView *collectionView = (UICollectionView *)superView;
 NSIndexPath *cellIndexPath = [collectionView indexPathForCell:(UICollectionViewCell *)childView];
 [indexPath insertString:[NSString stringWithFormat:@"/%ld:%ld", (long)cellIndexPath.section, (long)cellIndexPath.row] atIndex:0];
 }
 else {
 NSInteger index = [superView.subviews indexOfObject:childView];
 [indexPath insertString:[NSString stringWithFormat:@"/%ld", (long)index] atIndex:0];
 }
 currentView = superView;
 }
 [indexPath insertString:@"0" atIndex:0];
 NSLog(@"%@ & %@", viewPath, indexPath);
 */

@end
